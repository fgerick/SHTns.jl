using SHTns
using Test

@testset "SHT_example.c" begin

    lmax = 5
    mmax = 3
    mres = 1
    nphi = 16
    nlat = 32
    shtype = SHTns.Gauss()


    shtns_use_threads(1)
    shtns_verbose(1)

    # sht1 = shtns_init(flags,lmax, mmax, mres, nlat, nphi)
    sht = SHTnsCfg(shtype, lmax, mmax, mres, nlat, nphi)

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

    # shtns_destroy(sht.cfg)
end

@testset "SHT norms" begin

    lmax = 5
    mmax = 3
    mres = 1
    nphi = 16
    nlat = 32
    shtype = SHTns.Gauss()


    shtns_use_threads(0)
    shtns_verbose(1)

    # sht1 = shtns_init(flags,lmax, mmax, mres, nlat, nphi)
    norms = [SHTns.Orthonormal(), SHTns.FourPi(), SHTns.Schmidt()] #sht_orthonormal, sht_fourpi, sht_schmidt]
    shts = [SHTnsCfg(shtype, lmax, mmax, mres, nlat, nphi, norm) for norm in norms]

    # sht=unsafe_load(sht1)
    for l in 1:lmax
        Slms = [zeros(ComplexF64,sht.nlm) for sht in shts]
        Shs = [zeros(Float64,sht.nlat,sht.nphi) for sht in shts]
        lmfacs = [1.0, 1/sqrt(4π), sqrt((2l+1)/4π)] 
        for (Slm,Sh,sht, fac) in zip(Slms, Shs,shts, lmfacs)
            Slm[LM(sht,l,0)] = fac
            Slm2 = copy(Slm)

            SH_to_spat(sht.cfg, Slm, Sh)

            spat_to_SH(sht.cfg,Sh,Slm2)

            @test Slm≈Slm2
        end
        @test all(isapprox(first(Shs)),Shs)
    end

    # for sht in shts
    #     shtns_destroy(sht.cfg)
    # end
    
end
