function synth(cfg::SHTnsCfg{TR,T,N}, qlm) where {TR,T,N}
    Tv = TR == Real ? Float64 : ComplexF64 

    @assert cfg.nlat != 0
    @assert length(qlm) == nlm(cfg)*cfg.howmany

    nx = cfg.shtype.contiguous_phi ? cfg.nphi : cfg.nlat_padded
    ny = cfg.shtype.contiguous_phi ? cfg.nlat_padded : cfg.nphi
    
    v = cfg.howmany > 1 ? Array{Tv}(undef, nx, ny, cfg.howmany) : Matrix{Tv}(undef, nx, ny)
    synth!(cfg, qlm, v)
    return v
end

function synth(cfg::SHTnsCfg{TR,T,N}, slm, tlm) where {TR,T,N}
    Tv = TR == Real ? Float64 : ComplexF64
    @assert cfg.nlat != 0
    @assert length(slm) == length(tlm) == nlm(cfg)*cfg.howmany

    nx = cfg.shtype.contiguous_phi ? cfg.nphi : cfg.nlat_padded
    ny = cfg.shtype.contiguous_phi ? cfg.nlat_padded : cfg.nphi
     
    utheta = cfg.howmany > 1 ? Array{Tv}(undef, nx, ny, cfg.howmany) : Matrix{Tv}(undef, nx, ny)
    uphi = similar(utheta)

    synth!(cfg, slm, tlm, utheta, uphi)
    return utheta, uphi
end

function synth(cfg::SHTnsCfg{TR,T,N}, qlm, slm, tlm) where {TR,T,N}
    Tv = TR == Real ? Float64 : ComplexF64
    @assert cfg.nlat != 0
    @assert length(qlm) == length(slm) == length(tlm) == nlm(cfg)*cfg.howmany

    nx = cfg.shtype.contiguous_phi ? cfg.nphi : cfg.nlat_padded
    ny = cfg.shtype.contiguous_phi ? cfg.nlat_padded : cfg.nphi
     
    ur = cfg.howmany > 1 ? Array{Tv}(undef, nx, ny, cfg.howmany) : Matrix{Tv}(undef, nx, ny)
    utheta = similar(ur)
    uphi = similar(ur)
    synth!(cfg, qlm, slm, tlm, ur, utheta, uphi)
    return ur, utheta, uphi
end


function synth!(cfg::SHTnsCfg{Real,T,N}, qlm, v::Array{Float64}) where {T,N}
    @assert length(qlm) == nlm(cfg)*cfg.howmany
    SH_to_spat(cfg.cfg, qlm, v)
    return v
end

function synth!(cfg::SHTnsCfg{Complex,T,N}, qlm, v::Array{ComplexF64}) where {T,N}
    @assert length(qlm) == nlm(cfg)*cfg.howmany
    SH_to_spat_cplx(cfg.cfg, qlm, v)
    return v
end

function synth!(cfg::SHTnsCfg{Real,T,N}, slm, tlm, utheta::Tv, uphi::Tv) where {T,N,Tv<:Array{Float64}}

    SHsphtor_to_spat(cfg.cfg, slm, tlm, utheta, uphi)
    return utheta, uphi
end

function synth!(cfg::SHTnsCfg{Complex,T,N}, slm, tlm, utheta::Tv, uphi::Tv) where {T,N,Tv<:Array{ComplexF64}}
    SHsphtor_to_spat_cplx(cfg.cfg, slm, tlm, utheta, uphi)
    return utheta, uphi
end

function synth!(cfg::SHTnsCfg{Real,T,N}, qlm, slm, tlm, ur::Tv, utheta::Tv, uphi::Tv) where {T,N,Tv<:Array{Float64}}
    SHqst_to_spat(cfg.cfg, qlm, slm, tlm, ur, utheta, uphi)
    return ur, utheta, uphi
end

function synth!(cfg::SHTnsCfg{Complex,T,N}, qlm, slm, tlm, ur::Tv, utheta::Tv, uphi::Tv) where {T,N,Tv<:Array{ComplexF64}}
    SHqst_to_spat_cplx(cfg.cfg, qlm, slm, tlm, ur, utheta, uphi)
    return ur, utheta, uphi
end

"""
    synth(cfg::SHTnsCfg, qlm)
    synth(cfg::SHTnsCfg, slm, tlm)
    synth(cfg::SHTnsCfg, qlm, slm, tlm)

Transforms spherical harmonics coefficients `qlm` into spatial data `v`; `slm` and `tlm` into spatial data `utheta` and `uphi`; `qlm`, `slm` and `tlm` into spatial data `ur`, `utheta` and `uphi`.
"""
function synth end

"""
    synth!(cfg::SHTnsCfg, qlm, v)
    synth!(cfg::SHTnsCfg, slm, tlm, utheta, uphi)
    synth!(cfg::SHTnsCfg, qlm, slm, tlm, ur, utheta, uphi)

In-place transforms of the spherical harmonics coefficients into spatial data for scalar, 2D or 3D fields.
"""
function synth! end

export synth, synth!