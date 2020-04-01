using SHTns
using Test

@testset "SHT_example.c" begin

    lmax = 5
    mmax = 3
    mres = 1
    nphi = 10
    nlat = 32
    flags = sht_gauss

    LM(shtns, l,m)  = unsafe_load(shtns.lmidx,Cint(m/shtns.mres)) + l + 1

    shtns_use_threads(0)
    shtns_verbose(1)

    sht1=shtns_init(flags,lmax, mmax, mres, nlat, nphi)
    # nlm = unsafe_load(sht1).nlm+1
    sht=unsafe_load(sht1)

    nlm = sht.nlm
    nspat = sht.nspat
    Slm = zeros(ComplexF64,nlm)
    Tlm = zeros(ComplexF64,nlm)
    Sh = zeros(Float64,nspat)
    Th = zeros(Float64,nspat)

    Slm[LM(sht,2,0)] = 1.0

    Slm2 = copy(Slm)

    SH_to_spat(sht1, Slm, Sh)

    spat_to_SH(sht1,Sh,Slm2)

    @test Slm≈Slm2

    SHtor_to_spat(sht1, Slm,Th,Sh)

    t = [0.0]
    t2 = [0.0]


    SHqst_to_point(sht1,Tlm,Tlm,Slm, unsafe_load(sht.ct,round(Cint,nlat/3)),2pi/(mres*nphi),pointer(t2),pointer(t2),pointer(t))


    @test t[1]≈Sh[round(Int,nlat/3)]≈0.826862474446353
end
