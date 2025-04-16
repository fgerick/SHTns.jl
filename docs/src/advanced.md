# Advanced usage

## Configuring the transform

The [`SHTnsCfg`](@ref) configuration object takes several keywords allowing the user to tweak the spherical harmonic transform.

The simplest configuration takes only the maximum spherical harmonic degree `lmax` as an argument
```@example advanced
using SHTns

lmax = 100
cfg = SHTnsCfg(lmax)
```

We can also define the grid resolution (`nlat` and `nphi`) first, and then `lmax`, as well as the maximum azimuthal degree `mmax`, as well as the _resolution_ in ``m`` through `mres`.
```@example advanced
nlat = 100
nphi = 2nlat+1
lmax = 2nlat÷3
mmax = 5
mres = 1
cfg = SHTnsCfg(lmax,mmax,mres,nlat,nphi)
```

The transform type [`SHTnsType`](@ref) can be varied through the `shtype` keyword
```@example advanced
cfg = SHTnsCfg(lmax; shtype = SHTns.Gauss())
```

See also the documentation of the C library on [shtns_type](https://nschaeff.bitbucket.io/shtns/shtns_8h.html#abdccbb8fbce176dbe189d494c94f0f7b) and [grid layouts](https://nschaeff.bitbucket.io/shtns/spat.html).

We can also change the normalization of the spherical harmonics, for example to the Schmidt semi-normalization without [Condon-Shortley phase](https://mathworld.wolfram.com/Condon-ShortleyPhase.html) (default enabled)
```@example advanced
cfg = SHTnsCfg(lmax; norm = SHTns.Schmidt(; cs_phase=false))
```
See also [Spherical Harmonics storage and normalization](https://nschaeff.bitbucket.io/shtns/spec.html) of the C library.


`SHTns` also supports complex to complex transforms (instead of real spatial space to complex spectral space, which is the default).

```@example advanced
cfg = SHTnsCfg(lmax; transform=Complex)
```

## GPU

Using `SHTns` on a CUDA-enabled GPU is straightforward.
Simply install and import [`CUDA.jl`](https://github.com/JuliaGPU/CUDA.jl):

```julia
import Pkg; Pkg.add("CUDA")
using CUDA
```

Then, configure your [`SHTnsCfg`](@ref) using an [`SHTnsType`](@ref) with the keyword `gpu=true`.
```julia
cfg_gpu = SHTnsCfg(64; shtype=SHTns.QuickInit(;gpu=true))
```

The rest remains almost identical to the CPU transform
```julia
θ,ϕ = SHTns.grid(cfg) #get (co-)latitude and longitude
d = @. 0.3*sin(ϕ') * sin(θ) #create some spatial data (0.3 Y₁¹) - on CPU!

d_gpu = CuArray(d) #send spatial data to GPU

q_gpu = SHTns.analys(cfg_gpu,d_gpu) #transform to spectral space

#scalar indexing not allowed on GPU arrays, therefore call Array(q_gpu) to send back to CPU
y11_coeff = Array(q_gpu)[SHTns.LM(cfg, 1,1)] 
y11_coeff ≈ 0.3*sqrt(2π/3)*im #true

d2_gpu = SHTns.synth(cfg_gpu,q_gpu) #transform backto spatial space
d2_gpu ≈ d_gpu #true
```


> [!NOTE]
> ROCm GPUs may be supported in future releases of SHTns.jl (already available in the C library).

## Batched transform

`SHTns` supports batched transforms, i.e. multiple spherical harmonic transforms together. For example transforms on spherical surfaces at different radii at the same time.

One can exploit this feature using the keyword `howmany`, to give the configuration the number of transforms to be performed.

```@example advanced
howmany = 10
cfg = SHTnsCfg(lmax; howmany)

θ,ϕ = SHTns.grid(cfg)

# create spatial array (nlat_padded x nphi x howmany)
d = zeros(cfg.nlat_padded, cfg.nphi, howmany)
d1 = @. 0.3*sin(ϕ') * sin(θ)
for i=1:howmany
	@. d[:,:,i] = i*d1
end

q = SHTns.analys(cfg,d)
d2 = SHTns.synth(cfg,q)
d2 ≈ d #true
```

> [!NOTE]
> Complex to complex transforms are currently not supported in the batched transform.


