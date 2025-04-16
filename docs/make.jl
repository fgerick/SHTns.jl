using Documenter, SHTns

makedocs(;
    # modules=[SHTns],
    # format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
        "Quickstart" => "quickstart.md",
        "Advanced usage" => "advanced.md",
        "API" => "api.md",
    ],
    repo="https://github.com/fgerick/SHTns.jl/blob/{commit}{path}#L{line}",
    sitename="SHTns.jl",
)

deploydocs(;
    repo="github.com/fgerick/SHTns.jl",
)
