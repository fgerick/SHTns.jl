var documenterSearchIndex = {"docs":
[{"location":"api/#API","page":"API","title":"API","text":"","category":"section"},{"location":"api/","page":"API","title":"API","text":"","category":"page"},{"location":"api/","page":"API","title":"API","text":"Modules = [SHTns]","category":"page"},{"location":"api/#SHTns.ForRotations","page":"API","title":"SHTns.ForRotations","text":"struct SHTns.ForRotations <: SHTnsNorm\n\n\n\n\n\n","category":"type"},{"location":"api/#SHTns.FourPi","page":"API","title":"SHTns.FourPi","text":"struct SHTns.FourPi <: SHTnsNorm\n\n\n\n\n\n","category":"type"},{"location":"api/#SHTns.Gauss","page":"API","title":"SHTns.Gauss","text":"struct SHTns.Gauss <: SHTnsType\n\n\n\n\n\n","category":"type"},{"location":"api/#SHTns.GaussFly","page":"API","title":"SHTns.GaussFly","text":"struct SHTns.GaussFly <: SHTnsType\n\n\n\n\n\n","category":"type"},{"location":"api/#SHTns.Orthonormal","page":"API","title":"SHTns.Orthonormal","text":"struct SHTns.Orthonormal <: SHTnsNorm\n\n\n\n\n\n","category":"type"},{"location":"api/#SHTns.QuickInit","page":"API","title":"SHTns.QuickInit","text":"struct SHTns.QuickInit <: SHTnsType\n\n\n\n\n\n","category":"type"},{"location":"api/#SHTns.RegDCT","page":"API","title":"SHTns.RegDCT","text":"struct SHTns.RegDCT <: SHTnsType\n\n\n\n\n\n","category":"type"},{"location":"api/#SHTns.RegFast","page":"API","title":"SHTns.RegFast","text":"struct SHTns.RegFast <: SHTnsType\n\n\n\n\n\n","category":"type"},{"location":"api/#SHTns.RegPoles","page":"API","title":"SHTns.RegPoles","text":"struct SHTns.RegPoles <: SHTnsType\n\n\n\n\n\n","category":"type"},{"location":"api/#SHTns.SHTnsCfg","page":"API","title":"SHTns.SHTnsCfg","text":"mutable struct SHTnsCfg{N<:SHTnsNorm, T<:SHTnsType}\n\nConfiguration of spherical harmonic transform.\n\n\n\n\n\n","category":"type"},{"location":"api/#SHTns.Schmidt","page":"API","title":"SHTns.Schmidt","text":"struct SHTns.Schmidt <: SHTnsNorm\n\n\n\n\n\n","category":"type"},{"location":"api/#SHTns.LM-Union{Tuple{N}, Tuple{T}, Tuple{SHTnsCfg{Complex, T, N}, Any, Any}} where {T, N}","page":"API","title":"SHTns.LM","text":"LM(cfg::SHTnsCfg{Complex,T,N}, l, m)\n\nReturns index corresponding to l and m in complex spherical harmonic expansion.\n\n\n\n\n\n","category":"method"},{"location":"api/#SHTns.LM-Union{Tuple{N}, Tuple{T}, Tuple{SHTnsCfg{Real, T, N}, Any, Any}} where {T, N}","page":"API","title":"SHTns.LM","text":"LM(cfg::SHTnsCfg{Real,T,N}, l, m)\n\nReturns index corresponding to l and m in real spherical harmonic expansion.\n\n\n\n\n\n","category":"method"},{"location":"api/#SHTns.gauss_weights-Tuple{SHTnsCfg}","page":"API","title":"SHTns.gauss_weights","text":"gauss_weights(cfg::SHTnsCfg)\n\nReturns Gauss quadrature weights of length cfg.nlat (shtns_gauss_wts only returns half of the symmetric weights).\n\n\n\n\n\n","category":"method"},{"location":"api/#SHTns.grid-Tuple{SHTnsCfg}","page":"API","title":"SHTns.grid","text":"grid(cfg::SHTnsCfg)\n\nReturns latitudes lat::Vector{Float64} and longitudes lon::Vector{Float64}.\n\n\n\n\n\n","category":"method"},{"location":"api/#SHTns.synth-Union{Tuple{N}, Tuple{T}, Tuple{TR}, Tuple{SHTnsCfg{TR, T, N}, Any, Any, Any}} where {TR, T, N}","page":"API","title":"SHTns.synth","text":"synth(cfg::SHTnsCfg, qlm, slm, tlm)\n\nDOCSTRING\n\nArguments:\n\ncfg: DESCRIPTION\nqlm: DESCRIPTION\nslm: DESCRIPTION\ntlm: DESCRIPTION\n\n\n\n\n\n","category":"method"},{"location":"api/#SHTns.synth-Union{Tuple{N}, Tuple{T}, Tuple{TR}, Tuple{SHTnsCfg{TR, T, N}, Any, Any}} where {TR, T, N}","page":"API","title":"SHTns.synth","text":"synth(cfg::SHTnsCfg, slm, tlm)\n\nDOCSTRING\n\nArguments:\n\ncfg: DESCRIPTION\nslm: DESCRIPTION\ntlm: DESCRIPTION\n\n\n\n\n\n","category":"method"},{"location":"api/#SHTns.synth-Union{Tuple{N}, Tuple{T}, Tuple{TR}, Tuple{SHTnsCfg{TR, T, N}, Any}} where {TR, T, N}","page":"API","title":"SHTns.synth","text":"synth(cfg::SHTnsCfg, qlm)\n\nDOCSTRING\n\n\n\n\n\n","category":"method"},{"location":"#SHTns.jl","page":"Home","title":"SHTns.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"SHTns is a high performance library for Spherical Harmonic Transform written in C, aimed at numerical simulation (fluid flows, MHD, ...) in spherical geometries.","category":"page"},{"location":"#Installation","page":"Home","title":"Installation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"In your project environment run","category":"page"},{"location":"","page":"Home","title":"Home","text":"import Pkg; Pkg.add(\"SHTns\")","category":"page"},{"location":"","page":"Home","title":"Home","text":"If you have installed SHTns separately (and compiled it into a shared library!) and you would like SHTns.jl to use this installation instead of the binaries shipped through SHTns_jll, you can set the SHTNS_PATH environment variable before using SHTns:","category":"page"},{"location":"","page":"Home","title":"Home","text":"ENV[\"SHTNS_PATH\"] = \"/path/to/libshtns.so\"\nusing SHTns","category":"page"}]
}
