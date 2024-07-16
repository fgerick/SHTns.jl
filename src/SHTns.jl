module SHTns

using SHTns_jll
#to use system build SHTns library (needs to be a shared library)
# e.g. using 
# gcc -lfftw3 -lfftw3_omp -fopenmp -shared libshtns.so *.o 
const libshtns = Ref{String}()

function __init__()
    if haskey(ENV, "SHTNS_PATH")
        libshtns[] = ENV["SHTNS_PATH"]
    else
        libshtns[] = SHTns_jll.LibSHTns
    end
end


# using SHTns_jll
# export SHTns_jll

import Base: convert, show, propertynames, getproperty


const shtns_norm = UInt32

const sht_orthonormal = shtns_norm(0)
const sht_fourpi = shtns_norm(1)
const sht_schmidt = shtns_norm(2)
const sht_for_rotations = shtns_norm(3)


const shtns_type = UInt32
const sht_gauss = shtns_type(0)
const sht_auto = shtns_type(1)
const sht_reg_fast = shtns_type(2)
const sht_reg_dct = shtns_type(3)
const sht_quick_init = shtns_type(4)
const sht_reg_poles = shtns_type(5)
const sht_gauss_fly = shtns_type(6)

struct shtns_info
    nlm::Cuint
    lmax::Cushort
    mmax::Cushort
    mres::Cushort
    nlat_2::Cushort
    nlat::Cuint
    nphi::Cuint
    nspat::Cuint
    li::Ptr{Cushort}
    mi::Ptr{Cushort}
    ct::Ptr{Cdouble}
    st::Ptr{Cdouble}
    nlat_padded::Cuint
    nlm_cplx::Cuint
end

abstract type SHTnsNorm end


for (type, enumtype) in [(:Orthonormal, :sht_orthonormal), (:FourPi, :sht_fourpi), (:Schmidt, :sht_schmidt), (:ForRotations, :sht_for_rotations)]
    @eval begin
        """
            struct $($(type)) <: SHTnsNorm
        
        """
        Base.@kwdef struct $(type)<:SHTnsNorm 
            cs_phase::Bool=true
        end

        function Base.convert(::Type{shtns_norm}, x::$(type))
            norm = $(enumtype)
            !x.cs_phase && (norm += SHT_NO_CS_PHASE)
            return norm
        end
    end
end

abstract type SHTnsType end

for (type, enumtype) in [(:Gauss, :sht_gauss), (:RegFast, :sht_reg_fast), (:RegDCT, :sht_reg_dct), (:QuickInit, :sht_quick_init), (:RegPoles, :sht_reg_poles), (:GaussFly, :sht_gauss_fly) ] #(:Auto, :sht_auto), 
    @eval begin
        """
            struct $($(type)) <: SHTnsType
        
        """
        Base.@kwdef struct $(type)<:SHTnsType
            contiguous_lat::Bool=false
            contiguous_phi::Bool=false
            padding::Bool=false
        end

        function Base.convert(::Type{shtns_type}, x::$(type)) 
            shtype = $(enumtype) 
            x.contiguous_lat && (shtype += SHT_THETA_CONTIGUOUS)
            x.contiguous_phi && (shtype += SHT_PHI_CONTIGUOUS) 
            x.padding && (shtype += SHT_ALLOW_PADDING)
            return shtype
        end
    end
end

function _init_checks(shtype, lmax, mmax, mres, nlat, nphi)
    @assert lmax > 1 
    @assert mmax*mres <= lmax
    @assert mres > 0 
    @assert nlat >= 16 # shtns wants nlat > 4*VSIZE2
    @assert nphi > 2mmax # sampling theorem
    if typeof(shtype) <: Union{Gauss, GaussFly, QuickInit} 
        @assert nlat > lmax
    else
        @assert nlat > 2lmax
    end
end

