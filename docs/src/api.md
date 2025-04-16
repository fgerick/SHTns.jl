# API


## Configuration

```@docs
SHTns.SHTnsCfg
```
### Transform types (SHTnsType)

```@docs
SHTns.SHTnsType
```

```@docs
SHTns.Gauss
SHTns.GaussFly
SHTns.QuickInit
SHTns.RegDCT
SHTns.RegFast
SHTns.RegPoles
```

### Spherical harmonic normalizations (SHTnsNorm)

```@docs
SHTns.ForRotations
SHTns.FourPi
SHTns.Orthonormal
SHTns.Schmidt
```

## Transforms

The transforms from spatial space to spectral space, also called _analysis_, are available through [`SHTns.analys`](@ref) and [`SHTns.analys!`](@ref).
The transforms from spectral space to spatial space, also called _synthesis_, are available through [`SHTns.synth`](@ref) and [`SHTns.synth!`](@ref).

```@docs
SHTns.analys
SHTns.analys!
SHTns.synth
SHTns.synth!
```

## Miscellaneous 

```@docs
SHTns.LM
SHTns.gauss_weights
SHTns.grid
```
