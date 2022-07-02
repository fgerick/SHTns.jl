using SHTns
using Test

@testset "SHT_example.c" begin

    lmax = 5
    mmax = 3
    mres = 1
    nphi = 10
    nlat = 32
    flags = sht_gauss


    shtns_use_threads(0)
    shtns_verbose(1)

    # sht1 = shtns_init(flags,lmax, mmax, mres, nlat, nphi)
    sht = SHTnsConfig(flags, lmax, mmax, mres, nlat, nphi)

    # sht=unsafe_load(sht1)

    Slm = zeros(ComplexF64,sht.nlm)
    Tlm = zeros(ComplexF64,sht.nlm)
    Sh = zeros(Float64,sht.nlat,sht.nphi)
    Th = zeros(Float64,sht.nlat,sht.nphi)

    Slm[LM(sht,2,0)] = 1.0

    Slm2 = copy(Slm)

    SH_to_spat(sht.cfg, Slm, Sh)

    spat_to_SH(sht.cfg,Sh,Slm2)

    @test Slm≈Slm2

    SHtor_to_spat(sht.cfg, Slm,Th,Sh)

    t = [0.0]
    t2 = [0.0]


    SHqst_to_point(sht.cfg,Tlm,Tlm,Slm, sht.ct[round(Int,nlat/3)],2pi/(mres*nphi),t2,t2,t)


    @test t[1]≈Sh[round(Int,nlat/3)]≈0.826862474446353
end
