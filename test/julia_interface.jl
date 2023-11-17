@testset "synth and analys allocfree" begin

	L = 10
	cfg = SHTnsCfg(L)

	theta, phi = grid(cfg)

	y = cos.(theta)*sin.(phi)'

	x = SHTns.analys(cfg, y)


	#test no-allocations
	@test (@allocated SHTns.synth!(cfg,x,y)) == 0
	@test (@allocated SHTns.analys!(cfg,y,x)) == 0

end