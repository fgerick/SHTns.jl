module SHTns

using CEnum
# export
const libshtns = :libshtns

struct shtns_info
    nlm::Int32
    lmax::Int16
    mmax::Int16
    mres::Int16
    nphi::Int16
    nlat::Int16
    nlat_2::Int16
    lmidx::Ptr{Cint}
    li::Ptr{UInt16}
    mi::Ptr{UInt16}
    ct::Ptr{Cdouble}
    st::Ptr{Cdouble}
    nspat::Int32
    nlm_cplx::Int32
end

const shtns_cfg = Ptr{shtns_info}
const shtns_rot_ = Cvoid
const shtns_rot = Ptr{shtns_rot_}

@cenum shtns_norm::Int32 begin
    sht_orthonormal = 0
    sht_fourpi = 1
    sht_schmidt = 2
    sht_for_rotations = 3
end

@cenum shtns_type::Int32 begin
    sht_gauss = 0
    sht_auto = 1
    sht_reg_fast = 2
    sht_reg_dct = 3
    sht_quick_init = 4
    sht_reg_poles = 5
    sht_gauss_fly = 6
end

#include generated api
include("libshtns_api.jl")

#export most functions
foreach(names(@__MODULE__, all=true)) do s
   if startswith(string(s), "sht") || startswith(string(s), "SH") || startswith(string(s), "spat")
       @eval export $s
   end
end

#sht macros
LM(shtns, l,m)  = unsafe_load(shtns.lmidx,Cint(m/shtns.mres)) + l + 1

export LM

end # module
