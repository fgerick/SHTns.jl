function analys(cfg::SHTnsCfg{Real,T,N}, v::Array{Float64}) where {T,N}
    @assert cfg.nlat != 0
    qlm = Vector{ComplexF64}(undef, cfg.nlm*cfg.howmany)
    analys!(cfg, copy(v), qlm)
    return qlm
end

function analys(cfg::SHTnsCfg{Complex,T,N}, v::Array{ComplexF64}) where {T,N}
    @assert cfg.nlat != 0
    qlm = Vector{ComplexF64}(undef, cfg.nlm_cplx*cfg.howmany)
    analys!(cfg, copy(v), qlm)
    return qlm
end

function analys(cfg::SHTnsCfg{Real,T,N}, utheta::Array{Float64}, uphi::Array{Float64}) where {T,N}
    @assert cfg.nlat != 0
    slm = Vector{ComplexF64}(undef, cfg.nlm*cfg.howmany)
    tlm = Vector{ComplexF64}(undef, cfg.nlm*cfg.howmany)
    analys!(cfg, copy(utheta), copy(uphi), slm, tlm)
    return slm, tlm
end

function analys(cfg::SHTnsCfg{Complex,T,N}, utheta::Array{ComplexF64}, uphi::Array{ComplexF64}) where {T,N}
    @assert cfg.nlat != 0
    slm = Vector{ComplexF64}(undef, cfg.nlm_cplx*cfg.howmany)
    tlm = Vector{ComplexF64}(undef, cfg.nlm_cplx*cfg.howmany)
    analys!(cfg, copy(utheta), copy(uphi), slm, tlm)
    return slm, tlm
end

function analys(cfg::SHTnsCfg{Real,T,N}, ur::Array{Float64}, utheta::Array{Float64}, uphi::Array{Float64}) where {T,N}
    @assert cfg.nlat != 0
    qlm = Vector{ComplexF64}(undef, cfg.nlm*cfg.howmany)
    slm = Vector{ComplexF64}(undef, cfg.nlm*cfg.howmany)
    tlm = Vector{ComplexF64}(undef, cfg.nlm*cfg.howmany)
    analys!(cfg, copy(ur), copy(utheta), copy(uphi), qlm, slm, tlm)
    return qlm, slm, tlm
end

function analys(cfg::SHTnsCfg{Complex,T,N}, ur::Array{ComplexF64}, utheta::Array{ComplexF64}, uphi::Array{ComplexF64}) where {T,N}
    @assert cfg.nlat != 0
    qlm = Vector{ComplexF64}(undef, cfg.nlm_cplx*cfg.howmany)
    slm = Vector{ComplexF64}(undef, cfg.nlm_cplx*cfg.howmany)
    tlm = Vector{ComplexF64}(undef, cfg.nlm_cplx*cfg.howmany)
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

export analys, analys!