module SHTns

using SHTns_jll
export SHTns_jll

const libshtns = SHTns_jll.LibSHTns

using CEnum

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

const cplx = ComplexF32

const cplx_f = ComplexF32

mutable struct shtns_rot_ end

const shtns_rot = Ptr{shtns_rot_}

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
export LM
# LM(shtns, l,m)  = ( (((((unsigned short)(m))/shtns->mres)*(2*shtns->lmax + 2 - ((m)+shtns->mres)))>>1) + (l) )
LM(shtns, l,m)  = (Cint(m/shtns.mres)*(2*shtns.lmax + 2 - (m+shtns.mres)))>>1 + l + 1

end # module
