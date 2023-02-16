module SHTns

using SHTns_jll
export SHTns_jll

const libshtns = SHTns_jll.LibSHTns

using CEnum

@cenum shtns_norm::UInt32 begin
    sht_orthonormal = 0
    sht_fourpi = 1
    sht_schmidt = 2
    sht_for_rotations = 3
end

@cenum shtns_type::UInt32 begin
    sht_gauss = 0
    sht_auto = 1
    sht_reg_fast = 2
    sht_reg_dct = 3
    sht_quick_init = 4
    sht_reg_poles = 5
    sht_gauss_fly = 6
end

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

const shtns_cfg = Ptr{shtns_info}

struct SHTnsConfig
    cfg::shtns_cfg
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
end

function SHTnsConfig(cfg::shtns_cfg) 
    info = unsafe_load(cfg)
    li = Vector{Int}(unsafe_wrap(Vector{Cushort},info.li,Int(info.nlm)))
    mi = Vector{Int}(unsafe_wrap(Vector{Cushort},info.mi,Int(info.nlm)))
    ct = unsafe_wrap(Vector{Float64},info.ct,Int(info.nlat))
    st = unsafe_wrap(Vector{Float64},info.st,Int(info.nlat))

    SHTnsConfig(cfg,
            Int(info.nlm),
            Int(info.lmax),
            Int(info.mmax),
            Int(info.mres),
            Int(info.nlat_2),
            Int(info.nlat),
            Int(info.nphi),
            Int(info.nspat),
            li,
            mi,
            ct,
            st,
            Int(info.nlat_padded),
            Int(info.nlm_cplx)
    )
end


function SHTnsConfig(shtype::shtns_type,lmax, mmax, mres, nlat, nphi) 
    return SHTnsConfig(shtns_init(shtype,lmax, mmax, mres, nlat, nphi))
end

function SHTnsConfig(shtype::shtns_type,lmax, mmax, mres, nlat, nphi, norm::shtns_norm; eps::Float64=1e-10) 
    cfg = shtns_create(lmax, mmax, mres, norm)
    shtns_set_grid(cfg, shtype, eps, nlat, nphi)
    return SHTnsConfig(cfg)
end

function SHTnsConfig(lmax, mmax, mres, norm::shtns_norm)
    cfg = shtns_create(lmax, mmax, mres, norm)
    SHTnsConfig(cfg)
end

export SHTnsConfig

const cplx = ComplexF64

const cplx_f = ComplexF64

mutable struct shtns_rot_ end

const shtns_rot = Ptr{shtns_rot_}


# abstract type SHNorm end

# struct OrthonormalNorm <: SHNorm; end
# struct FourPiNorm <: SHNorm; end
# struct SchmidtNorm <: SHNorm; end
# struct RotationNorm <: SHNorm; end

# OrthonormalNorm() = sht_orthonormal
# FourPiNorm() = sht_fourpi
# SchmidtNorm() = sht_schmidt
# RotationNorm() = sht_for_rotations

# export SHNorm, OrthonormalNorm, FourPiNorm, SchmidtNorm, RotationNorm

# abstract type SHT end

# struct SHGauss <: SHT; end
# struct SHAuto <: SHT; end
# struct SHRegFast <: SHT; end
# struct SHRegDct <: SHT; end
# struct SHQuickInit <: SHT; end
# struct SHRegPoles <: SHT; end
# struct SHGaussFly <: SHT; end

# SHGauss() = sht_gauss
# SHAuto() = sht_auto
# SHRegFast() = sht_reg_fast
# SHRegDct() = sht_reg_dct
# SHQuickInit() = sht_quick_init
# SHRegPoles() = sht_reg_poles
# SHGaussFly() = sht_gauss_fly

# export SHT, SHGauss, SHAuto, SHRegFast, SHRegDct, SHQuickInit, SHRegPoles, SHGaussFly



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

#export most functions
foreach(names(@__MODULE__, all=true)) do s
    if startswith(string(s), "sht") || startswith(string(s), "SH") || startswith(string(s), "spat")
        @eval export $s
    end
 end
 
#sht macros
#  LM(shtns, l,m)  = unsafe_load(shtns.lmidx,Cint(m/shtns.mres)) + l + 1
# LM(shtns, l,m)  = ( (((((unsigned short)(m))/shtns->mres)*(2*shtns->lmax + 2 - ((m)+shtns->mres)))>>1) + (l) )
function LM(shtns, l,m)  
    @assert 0<=m<=l
    return (Cint(m/shtns.mres)*(2*shtns.lmax + 2 - (m+shtns.mres)))>>1 + l + 1
end

function LM_cplx(shtns, l, m)   
    return (l <= shtns.mmax) ? l*(l+1)+m : shtns.mmax*(2l - shtns.mmax) + l+m
end

export LM, LM_cplx

end # module
