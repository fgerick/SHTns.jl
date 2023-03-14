function synth(cfg::SHTnsCfg, qlm::Vector{ComplexF64})
	@assert cfg.nlat != 0
	@assert length(qlm) == cfg.nlm
	v = Matrix{Float64}(undef, cfg.nlat, cfg.nphi)
	synth!(cfg,qlm,v)
	return v
end

function synth_cplx(cfg::SHTnsCfg, qlm::Vector{ComplexF64})
	@assert cfg.nlat != 0
	@assert length(qlm) == cfg.nlm_cplx
	@assert cfg.lmax == cfg.mmax
	v = Matrix{ComplexF64}(undef, cfg.nlat, cfg.nphi)
	synth!(cfg,qlm,v)
	return v
end

function synth(cfg::SHTnsCfg,  slm::Vector{ComplexF64}, tlm::Vector{ComplexF64})
	@assert cfg.nlat != 0
	@assert length(slm) == length(tlm) == cfg.nlm
	utheta = Matrix{Float64}(undef, cfg.nlat, cfg.nphi)
	uphi = Matrix{Float64}(undef, cfg.nlat, cfg.nphi)
	synth!(cfg, slm, tlm, utheta, uphi)
	return utheta, uphi
end

function synth_cplx(cfg::SHTnsCfg,  slm::Vector{ComplexF64}, tlm::Vector{ComplexF64})
	@assert cfg.nlat != 0
	@assert length(slm) == length(tlm) == cfg.nlm_cplx
	@assert cfg.lmax == cfg.mmax
	utheta = Matrix{ComplexF64}(undef, cfg.nlat, cfg.nphi)
	uphi = Matrix{ComplexF64}(undef, cfg.nlat, cfg.nphi)
	synth!(cfg, slm, tlm, utheta, uphi)
	return utheta, uphi
end

function synth(cfg::SHTnsCfg,  qlm::Vector{ComplexF64}, slm::Vector{ComplexF64}, tlm::Vector{ComplexF64})
	@assert cfg.nlat != 0
	@assert length(qlm) == length(slm) == length(tlm) == cfg.nlm
	ur = Matrix{Float64}(undef, cfg.nlat, cfg.nphi)
	utheta = Matrix{Float64}(undef, cfg.nlat, cfg.nphi)
	uphi = Matrix{Float64}(undef, cfg.nlat, cfg.nphi)
	synth!(cfg, qlm, slm, tlm, ur, utheta, uphi)
	return ur, utheta, uphi
end

function synth_cplx(cfg::SHTnsCfg,  qlm::Vector{ComplexF64}, slm::Vector{ComplexF64}, tlm::Vector{ComplexF64})
	@assert cfg.nlat != 0
	@assert length(qlm) == length(slm) == length(tlm) == cfg.nlm_cplx
	@assert cfg.lmax == cfg.mmax
	ur = Matrix{ComplexF64}(undef, cfg.nlat, cfg.nphi)
	utheta = Matrix{ComplexF64}(undef, cfg.nlat, cfg.nphi)
	uphi = Matrix{ComplexF64}(undef, cfg.nlat, cfg.nphi)
	synth!(cfg, qlm, slm, tlm, ur, utheta, uphi)
	return ur, utheta, uphi
end

function synth!(cfg::SHTnsCfg, qlm::Vector{ComplexF64}, v::Matrix{Float64})
	SH_to_spat(cfg.cfg,qlm,v)
	return v
end

function synth!(cfg::SHTnsCfg, qlm::Vector{ComplexF64}, v::Matrix{ComplexF64})
	SH_to_spat_cplx(cfg.cfg,qlm,v)
	return v
end

function synth!(cfg::SHTnsCfg, slm::Vector{ComplexF64}, tlm::Vector{ComplexF64}, utheta::Matrix{Float64}, uphi::Matrix{Float64})
	SHsphtor_to_spat(cfg.cfg, slm, tlm, utheta, uphi)
	return utheta, uphi
end

function synth!(cfg::SHTnsCfg, slm::Vector{ComplexF64}, tlm::Vector{ComplexF64}, utheta::Matrix{ComplexF64}, uphi::Matrix{ComplexF64})
	SHsphtor_to_spat_cplx(cfg.cfg, slm, tlm, utheta, uphi)
	return utheta, uphi
end

function synth!(cfg::SHTnsCfg, qlm::Vector{ComplexF64}, slm::Vector{ComplexF64}, tlm::Vector{ComplexF64}, ur::Matrix{Float64}, utheta::Matrix{Float64}, uphi::Matrix{Float64})
	SHqst_to_spat(cfg.cfg, qlm, slm, tlm, ur, utheta, uphi)
	return ur, utheta, uphi
end

function synth!(cfg::SHTnsCfg, qlm::Vector{ComplexF64}, slm::Vector{ComplexF64}, tlm::Vector{ComplexF64}, ur::Matrix{ComplexF64}, utheta::Matrix{ComplexF64}, uphi::Matrix{ComplexF64})
	SHqst_to_spat_cplx(cfg.cfg, qlm, slm, tlm, ur, utheta, uphi)
	return ur, utheta, uphi
end