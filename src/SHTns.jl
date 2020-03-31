module SHTns

export shtns_type, shtns_norm, sht_auto
# package code goes here
const libshtns = "/Users/gerickf/Programs/shtns/libshtns"

@enum shtns_type sht_gauss sht_auto sht_reg_fast sht_reg_dct sht_quick_init sht_reg_poles sht_gauss_fly
@enum shtns_norm sht_orthonormal sht_fourpi sht_schmidt

struct Info    # allow read-only access to some data (useful for optimization and helper macros)
   nlm    :: Int
   lmax   :: Int
   mmax   :: Int
   mres   :: Int
   nphi   :: Int
   nlat   :: Int
   nlat_2 :: Int
   lmidx :: Int
   li :: Int
   mi :: Int
   ct :: Float64
   st :: Float64
   nspat    :: Int
   nlm_cplx :: Int
end

function init(flags::shtns_type, lmax::Int, mmax::Int, mres::Int, nlat::Int, nphi::Int) :: Info
  return ccall((:shtns_init,libshtns),Info,(shtns_type, Int, Int, Int, Int, Int, ), flags, lmax, mmax, mres, nlat, nphi)
end

function create(lmax::Int, mmax::Int, mres::Int, norm::shtns_norm) :: Info
  return ccall((:shtns_init,libshtns),Info,(Int, Int, Int, shtns_norm, ), lmax, mmax, mres, norm)
end
end # module
