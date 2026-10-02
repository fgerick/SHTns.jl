function analys(cfg::SHTnsCfg{TC,T,N}, v) where {TC,T,N}
    @assert cfg.nlat != 0
    qlm = cfg.howmany > 1 ? Matrix{ComplexF64}(undef, nlm(cfg), cfg.howmany) : Vector{ComplexF64}(undef, nlm(cfg))
    analys!(cfg, copy(v), qlm)
    return qlm
end

function analys(cfg::SHTnsCfg{TC,T,N}, utheta, uphi) where {TC,T,N}
    @assert cfg.nlat != 0
    slm = cfg.howmany > 1 ? Matrix{ComplexF64}(undef, nlm(cfg), cfg.howmany) : Vector{ComplexF64}(undef, nlm(cfg))
    tlm = cfg.howmany > 1 ? Matrix{ComplexF64}(undef, nlm(cfg), cfg.howmany) : Vector{ComplexF64}(undef, nlm(cfg))
    analys!(cfg, copy(utheta), copy(uphi), slm, tlm)
    return slm, tlm
end

function analys(cfg::SHTnsCfg{TC,T,N}, ur, utheta, uphi) where {TC,T,N}
    @assert cfg.nlat != 0
    qlm = cfg.howmany > 1 ? Matrix{ComplexF64}(undef, nlm(cfg), cfg.howmany) : Vector{ComplexF64}(undef, nlm(cfg))
    slm = cfg.howmany > 1 ? Matrix{ComplexF64}(undef, nlm(cfg), cfg.howmany) : Vector{ComplexF64}(undef, nlm(cfg))
    tlm = cfg.howmany > 1 ? Matrix{ComplexF64}(undef, nlm(cfg), cfg.howmany) : Vector{ComplexF64}(undef, nlm(cfg))
    analys!(cfg, copy(ur), copy(utheta), copy(uphi), qlm, slm, tlm)
    return qlm, slm, tlm
end

function analys!(cfg::SHTnsCfg{Real,T,N}, v::Array{Float64}, qlm) where {T,N}
    return spat_to_SH(cfg.cfg, v, qlm)
end

function analys!(cfg::SHTnsCfg{Complex,T,N}, v::Array{ComplexF64}, qlm) where {T,N}
    return spat_cplx_to_SH(cfg.cfg, v, qlm)
end

function analys!(cfg::SHTnsCfg{Real,T,N}, utheta::Tv, uphi::Tv, slm, tlm) where {T,N,Tv<:Array{Float64}}
    return spat_to_SHsphtor(cfg.cfg, utheta, uphi, slm, tlm)
end

function analys!(cfg::SHTnsCfg{Complex,T,N}, utheta::Tv, uphi::Tv, slm, tlm) where {T,N,Tv<:Array{ComplexF64}}
    return spat_cplx_to_SHsphtor(cfg.cfg, utheta, uphi, slm, tlm)
end

function analys!(cfg::SHTnsCfg{Real,T,N}, ur::Tv, utheta::Tv, uphi::Tv, qlm, slm, tlm) where {T,N,Tv<:Array{Float64}}
    return spat_to_SHqst(cfg.cfg, ur, utheta, uphi, qlm, slm, tlm)
end

function analys!(cfg::SHTnsCfg{Complex,T,N}, ur::Tv, utheta::Tv, uphi::Tv, qlm, slm, tlm) where {T,N,Tv<:Array{ComplexF64}}
    return spat_cplx_to_SHqst(cfg.cfg, ur, utheta, uphi, qlm, slm, tlm)
end

"""
    analys!(cfg::SHTnsCfg, v, qlm)
    analys!(cfg::SHTnsCfg, utheta, uphi, slm, tlm)
    analys!(cfg::SHTnsCfg, ur, utheta, uphi, qlm, slm, tlm)

In-place transforms of the spatial data into spherical harmonics coefficients for scalar, 2D or 3D fields.
!!! warning 
    This function modifies the input arrays `v`, `ur`, `utheta` and `uphi`.
"""
function analys! end

"""
    analys(cfg::SHTnsCfg, v)
    analys(cfg::SHTnsCfg, utheta, uphi)
    analys(cfg::SHTnsCfg, ur, utheta, uphi)

Transforms the spatial data into spherical harmonics coefficients `qlm`; `slm` and `tlm`; `qlm`, `slm` and `tlm` for scalar; 2D; 3D fields, respectively.
"""
function analys end
