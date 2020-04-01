# Automatically generated using Clang.jl

#
# struct shtns_info
#     nlm::UInt32
#     lmax::UInt16
#     mmax::UInt16
#     mres::UInt16
#     nphi::UInt16
#     nlat::UInt16
#     nlat_2::UInt16
#     lmidx::Ptr{Cint}
#     li::Ptr{UInt16}
#     mi::Ptr{UInt16}
#     ct::Ptr{Cdouble}
#     st::Ptr{Cdouble}
#     nspat::UInt32
#     nlm_cplx::UInt32
# end

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
