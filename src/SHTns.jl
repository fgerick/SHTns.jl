module SHTns

using SHTns_jll
export SHTns_jll

import Base: convert, show, propertynames, getproperty

const libshtns = SHTns_jll.LibSHTns


const shtns_norm = UInt32

sht_orthonormal::shtns_norm = 0
sht_fourpi::shtns_norm = 1
sht_schmidt::shtns_norm = 2
sht_for_rotations::shtns_norm = 3


const shtns_type = UInt32
sht_gauss::shtns_type = 0
sht_auto::shtns_type = 1
sht_reg_fast::shtns_type = 2
sht_reg_dct::shtns_type = 3
sht_quick_init::shtns_type = 4
sht_reg_poles::shtns_type = 5
sht_gauss_fly::shtns_type = 6

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
        struct $(type)<:SHTnsNorm; end
        Base.convert(::Type{shtns_norm}, x::$(type)) = $(enumtype)
    end
end

abstract type SHTnsType end

for (type, enumtype) in [(:Gauss, :sht_gauss), (:RegFast, :sht_reg_fast), (:RegDCT, :sht_reg_dct), (:QuickInit, :sht_quick_init), (:RegPoles, :sht_reg_poles), (:GaussFly, :sht_gauss_fly) ] #(:Auto, :sht_auto), 
    @eval begin
        struct $(type)<:SHTnsType; end
        Base.convert(::Type{shtns_type}, x::$(type)) = $(enumtype)
    end
end

function _init_checks(shtype, lmax, mmax, mres, nlat, nphi)
    @assert lmax > 1 
    @assert nphi > 2lmax 
    @assert mmax*mres <= lmax
    @assert mres > 0 
    @assert nlat >= 32 #shtns wants nlat > 4*VSIZE2
    if typeof(shtype) <: Union{Gauss, GaussFly, QuickInit} 
        @assert nlat > lmax
    else
        @assert nlat > 2lmax
    end
end

mutable struct SHTnsCfg{N<:SHTnsNorm, T<:SHTnsType}
    cfg::Ptr{shtns_info}
    norm::N
    type::T
    csphase::Bool

    function SHTnsCfg(shtype::T, lmax, mmax, mres, nlat, nphi) where T<:SHTnsType
        _init_checks(shtype, lmax, mmax, mres, nlat, nphi)
        cfg = shtns_init(shtype,lmax, mmax, mres, nlat, nphi)
        stream = new{Orthonormal, T}(cfg, Orthonormal(), shtype, true)
        finalizer(x->shtns_destroy(x.cfg), stream)
        return stream
    end
    function SHTnsCfg(shtype::T,lmax, mmax, mres, nlat, nphi, norm::N; eps=1e-10, csphase=true) where {T<:SHTnsType, N<:SHTnsNorm}
        norm = csphase ? norm : convert(shtns_norm,norm) + SHT_NO_CS_PHASE
        _init_checks(shtype, lmax, mmax, mres, nlat, nphi)
        cfg = shtns_create(lmax, mmax, mres, norm)
        shtns_set_grid(cfg, shtype, eps, nlat, nphi)
        stream = new{N,T}(cfg, norm, shtype, csphase)
        finalizer(x->shtns_destroy(x.cfg), stream)
        return stream
    end
 end

SHTnsCfg(lmax, mmax, mres, nlat, nphi) = SHTnsCfg(QuickInit(), lmax, mmax, mres, nlat, nphi) 

 function Base.propertynames(::SHTnsCfg, private::Bool=false)
    publicnames =   (:nlm, :lmax, :mmax, :mres, :nlat_2, :nlat, :nphi, 
                    :nspat, :li, :mi, :ct, :st, :nlat_padded, :nlm_cplx, :norm, :type)
    privatenames = (:cfg, )
    if private
        return (publicnames..., privatenames...)
    else
        return publicnames
    end
end

function Base.getproperty(cfg::SHTnsCfg, p::Symbol)
    if p ∈ (:nlm, :lmax, :mmax, :mres, :nlat_2, :nlat, :nphi, 
        :nspat, :nlat_padded, :nlm_cplx) 
        return Int(getproperty(unsafe_load(cfg.cfg),p))
    elseif p ∈ (:li, :mi)
        info = unsafe_load(cfg.cfg)
        u = Vector{Int}(unsafe_wrap(Vector{Cushort},getproperty(info,p),Int(info.nlm)))
        return u
    elseif p ∈ (:ct, :st)
        info = unsafe_load(cfg.cfg)
        u = Vector{Float64}(unsafe_wrap(Vector{Cdouble},getproperty(info,p),Int(info.nlat)))
        return u
    elseif p ∈ (:norm, :type)
        return getfield(cfg, p)
    else
        return getfield(cfg, p)
    end
end

function Base.show(io::IO, mime::MIME{Symbol("text/plain")}, cfg::SHTnsCfg)
    summary(io, cfg); println(io)
    # show(io, mime, cfg.lmax)
    println(io, "lmax: ", cfg.lmax, ", mmax: ", cfg.mmax, ", mres: ", cfg.mres, ", nlat: ", cfg.nlat, ", nphi: ", cfg.nphi)
end


const shtns_cfg = Ptr{shtns_info}

export SHTnsCfg

const cplx = ComplexF64

const cplx_f = ComplexF64

mutable struct shtns_rot_ end

const shtns_rot = Ptr{shtns_rot_}

const SHTNS_INTERFACE = 0x00030500
const SHT_NO_CS_PHASE = 256 * 4
const SHT_REAL_NORM = 256 * 8
const SHT_NATIVE_LAYOUT = 0
const SHT_THETA_CONTIGUOUS = 256
const SHT_PHI_CONTIGUOUS = 256 * 2
const SHT_SOUTH_POLE_FIRST = 256 * 32
const SHT_SCALAR_ONLY = 256 * 16
const SHT_LOAD_SAVE_CFG = 256 * 64
const SHT_ALLOW_GPU = 256 * 128
const SHT_ALLOW_PADDING = 256 * 256

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
