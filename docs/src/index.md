# SHTns.jl

[SHTns](https://bitbucket.org/nschaeff/shtns/src/master/) is a high performance library for Spherical Harmonic Transform written in C, aimed at numerical simulation (fluid flows, MHD, ...) in spherical geometries.

## Installation

In your project environment run

```julia
import Pkg; Pkg.add("SHTns")
```

If you have installed SHTns separately (and compiled it into a shared library!) and you would like `SHTns.jl` to use this installation instead of the binaries shipped through `SHTns_jll`, you can set the `SHTNS_PATH` environment variable before `using SHTns`:

```julia
ENV["SHTNS_PATH"] = "/path/to/libshtns.so"
using SHTns
```
