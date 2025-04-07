@testset "synth and analys allocfree" begin

	L = 10
	cfg = SHTnsCfg(L)

	theta, phi = grid(cfg)

	y = cos.(theta)*sin.(phi)'

	x = SHTns.analys(cfg, y)


	#test no-allocations
	@test (@allocated SHTns.synth!(cfg,x,y)) == 0
	@test (@allocated SHTns.analys!(cfg,y,x)) == 0

	y = complex(y)
	cfg = SHTnsCfg(L; transform=Complex)
	x = SHTns.analys(cfg, y)

	@test (@allocated SHTns.analys!(cfg,y,x)) == 0
	@test (@allocated SHTns.synth!(cfg,x,y)) == 0

end

@testset "synth and analys" begin

	L = 32
	cfg = SHTnsCfg(L)

	for transform in (Real, Complex)
		cfg = SHTnsCfg(L; transform)
		q = zeros(ComplexF64, nlm(cfg))
		q[2:5] .= 1.0
		s = t = q

		
		x = synth(cfg, q)
		@test SHTns.analys(cfg, x) ≈ q

		x,y = synth(cfg, q,s) 
		_q,_s = SHTns.analys(cfg, x,y)
		@test _q ≈ q
		@test _s ≈ s
		
		x,y,z = synth(cfg, q,s,t) 
		_q,_s,_t = SHTns.analys(cfg, x,y,z)
		@test _q ≈ q
		@test _s ≈ s
		@test _t ≈ t
	end
	
end

@testset "synth and analys batched" begin

	L = 32
	howmany = 10

	for transform in (Real, ) #Complex not working
		cfg = SHTnsCfg(L; howmany, transform)
	
		q = zeros(ComplexF64, howmany*nlm(cfg))
		for i in 0:howmany-1
			q[nlm(cfg)*i .+ 2:5] .= (i+1)*1.0 
		end
		s = t = q

		
		x = synth(cfg, q)
		@test SHTns.analys(cfg, x) ≈ q
		# @test SHTns.synth(cfg, q) ≈ x

		x,y = synth(cfg, q,s) 
		_q,_s = SHTns.analys(cfg, x,y)
		@test _q ≈ q
		@test _s ≈ s
		
		x,y,z = synth(cfg, q,s,t) 
		_q,_s,_t = SHTns.analys(cfg, x,y,z)
		@test _q ≈ q
		@test _s ≈ s
		@test _t ≈ t
	end
	
end

@testset "contiguous_lat vs. contiguous_phi" begin

	L = 32
	
	for transform in (Real,Complex), shtype in (SHTns.QuickInit(; contiguous_lat=true), SHTns.QuickInit(; contiguous_phi=true))
		cfg = SHTnsCfg(L; transform, shtype)
	
		q = zeros(ComplexF64, nlm(cfg))
		q[2:5] .= 1.0 
		s = t = q

		
		x = synth(cfg, q)
		@test SHTns.analys(cfg, x) ≈ q
		# @test SHTns.synth(cfg, q) ≈ x

		x,y = synth(cfg, q,s) 
		_q,_s = SHTns.analys(cfg, x,y)
		@test _q ≈ q
		@test _s ≈ s
		
		x,y,z = synth(cfg, q,s,t) 
		_q,_s,_t = SHTns.analys(cfg, x,y,z)
		@test _q ≈ q
		@test _s ≈ s
		@test _t ≈ t
	end
	
end

