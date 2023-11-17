@testset "tools" begin
	L = 10
	cfg = SHTnsCfg(L)
	theta, phi = grid(cfg)
	weights = gauss_weights(cfg)
	x = cos.(theta)
	@test x.^2 ⋅ weights ≈ 2/3 # = ∫₋₁¹ x² dx

end