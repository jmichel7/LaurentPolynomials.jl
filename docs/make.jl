using Documenter, LaurentPolynomials

DocMeta.setdocmeta!(LaurentPolynomials, :DocTestSetup, :(using LaurentPolynomials); recursive=true)

makedocs(;
    modules=[LaurentPolynomials],
    authors="Jean Michel <jean.michel@imj-prg.fr>",
    sitename="LaurentPolynomials.jl",
    format=Documenter.HTML(;
        canonical="https://jmichel7.github.io/LaurentPolynomials.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/jmichel7/LaurentPolynomials.jl",
    devbranch="main",
)
