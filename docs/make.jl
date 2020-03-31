using Documenter, SHTns

makedocs(;
    modules=[SHTns],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/fgerick/SHTns.jl/blob/{commit}{path}#L{line}",
    sitename="SHTns.jl",
    authors="Felix Gerick",
    assets=String[],
)

deploydocs(;
    repo="github.com/fgerick/SHTns.jl",
)
