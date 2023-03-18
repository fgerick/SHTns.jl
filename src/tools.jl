"""
    LM(cfg, l, m)

Returns index corresponding to `l` and `m` in real spherical harmonic expansion.
"""
function LM(shtns, l, m)
    return (Cint(m / shtns.mres) * (2 * shtns.lmax + 2 - (m + shtns.mres))) >> 1 + l + 1
end

"""
    LM_cplx(cfg, l, m)

Returns index corresponding to `l` and `m` in complex spherical harmonic expansion.
"""
function LM_cplx(shtns, l, m)
    return (l <= shtns.mmax) ? l * (l + 1) + m + 1 : shtns.mmax * (2l - shtns.mmax) + l + m + 1
end

"""
    k2lm(cfg, idx)

Returns the `l` and `m` corresponding to the given index `idx` in complex spherical harmonic expansion.
"""
function k2lm(cfg, idx)
    @assert 0 < idx < (cfg.lmax + 1)^2
    l = round(Int, sqrt(idx))
    m = idx - l * (l + 1)
    return l, m
end


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

export LM, LM_cplx, grid