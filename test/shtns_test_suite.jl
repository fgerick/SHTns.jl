@testset "shtns_test_suite" begin

	function spat_func_test(theta, phi)
		return 1.0 + 0.01*cos(theta)  + 0.1*(3cos(theta)*cos(theta) - 1.0) +	#// Y00, Y10, Y20
		(cos(phi) + 0.3*sin(phi)) * sin(theta)	+ #// Y11
		(cos(2phi) + 0.1*sin(2phi)) * sin(theta)*sin(theta) * (7.0* cos(theta)*cos(theta) - 1.0) * 3/8 	#// Y42
	end

	nlat, nphi, lmax = 64,8,7
	cfg = SHTnsCfg(lmax, 3, 1, nlat, nphi)

	θ,ϕ = SHTns.grid(cfg)
	d = spat_func_test.(θ,ϕ')

	@test size(d) == (nlat, nphi)

	q = SHTns.analys(cfg, d)


	@test length(q) == cfg.nlm

	@test imag(q[1]) ≈ 0.0
	@test SHTns.LM(cfg,1,1) == lmax+2

	@test q[1] ≈ sqrt(4π)
	@test q[2] ≈ 0.01*sqrt(4π/3)
	@test q[3] ≈ 0.1*sqrt(16π/5)

	@test q[lmax+2] ≈ -sqrt(2π/3) + 0.3*sqrt(2π/3)*im
	@test q[LM(cfg, 4, 2)] ≈ 0.5*sqrt(2π/5) - 0.05*sqrt(2π/5)*im

	for lm=4:cfg.nlm
		if (lm != LM(cfg,1,1)) && (lm != LM(cfg,4,2))
			@test q[lm] ≈ 0.0 atol=1e-14 rtol=0
		end
	end

	d2 = SHTns.synth(cfg,q)

	@test d2 ≈ d
	
end
