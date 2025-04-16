# Quickstart

Load the package
```@example quickstart
using SHTns
```

Define your [`SHTnsCfg`](@ref) configuration for some maximum spherical harmonic degree `lmax`
```@example quickstart
lmax = 64
cfg = SHTnsCfg(lmax)
```


Create some spatial data `d`, using the latitude and longitude from [`SHTns.grid`](@ref)
```@example quickstart
function spat_func_test(theta, phi)
	return 1.0 + 0.01*cos(theta)  + 0.1*(3cos(theta)*cos(theta) - 1.0) +	#// Y00, Y10, Y20
	(cos(phi) + 0.3*sin(phi)) * sin(theta)	+ #// Y11
	(cos(2phi) + 0.1*sin(2phi)) * sin(theta)*sin(theta) * (7.0* cos(theta)*cos(theta) - 1.0) * 3/8 	#// Y42
end

θ,ϕ = SHTns.grid(cfg)
d = spat_func_test.(θ, ϕ')
nothing #hide
```

Transform the data `d` to the spectral coefficients `q` (i.e. perform an analysis)
```@example quickstart
q = SHTns.analys(cfg, d)
nothing #hide
```

Transform back to spatial data (i.e. perform a synthesis)
```@example quickstart
d2 = SHTns.synth(cfg, q)
d2 ≈ d
```

These transforms can also be performed in place
```@example quickstart
q2 = similar(q)
SHTns.analys!(cfg, d2, q2)
q2 ≈ q
```
!!! warning 
	`d2` is overwritten during [`SHTns.analys!`](@ref).

```@example quickstart
SHTns.synth!(cfg, q2, d2)
d2 ≈ d
```