"""
    mutable struct SHTnsCfg{N<:SHTnsNorm, T<:SHTnsType}

Configuration of spherical harmonic transform.
"""
mutable struct SHTnsCfg{N<:SHTnsNorm, T<:SHTnsType}
    cfg::Ptr{shtns_info}
    norm::N
    shtype::T
    robert_form::Bool
    nlm::Int
    lmax::Int
    mmax::Int
    mres::Int
    nlat_2::Int
    nlat::Int
    nphi::Int
    nspat::Int
    li::Vector{Int}
    mi::Vector{Int}
    ct::Vector{Float64}
    st::Vector{Float64}
    nlat_padded::Int
    nlm_cplx::Int
    function SHTnsCfg(lmax, mmax, mres, nlat, nphi; 
                        shtype::T=QuickInit(), 
                        norm::N=Orthonormal(), 
                        eps=1e-10, 
                        robert_form=false,
                        ) where {T<:SHTnsType, N<:SHTnsNorm}

        _init_checks(shtype, lmax, mmax, mres, nlat, nphi)
        cfg = shtns_create(lmax, mmax, mres, norm)
        robert_form && shtns_robert_form(cfg,1)
        shtns_set_grid(cfg, shtype, eps, nlat, nphi)
        info = unsafe_load(cfg)
        li = Vector{Int}(unsafe_wrap(Vector{Cushort},info.li,Int(info.nlm)))
        mi = Vector{Int}(unsafe_wrap(Vector{Cushort},info.mi,Int(info.nlm)))
        ct = Vector{Float64}(unsafe_wrap(Vector{Cdouble},info.ct,Int(info.nlat)))
        st = Vector{Float64}(unsafe_wrap(Vector{Cdouble},info.st,Int(info.nlat)))
        stream = new{N,T}(cfg, norm, shtype, robert_form, info.nlm, info.lmax, info.mmax, info.mres, info.nlat_2, info.nlat, info.nphi, info.nspat, li, mi, ct, st, info.nlat_padded, info.nlm_cplx)
        finalizer(x->shtns_destroy(x.cfg), stream)
        return stream
    end
    function SHTnsCfg(lmax, mmax=lmax, mres=1; 
        shtype::T=QuickInit(), 
        norm::N=Orthonormal(), 
        eps=1e-10, 
        robert_form=false,
        nl_order = 0,
        ) where {T<:SHTnsType, N<:SHTnsNorm}

        @assert lmax > 1 
        @assert mmax*mres <= lmax
        @assert mres > 0 

        cfg = shtns_create(lmax, mmax, mres, norm)
        robert_form && shtns_robert_form(cfg,1)
        info = unsafe_load(cfg)
        shtns_set_grid_auto(cfg, shtype, eps, nl_order, Ref(info.nlat), Ref(info.nphi))
        info = unsafe_load(cfg)
        li = Vector{Int}(unsafe_wrap(Vector{Cushort},info.li,Int(info.nlm)))
        mi = Vector{Int}(unsafe_wrap(Vector{Cushort},info.mi,Int(info.nlm)))
        ct = Vector{Float64}(unsafe_wrap(Vector{Cdouble},info.ct,Int(info.nlat)))
        st = Vector{Float64}(unsafe_wrap(Vector{Cdouble},info.st,Int(info.nlat)))
        stream = new{N,T}(cfg, norm, shtype, robert_form, info.nlm, info.lmax, info.mmax, info.mres, info.nlat_2, info.nlat, info.nphi, info.nspat, li, mi, ct, st, info.nlat_padded, info.nlm_cplx)
        finalizer(x->shtns_destroy(x.cfg), stream)
        return stream
    end

 end


#  function Base.propertynames(::SHTnsCfg, private::Bool=false)
#     publicnames =   (:nlm, :lmax, :mmax, :mres, :nlat_2, :nlat, :nphi, 
#                     :nspat, :li, :mi, :ct, :st, :nlat_padded, :nlm_cplx, :norm, :type, :robert_form)
#     privatenames = (:cfg, )
#     if private
#         return (publicnames..., privatenames...)
#     else
#         return publicnames
#     end
# end

function Base.show(io::IO, mime::MIME{Symbol("text/plain")}, cfg::SHTnsCfg)
    summary(io, cfg); println(io)
    println(io, "lmax: ", cfg.lmax, ", mmax: ", cfg.mmax, ", mres: ", cfg.mres, ", nlat: ", cfg.nlat, ", nphi: ", cfg.nphi)
end


const shtns_cfg = Ptr{shtns_info}

export SHTnsCfg

const cplx = ComplexF64

const cplx_f = ComplexF64

mutable struct shtns_rot_ end

const shtns_rot = Ptr{shtns_rot_}

const SHTNS_INTERFACE = UInt32(0x00030500)
const SHT_NO_CS_PHASE = UInt32(256 * 4)
const SHT_REAL_NORM = UInt32(256 * 8)
const SHT_NATIVE_LAYOUT = UInt32(0)
const SHT_THETA_CONTIGUOUS = UInt32(256)
const SHT_PHI_CONTIGUOUS = UInt32(256 * 2)
const SHT_SOUTH_POLE_FIRST = UInt32(256 * 32)
const SHT_SCALAR_ONLY = UInt32(256 * 16)
const SHT_LOAD_SAVE_CFG = UInt32(256 * 64)
const SHT_ALLOW_GPU = UInt32(256 * 128)
const SHT_ALLOW_PADDING = UInt32(256 * 256)

include("sht.jl")
include("tools.jl")
include("synth.jl")
include("analys.jl")


#export most functions
foreach(names(@__MODULE__, all=true)) do s
    if startswith(string(s), "sht") || startswith(string(s), "SH") || startswith(string(s), "spat")
        @eval export $s
    end
 end
 
end # module
