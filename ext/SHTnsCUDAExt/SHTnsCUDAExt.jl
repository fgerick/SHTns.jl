module SHTnsCUDAExt

using CUDA
using SHTns

import SHTns: libshtns
import SHTns: synth, synth!, analys, analys!

__init__() = @assert CUDA.functional()

include("sht.jl")
include("synth.jl")
include("analys.jl")

end #module