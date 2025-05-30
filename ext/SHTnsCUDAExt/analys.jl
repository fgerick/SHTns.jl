function analys(cfg::SHTnsCfg, v::CuArray{Float64})
    @assert cfg.shtype.gpu
    @assert cfg.nlat != 0
    qlm = CuVector{ComplexF64}(undef, cfg.nlm*cfg.howmany)
    analys!(cfg, copy(v), qlm)
    return qlm
end

function analys(cfg::SHTnsCfg, v::CuArray{ComplexF64})
    @assert cfg.shtype.gpu
    @assert cfg.nlat != 0
    qlm = CuVector{ComplexF64}(undef, cfg.nlm_cplx*cfg.howmany)
    analys!(cfg, copy(v), qlm)
    return qlm
end

function analys(cfg::SHTnsCfg, utheta::CuArray{Float64}, uphi::CuArray{Float64})
    @assert cfg.shtype.gpu
    @assert cfg.nlat != 0
    slm = CuVector{ComplexF64}(undef, cfg.nlm*cfg.howmany)
    tlm = CuVector{ComplexF64}(undef, cfg.nlm*cfg.howmany)
    analys!(cfg, copy(utheta), copy(uphi), slm, tlm)
    return slm, tlm
end

function analys(cfg::SHTnsCfg, utheta::CuArray{ComplexF64}, uphi::CuArray{ComplexF64})
    @assert cfg.shtype.gpu
    @assert cfg.nlat != 0
    slm = CuVector{ComplexF64}(undef, cfg.nlm_cplx*cfg.howmany)
    tlm = CuVector{ComplexF64}(undef, cfg.nlm_cplx*cfg.howmany)
    analys!(cfg, copy(utheta), copy(uphi), slm, tlm)
    return slm, tlm
end

function analys(cfg::SHTnsCfg, ur::CuArray{Float64}, utheta::CuArray{Float64}, uphi::CuArray{Float64})
    @assert cfg.shtype.gpu
    @assert cfg.nlat != 0
    qlm = CuVector{ComplexF64}(undef, cfg.nlm*cfg.howmany)
    slm = CuVector{ComplexF64}(undef, cfg.nlm*cfg.howmany)
    tlm = CuVector{ComplexF64}(undef, cfg.nlm*cfg.howmany)
    analys!(cfg, copy(ur), copy(utheta), copy(uphi), qlm, slm, tlm)
    return qlm, slm, tlm
end

function analys(cfg::SHTnsCfg, ur::CuArray{ComplexF64}, utheta::CuArray{ComplexF64}, uphi::CuArray{ComplexF64})
    @assert cfg.shtype.gpu
    @assert cfg.nlat != 0
    qlm = CuVector{ComplexF64}(undef, cfg.nlm_cplx*cfg.howmany)
    slm = CuVector{ComplexF64}(undef, cfg.nlm_cplx*cfg.howmany)
    tlm = CuVector{ComplexF64}(undef, cfg.nlm_cplx*cfg.howmany)
    analys!(cfg, copy(ur), copy(utheta), copy(uphi), qlm, slm, tlm)
    return qlm, slm, tlm
end

function analys!(cfg::SHTnsCfg, v::CuArray{Float64}, qlm::CuVector{ComplexF64})
    @assert cfg.shtype.gpu
    return cu_spat_to_SH(cfg.cfg, v, qlm, cfg.lmax)
end


function analys!(cfg::SHTnsCfg, utheta::T, uphi::T, slm::CuVector{ComplexF64}, tlm::CuVector{ComplexF64}) where {T<:CuArray{Float64}}
    @assert cfg.shtype.gpu
    return cu_spat_to_SHsphtor(cfg.cfg, utheta, uphi, slm, tlm, cfg.lmax)
end

function analys!(cfg::SHTnsCfg, ur::T, utheta::T, uphi::T, qlm::CuVector{ComplexF64}, slm::CuVector{ComplexF64}, tlm::CuVector{ComplexF64}) where {T<:CuArray{Float64}}
    @assert cfg.shtype.gpu
    return cu_spat_to_SHqst(cfg.cfg, ur, utheta, uphi, qlm, slm, tlm, cfg.lmax)
end

#complex to complex not available for CUDA (status: SHTns v3.7)

# function analys!(cfg::SHTnsCfg, v::CuArray{ComplexF64}, qlm::CuVector{ComplexF64})
#     return cu_spat_cplx_to_SH(cfg.cfg, v, qlm)
# end

# function analys!(cfg::SHTnsCfg, utheta::T, uphi::T, slm::CuVector{ComplexF64}, tlm::CuVector{ComplexF64}) where {T<:CuArray{ComplexF64}}
#     return cu_spat_cplx_to_SHsphtor(cfg.cfg, utheta, uphi, slm, tlm)
# end

# function analys!(cfg::SHTnsCfg, ur::T, utheta::T, uphi::T, qlm::CuVector{ComplexF64}, slm::CuVector{ComplexF64}, tlm::CuVector{ComplexF64}) where {T<:CuArray{ComplexF64}}
#     return cu_spat_cplx_to_SHqst(cfg.cfg, ur, utheta, uphi, qlm, slm, tlm)
# end
