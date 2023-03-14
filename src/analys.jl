function analys(cfg::SHTnsCfg, v::Matrix{Float64})
	@assert cfg.nlat != 0
	qlm = Vector{ComplexF64}(undef, cfg.nlm)
	analys!(cfg,v,qlm)
	return qlm
end

function analys(cfg::SHTnsCfg, v::Matrix{ComplexF64})
	@assert cfg.nlat != 0
	qlm = Vector{ComplexF64}(undef, cfg.nlm_cplx)
	analys!(cfg,v,qlm)
	return qlm
end

function analys(cfg::SHTnsCfg, utheta::Matrix{Float64}, uphi::Matrix{Float64})
	@assert cfg.nlat != 0
	slm = Vector{ComplexF64}(undef, cfg.nlm)
	tlm = Vector{ComplexF64}(undef, cfg.nlm)
	analys!(cfg, utheta, uphi, slm, tlm)
	return slm, tlm
end

function analys(cfg::SHTnsCfg, utheta::Matrix{ComplexF64}, uphi::Matrix{ComplexF64})
	@assert cfg.nlat != 0
	slm = Vector{ComplexF64}(undef, cfg.nlm_cplx)
	tlm = Vector{ComplexF64}(undef, cfg.nlm_cplx)
	analys!(cfg, utheta, uphi, slm, tlm)
	return slm, tlm
end

function analys(cfg::SHTnsCfg, ur::Matrix{Float64}, utheta::Matrix{Float64}, uphi::Matrix{Float64})
	@assert cfg.nlat != 0
	qlm = Vector{ComplexF64}(undef, cfg.nlm)
	slm = Vector{ComplexF64}(undef, cfg.nlm)
	tlm = Vector{ComplexF64}(undef, cfg.nlm)
	analys!(cfg, ur, utheta, uphi, qlm, slm, tlm)
	return qlm, slm, tlm
end

function analys(cfg::SHTnsCfg, ur::Matrix{ComplexF64}, utheta::Matrix{ComplexF64}, uphi::Matrix{ComplexF64})
	@assert cfg.nlat != 0
	qlm = Vector{ComplexF64}(undef, cfg.nlm_cplx)
	slm = Vector{ComplexF64}(undef, cfg.nlm_cplx)
	tlm = Vector{ComplexF64}(undef, cfg.nlm_cplx)
	analys!(cfg, ur, utheta, uphi, qlm, slm, tlm)
	return qlm, slm, tlm
end

analys!(cfg::SHTnsCfg, v::AbstractMatrix{Float64}, qlm::AbstractVector{ComplexF64}) = spat_to_SH(cfg.cfg,v,qlm)
analys!(cfg::SHTnsCfg, v::AbstractMatrix{ComplexF64}, qlm::AbstractVector{ComplexF64}) = spat_cplx_to_SH(cfg.cfg,v,qlm)

analys!(cfg::SHTnsCfg, utheta::T, uphi::T, slm, tlm) where {T<:AbstractMatrix{Float64}} = spat_to_SHsphtor(cfg.cfg,utheta,uphi,slm,tlm)
analys!(cfg::SHTnsCfg,  utheta::T, uphi::T, slm, tlm) where {T<:AbstractMatrix{ComplexF64}} = spat_cplx_to_SHsphtor(cfg.cfg,utheta,uphi,slm,tlm)

analys!(cfg::SHTnsCfg, ur::T, utheta::T, uphi::T, qlm::Tc, slm::Tc, tlm::Tc) where {T<:AbstractMatrix{Float64},Tc<:AbstractVector{ComplexF64}} = spat_cplx_to_SHqst(cfg.cfg,ur,utheta,uphi,qlm,slm,tlm)
analys!(cfg::SHTnsCfg, ur::T, utheta::T, uphi::T, qlm::Tc, slm::Tc, tlm::Tc) where {T<:AbstractMatrix{ComplexF64},Tc<:AbstractVector{ComplexF64}} = spat_to_SHqst(cfg.cfg,ur,utheta,uphi,qlm,slm,tlm)