function synth(cfg::SHTnsCfg, qlm::CuVector{ComplexF64})
    @assert cfg.shtype.gpu
    @assert cfg.nlat != 0
    @assert length(qlm) == cfg.nlm

    nx = cfg.shtype.contiguous_phi ? cfg.nphi : cfg.nlat_padded
    ny = cfg.shtype.contiguous_phi ? cfg.nlat_padded : cfg.nphi
     
    v = CuMatrix{Float64}(undef, nx, ny)
    synth!(cfg, qlm, v)
    return v
end

function synth(cfg::SHTnsCfg, slm::CuVector{ComplexF64}, tlm::CuVector{ComplexF64})
    @assert cfg.shtype.gpu
    @assert cfg.nlat != 0
    @assert length(slm) == length(tlm) == cfg.nlm

    nx = cfg.shtype.contiguous_phi ? cfg.nphi : cfg.nlat_padded
    ny = cfg.shtype.contiguous_phi ? cfg.nlat_padded : cfg.nphi
     
    utheta = CuMatrix{Float64}(undef, nx, ny)
    uphi = CuMatrix{Float64}(undef, nx, ny)
    synth!(cfg, slm, tlm, utheta, uphi)
    return utheta, uphi
end

function synth(cfg::SHTnsCfg, qlm::CuVector{ComplexF64}, slm::CuVector{ComplexF64}, tlm::CuVector{ComplexF64})
    @assert cfg.shtype.gpu
    @assert cfg.nlat != 0
    @assert length(qlm) == length(slm) == length(tlm) == cfg.nlm
    nx = cfg.shtype.contiguous_phi ? cfg.nphi : cfg.nlat_padded
    ny = cfg.shtype.contiguous_phi ? cfg.nlat_padded : cfg.nphi
     
    ur = CuMatrix{Float64}(undef, nx, ny)
    utheta = CuMatrix{Float64}(undef, nx, ny)
    uphi = CuMatrix{Float64}(undef, nx, ny)
    synth!(cfg, qlm, slm, tlm, ur, utheta, uphi)
    return ur, utheta, uphi
end


function synth!(cfg::SHTnsCfg, qlm::CuVector{ComplexF64}, v::CuMatrix{Float64})
    @assert cfg.shtype.gpu
    cu_SH_to_spat(cfg.cfg, qlm, v, cfg.lmax)
    return v
end

function synth!(cfg::SHTnsCfg, slm::CuVector{ComplexF64}, tlm::CuVector{ComplexF64}, utheta::T, uphi::T) where {T<:CuMatrix{Float64}}
    @assert cfg.shtype.gpu
    cu_SHsphtor_to_spat(cfg.cfg, slm, tlm, utheta, uphi, cfg.lmax)
    return utheta, uphi
end

function synth!(cfg::SHTnsCfg, qlm::CuVector{ComplexF64}, slm::CuVector{ComplexF64}, tlm::CuVector{ComplexF64}, ur::T, utheta::T, uphi::T) where {T<:CuMatrix{Float64}}
    @assert cfg.shtype.gpu
    cu_SHqst_to_spat(cfg.cfg, qlm, slm, tlm, ur, utheta, uphi, cfg.lmax)
    return ur, utheta, uphi
end


#complex to complex not available for CUDA (status: SHTns v3.7)

# function synth_cplx(cfg::SHTnsCfg, qlm::CuVector{ComplexF64})
#     @assert cfg.shtype.gpu
#     @assert cfg.nlat != 0
#     @assert length(qlm) == cfg.nlm_cplx
#     @assert cfg.lmax == cfg.mmax

#     nx = cfg.shtype.contiguous_phi ? cfg.nphi : cfg.nlat_padded
#     ny = cfg.shtype.contiguous_phi ? cfg.nlat_padded : cfg.nphi
     
#     v = CuMatrix{ComplexF64}(undef, nx, ny)
#     synth!(cfg, qlm, v)
#     return v
# end

# function synth_cplx(cfg::SHTnsCfg, slm::CuVector{ComplexF64}, tlm::CuVector{ComplexF64})
#     @assert cfg.shtype.gpu
#     @assert cfg.nlat != 0
#     @assert length(slm) == length(tlm) == cfg.nlm_cplx
#     @assert cfg.lmax == cfg.mmax

#     nx = cfg.shtype.contiguous_phi ? cfg.nphi : cfg.nlat_padded
#     ny = cfg.shtype.contiguous_phi ? cfg.nlat_padded : cfg.nphi
     
#     utheta = CuMatrix{ComplexF64}(undef, nx, ny)
#     uphi = CuMatrix{ComplexF64}(undef, nx, ny)
#     synth!(cfg, slm, tlm, utheta, uphi)
#     return utheta, uphi
# end

# function synth_cplx(cfg::SHTnsCfg, qlm::CuVector{ComplexF64}, slm::CuVector{ComplexF64}, tlm::CuVector{ComplexF64})
#     @assert cfg.shtype.gpu
#     @assert cfg.nlat != 0
#     @assert length(qlm) == length(slm) == length(tlm) == cfg.nlm_cplx
#     @assert cfg.lmax == cfg.mmax

#     nx = cfg.shtype.contiguous_phi ? cfg.nphi : cfg.nlat_padded
#     ny = cfg.shtype.contiguous_phi ? cfg.nlat_padded : cfg.nphi
     
#     ur = CuMatrix{ComplexF64}(undef, nx, ny)
#     utheta = CuMatrix{ComplexF64}(undef, nx, ny)
#     uphi = CuMatrix{ComplexF64}(undef, nx, ny)
#     synth!(cfg, qlm, slm, tlm, ur, utheta, uphi)
#     return ur, utheta, uphi
# end

# function synth!(cfg::SHTnsCfg, qlm::CuVector{ComplexF64}, v::CuMatrix{ComplexF64})
#     cu_SH_to_spat_cplx(cfg.cfg, qlm, v, cfg.lmax)
#     return v
# end

# function synth!(cfg::SHTnsCfg, slm::CuVector{ComplexF64}, tlm::CuVector{ComplexF64}, utheta::T, uphi::T) where {T<:CuMatrix{ComplexF64}}
#     cu_SHsphtor_to_spat_cplx(cfg.cfg, slm, tlm, utheta, uphi, cfg.lmax)
#     return utheta, uphi
# end

# function synth!(cfg::SHTnsCfg, qlm::CuVector{ComplexF64}, slm::CuVector{ComplexF64}, tlm::CuVector{ComplexF64}, ur::T, utheta::T, uphi::T) where {T<:CuMatrix{ComplexF64}}
#     cu_SHqst_to_spat_cplx(cfg.cfg, qlm, slm, tlm, ur, utheta, uphi, cfg.lmax)
#     return ur, utheta, uphi
# end

