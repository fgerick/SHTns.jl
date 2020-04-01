using Clang

const libclang_includes = ["-I/usr/local/include"]
const libshtns_header = ["/Users/gerickf/Programs/shtns/shtns.h"]

w = init(; headers = libshtns_header,
            output_file = joinpath(@__DIR__, "libshtns_api.jl"),
            common_file = joinpath(@__DIR__, "libshtns_common.jl"),
            clang_includes = libclang_includes,
            clang_args = ["-Xclang"],
            header_library = x->"libshtns",
            clang_diagnostics = true,
            )

run(w)
