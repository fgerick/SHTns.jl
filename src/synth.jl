"""
    synth(cfg::SHTnsCfg, qlm)

DOCSTRING
"""
function synth(cfg::SHTnsCfg, qlm)
    @assert cfg.nlat != 0
    @assert length(qlm) == cfg.nlm
    v = Matrix{Float64}(undef, cfg.nlat_padded, cfg.nphi)
    synth!(cfg, qlm, v)
    return v
end

"""
    synth_cplx(cfg::SHTnsCfg, qlm)

DOCSTRING
"""
function synth_cplx(cfg::SHTnsCfg, qlm)
    @assert cfg.nlat != 0
    @assert length(qlm) == cfg.nlm_cplx
    @assert cfg.lmax == cfg.mmax
    v = Matrix{ComplexF64}(undef, cfg.nlat_padded, cfg.nphi)
    synth!(cfg, qlm, v)
    return v
end

"""
    synth(cfg::SHTnsCfg, slm, tlm)

DOCSTRING

# Arguments:
- `cfg`: DESCRIPTION
- `slm`: DESCRIPTION
- `tlm`: DESCRIPTION
"""
function synth(cfg::SHTnsCfg, slm, tlm)
    @assert cfg.nlat != 0
    @assert length(slm) == length(tlm) == cfg.nlm
    utheta = Matrix{Float64}(undef, cfg.nlat_padded, cfg.nphi)
    uphi = Matrix{Float64}(undef, cfg.nlat_padded, cfg.nphi)
    synth!(cfg, slm, tlm, utheta, uphi)
    return utheta, uphi
end

"""
    synth_cplx(cfg::SHTnsCfg, slm, tlm)

DOCSTRING

# Arguments:
- `cfg`: DESCRIPTION
- `slm`: DESCRIPTION
- `tlm`: DESCRIPTION
"""
function synth_cplx(cfg::SHTnsCfg, slm, tlm)
    @assert cfg.nlat != 0
    @assert length(slm) == length(tlm) == cfg.nlm_cplx
    @assert cfg.lmax == cfg.mmax
    utheta = Matrix{ComplexF64}(undef, cfg.nlat_padded, cfg.nphi)
    uphi = Matrix{ComplexF64}(undef, cfg.nlat_padded, cfg.nphi)
    synth!(cfg, slm, tlm, utheta, uphi)
    return utheta, uphi
end

"""
    synth(cfg::SHTnsCfg, qlm, slm, tlm)

DOCSTRING

# Arguments:
- `cfg`: DESCRIPTION
- `qlm`: DESCRIPTION
- `slm`: DESCRIPTION
- `tlm`: DESCRIPTION
"""
function synth(cfg::SHTnsCfg, qlm, slm, tlm)
    @assert cfg.nlat != 0
    @assert length(qlm) == length(slm) == length(tlm) == cfg.nlm
    ur = Matrix{Float64}(undef, cfg.nlat, cfg.nphi)
    utheta = Matrix{Float64}(undef, cfg.nlat_padded, cfg.nphi)
    uphi = Matrix{Float64}(undef, cfg.nlat_padded, cfg.nphi)
    synth!(cfg, qlm, slm, tlm, ur, utheta, uphi)
    return ur, utheta, uphi
end

"""
    synth_cplx(cfg::SHTnsCfg, qlm, slm, tlm)

DOCSTRING

# Arguments:
- `cfg`: DESCRIPTION
- `qlm`: DESCRIPTION
- `slm`: DESCRIPTION
- `tlm`: DESCRIPTION
"""
function synth_cplx(cfg::SHTnsCfg, qlm, slm, tlm)
    @assert cfg.nlat != 0
    @assert length(qlm) == length(slm) == length(tlm) == cfg.nlm_cplx
    @assert cfg.lmax == cfg.mmax
    ur = Matrix{ComplexF64}(undef, cfg.nlat_padded, cfg.nphi)
    utheta = Matrix{ComplexF64}(undef, cfg.nlat_padded, cfg.nphi)
    uphi = Matrix{ComplexF64}(undef, cfg.nlat_padded, cfg.nphi)
    synth!(cfg, qlm, slm, tlm, ur, utheta, uphi)
    return ur, utheta, uphi
end

function synth!(cfg::SHTnsCfg, qlm, v::AbstractMatrix{Float64})
    SH_to_spat(cfg.cfg, qlm, v)
    return v
end

function synth!(cfg::SHTnsCfg, qlm, v::AbstractMatrix{ComplexF64})
    SH_to_spat_cplx(cfg.cfg, qlm, v)
    return v
end

function synth!(cfg::SHTnsCfg, slm, tlm, utheta::T, uphi::T) where {T<:AbstractMatrix{Float64}}
    SHsphtor_to_spat(cfg.cfg, slm, tlm, utheta, uphi)
    return utheta, uphi
end

function synth!(cfg::SHTnsCfg, slm, tlm, utheta::T, uphi::T) where {T<:AbstractMatrix{ComplexF64}}
    SHsphtor_to_spat_cplx(cfg.cfg, slm, tlm, utheta, uphi)
    return utheta, uphi
end

function synth!(cfg::SHTnsCfg, qlm, slm, tlm, ur::T, utheta::T, uphi::T) where {T<:AbstractMatrix{Float64}}
    SHqst_to_spat(cfg.cfg, qlm, slm, tlm, ur, utheta, uphi)
    return ur, utheta, uphi
end

function synth!(cfg::SHTnsCfg, qlm, slm, tlm, ur::T, utheta::T, uphi::T) where {T<:AbstractMatrix{ComplexF64}}
    SHqst_to_spat_cplx(cfg.cfg, qlm, slm, tlm, ur, utheta, uphi)
    return ur, utheta, uphi
end


export synth, synth_cplx, synth!