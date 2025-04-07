"""
    LM(cfg::SHTnsCfg{Real,T,N}, l, m)

Returns index corresponding to `l` and `m` in real spherical harmonic expansion.
"""
function LM(shtns::SHTnsCfg{Real,T,N}, l, m) where {T,N}
    return (Cint(m / shtns.mres) * (2 * shtns.lmax + 2 - (m + shtns.mres))) >> 1 + l + 1
end

"""
    LM(cfg::SHTnsCfg{Complex,T,N}, l, m)

Returns index corresponding to `l` and `m` in complex spherical harmonic expansion.
"""
function LM(shtns::SHTnsCfg{Complex,T,N}, l, m) where {T,N}
    return (l <= shtns.mmax) ? l * (l + 1) + m + 1 : shtns.mmax * (2l - shtns.mmax) + l + m + 1
end

# """
#     k2lm(cfg, idx)

# Returns the `l` and `m` corresponding to the given index `idx` in complex spherical harmonic expansion.
# """
# function k2lm(cfg, idx)
#     @assert 0 < idx < (cfg.lmax + 1)^2
#     l = round(Int, sqrt(idx))
#     m = idx - l * (l + 1)
#     return l, m
# end


"""
    grid(cfg::SHTnsCfg)

Returns latitudes `lat::Vector{Float64}` and longitudes `lon::Vector{Float64}`.
"""
function grid(cfg::SHTnsCfg; colat=false)
    cosθ = cfg.ct
    if colat
        lat = asin.(cosθ)
    else
        lat = acos.(cosθ)
    end
    lon = (2π / cfg.nphi) * (0:(cfg.nphi-1))
    return lat, lon
end

"""
    gauss_weights(cfg::SHTnsCfg)

Returns Gauss quadrature weights of length `cfg.nlat` (`shtns_gauss_wts` only returns half of the symmetric weights).
"""
function gauss_weights(cfg::SHTnsCfg)
    _weights = zeros(cfg.nlat_2)
    SHTns.shtns_gauss_wts(cfg.cfg,_weights)
    return vcat(_weights,reverse(_weights))
end


function nlm(cfg::SHTnsCfg{Real,T,N}) where {T,N}
    return cfg.nlm
end

function nlm(cfg::SHTnsCfg{Complex,T,N}) where {T,N}
    return cfg.nlm_cplx
end



export LM, grid, gauss_weights, nlm