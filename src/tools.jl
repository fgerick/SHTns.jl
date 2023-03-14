function LM(shtns, l,m)  
    return (Cint(m/shtns.mres)*(2*shtns.lmax + 2 - (m+shtns.mres)))>>1 + l + 1
end

function LM_cplx(shtns, l, m)
    return (l <= shtns.mmax) ? l*(l+1)+m+1 : shtns.mmax*(2l - shtns.mmax) + l+m+1
end

"""
    k2lm(cfg, idx) -> (int,int) : returns the l and m corresponding to the given index in complex spherical harmonic expansion
"""
function k2lm(cfg, idx)
    @assert 0 < idx < (cfg.lmax+1)^2
    l = round(Int,sqrt(idx))
    m = idx - l*(l+1)
    return l,m
end

export LM, LM_cplx

function grid(sht::SHTnsCfg)
    cosθ = sht.ct
    lat = asin.(cosθ)
    lon = (2π/sht.nphi)*(0:(sht.nphi-1))
    return lat, lon
end

export grid