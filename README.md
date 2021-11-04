
<a id='Laurent-polynomials'></a>

<a id='Laurent-polynomials-1'></a>

# Laurent polynomials

- [Laurent polynomials](index.md#Laurent-polynomials)

<a id='LaurentPolynomials' href='#LaurentPolynomials'>#</a>
**`LaurentPolynomials`** &mdash; *Module*.

I  wanted to  call this  package `Pols`, since this  is the name of the data
structure  it  provides,  but  could  not  register  it under that name (too
short).  I thus renamed it  to `LaurentPolynomials` following  the suggestion
of the moderator  (reluctantly, since I did  not want to reserve  that name
for my use).

This  package,  which  depends  on  no other package, implements univariate Laurent  polynomials  (type  `Pol{T}`),  and  univariate rational fractions (type `Frac{Pol{T}}`).

The  initial motivation was to have a simple way to port GAP polynomials to Julia. The reasons for still having my own package are multiple:

  * I need  to have  a simple  and flexible  interface, which  I hope this provides.
  * I need my polynomials to behave  well when coefficients are in a ring, in which case I use pseudo-division and subresultant gcd.
  * For my uses my polynomials are several times faster than those in the package `Polynomials`.
  * I need my polynomials to  work as well as possible with coefficients of types  `T` where elements have a `zero`  method but `T` itself does not have  one (because `T` does not  contain the necessary information). An example is modular arithmetic with a `BigInt` modulus which thus cannot be part of the type.
  * a final justification is that `LaurentPolynomials` is used by `Mvps`.

Laurent polynomials have the parametric type `Pol{T}`, where `T`is the type of   the  coefficients.  They  are  constructed   by  giving  a  vector  of coefficients  of  type  `T`,  and  a  valuation  (an  `Int`).  We call true polynomials those whose valuation is `≥0`.

There  is a  current variable  name (a  `Symbol`) used to print polynomials nicely  at  the  repl  or  in  IJulia  or  Pluto.  This name can be changed globally,  or just changed for printing a given polynomial. But polynomials do not record individually with which symbol they should be printed.

**Examples**

```julia-repl
julia> Pol(:q) # define symbol used for printing and return Pol([1],1)
Pol{Int64}: q

julia> @Pol q  # same as q=Pol(:q)  useful to start session with polynomials
Pol{Int64}: q

julia> Pol([1,2]) # valuation is taken to be 0 if omitted
Pol{Int64}: 2q+1

julia> 2q+1       # same polynomial
Pol{Int64}: 2q+1

julia> Pol()   # omitting all arguments gives Pol([1],1)
Pol{Int64}: q

julia> p=Pol([1,2,1],-1) # here the valuation is specified to be -1
Pol{Int64}: q+2+q⁻¹

julia> q+2+q^-1 # same polynomial
Pol{Int64}: q+2+q⁻¹
```

```julia-rep1
julia> print(p) # if not nice printing give an output which can be read back
Pol([1, 2, 1],-1)

# change the variable for printing just this time
julia> print(IOContext(stdout,:limit=>true,:varname=>"x"),p)
x+2+x⁻¹

julia> print(IOContext(stdout,:TeX=>true),p) # TeXable output (used in Pluto, IJulia)
q+2+q^{-1}
```

A  polynomial can be  taken apart with  the functions `valuation`, `degree` and `getindex`. An index `p[i]` gives the coefficient of degree `i` of `p`.

```julia-repl
julia> valuation(p),degree(p)
(-1, 1)

julia> p[0], p[1], p[-1], p[10]
(2, 1, 1, 0)

julia> p[valuation(p):degree(p)]
3-element Vector{Int64}:
 1
 2
 1

julia> p[begin:end]  # the same as the above line
3-element Vector{Int64}:
 1
 2
 1

julia> coefficients(p)  # the same again
3-element Vector{Int64}:
 1
 2
 1
```

A  polynomial  is  a  *scalar*  if  the  valuation  and degree are `0`. The function  `scalar` returns the constant coefficient  if the polynomial is a scalar, and `nothing` otherwise.

```julia-repl
julia> Pol(1)
Pol{Int64}: 1

julia> convert(Pol{Int},1) # the same thing
Pol{Int64}: 1

julia> scalar(Pol(1))
1

julia> convert(Int,Pol(1)) # the same thing
1

julia> Int(Pol(1))         # the same thing
1

julia> scalar(q+1) # nothing; convert would give an error
```

In arrays `Pol{T}` of different types `T` are promoted to the same type `T` (when  the `T`  involved have  a promotion)  and a  number is promoted to a polynomial.

Usual  arithmetic (`+`, `-`,  `*`, `^`, `/`,  `//`, `one`, `isone`, `zero`, `iszero`,  `==`) works. Elements  of type `<:Number`  or of type  `T` for a `Pol{T}`   are  considered  as   scalars  for  scalar   operations  on  the coefficients.

```julia-repl
julia> derivative(p)
Pol{Int64}: 1-q⁻²

julia> p=(q+1)^2
Pol{Int64}: q²+2q+1

julia> p/2
Pol{Float64}: 0.5q²+1.0q+0.5

julia> p//2
Pol{Rational{Int64}}: (1//2)q²+(1//1)q+1//2

julia> p(1//2) # value of p at 1//2
9//4

julia> p(0.5)
2.25

# interpolation: find p taking values [2.0,1.0,3.0] at [1,2,3]
julia> Pol([1,2,3],[2.0,1.0,3.0])  
Pol{Float64}: 1.5q²-5.5q+6.0
```

Polynomials  are scalars  for broadcasting.  They can  be sorted (they have `cmp`   and  `isless`  functions  which   compare  the  valuation  and  the coefficients), they can be keys in a `Dict` (they have a `hash` function).

The  functions  `divrem`,  `div`,  `%`,  `gcd`,  `gcdx`,  `lcm`, `powermod` operate  between  true  polynomials  over  a  field,  using  the polynomial division.  Over a ring it is better  to use `pseudodiv` and `srgcd` instead of  `divrem`  and  `gcd`  (by  default  `gcd`  between  integer polynomials delegates to `srgcd`.

`exactdiv`  does  division  (over  a  field  or  a  ring) when it is exact, otherwise gives an error.

```julia-repl
julia> divrem(q^3+1,2q+1) # changes coefficients to field elements
(0.5q²-0.25q+0.125, 0.875)

julia> divrem(q^3+1,2q+1//1) # case of coeffcients already field elements
((1//2)q²+(-1//4)q+1//8, 7//8)

julia> pseudodiv(q^3+1,2q+1) # pseudo-division keeps the ring
(4q²-2q+1, 7)

julia> (4q^2-2q+1)*(2q+1)+7 # but multiplying back gives a multiple of the polynomial
Pol{Int64}: 8q³+8

julia> exactdiv(q+1,2.0) # exactdiv(q+1,2) would give an error
Pol{Float64}: 0.5q+0.5
```

Finally,   `Pol`s  have   methods  `conj`,   `adjoint`  which   operate  on coefficients,  methods `positive_part`,  `negative_part` and  `bar` (useful for  Kazhdan-Lusztig  theory)  and  a  method  `randpol`  to produce random polynomials.

Inverting polynomials is a way to get a rational fraction  `Frac{Pol{T}}`s. Rational fractions are normalized so that the numerator and denominator are true  polynomials prime to each other.  They have the arithmetic operations `+`,  `-` ,  `*`, `/`,  `//`, `^`,  `inv`, `one`, `isone`, `zero`, `iszero` (which can operate between a `Pol` or a `Number` and a `Frac{Pol{T}}`).

```julia-repl
julia> a=1/(q+1)
Frac{Pol{Int64}}: 1/(q+1)

julia> Pol(2/a) # convert back to `Pol`
Pol{Int64}: 2q+2

julia> numerator(a)
Pol{Int64}: 1

julia> denominator(a)
Pol{Int64}: q+1

julia> m=[q+1 q+2;q-2 q-3]
2×2 Matrix{Pol{Int64}}:
 q+1  q+2
 q-2  q-3

julia> n=inv(Frac.(m)) # convert to rational fractions to invert the matrix
2×2 Matrix{Frac{Pol{Int64}}}:
 (-q+3)/(2q-1)  (-q-2)/(-2q+1)
 (q-2)/(2q-1)   (q+1)/(-2q+1)

julia> map(x->x(1),n) # evaluate at 1 the inverse matrix
2×2 Matrix{Float64}:
  2.0   3.0
 -1.0  -2.0

julia> map(x->x(1;Rational=true),n) # evaluate at 1 using //
2×2 Matrix{Rational{Int64}}:
  2//1   3//1
 -1//1  -2//1
```

Rational fractions are also scalars for broadcasting and can be sorted (have `cmp` and `isless` methods).


<a target='_blank' href='https://github.com/jmichel7/LaurentPolynomials.jl/blob/01ebe441ec7a6af50c20c26a187bb4183ecc9f06/src/LaurentPolynomials.jl#L1-L233' class='documenter-source'>source</a><br>

<a id='LaurentPolynomials.Pol' href='#LaurentPolynomials.Pol'>#</a>
**`LaurentPolynomials.Pol`** &mdash; *Type*.



`Pol(c::AbstractVector,v::Integer=0;check=true,copy=true)`

Make a polynomial of valuation `v` with coefficients `c`.

Unless  `check` is `false`  normalize the result  by making sure that `c`   has  no leading or  trailing zeroes (do  not set `check=false` unless you   are sure this is already the case).

Unless  `copy=false` the  contents of  `c` are  copied (you  can gain one   allocation by setting `copy=false` if you know the contents can be shared)


<a target='_blank' href='https://github.com/jmichel7/LaurentPolynomials.jl/blob/01ebe441ec7a6af50c20c26a187bb4183ecc9f06/src/LaurentPolynomials.jl#L248-L259' class='documenter-source'>source</a><br>


`Pol(t::Symbol)`

Sets the name of the variable for printing `Pol`s to `t`, and returns  the polynomial of degree 1 equal to that variable.


<a target='_blank' href='https://github.com/jmichel7/LaurentPolynomials.jl/blob/01ebe441ec7a6af50c20c26a187bb4183ecc9f06/src/LaurentPolynomials.jl#L273-L278' class='documenter-source'>source</a><br>


`Pol(x::AbstractVector,y::AbstractVector)`

Interpolation:  find a `Pol` (of  nonnegative valuation) of smallest degree taking  values `y` at points  `x`. The values `y`  should be in a field for the function to be type stable.

```julia-repl
julia> p=Pol([1,1,1])
Pol{Int64}: q²+q+1

julia> vals=p.(1:5)
5-element Vector{Int64}:
  3
  7
 13
 21
 31

julia> Pol(1:5,vals*1//1)
Pol{Rational{Int64}}: (1//1)q²+(1//1)q+1//1

julia> Pol(1:5,vals*1.0)
Pol{Float64}: 1.0q²+1.0q+1.0
```


<a target='_blank' href='https://github.com/jmichel7/LaurentPolynomials.jl/blob/01ebe441ec7a6af50c20c26a187bb4183ecc9f06/src/LaurentPolynomials.jl#L725-L750' class='documenter-source'>source</a><br>

<a id='LaurentPolynomials.@Pol' href='#LaurentPolynomials.@Pol'>#</a>
**`LaurentPolynomials.@Pol`** &mdash; *Macro*.



`@Pol q`

is equivalent to `q=Pol(:q)` excepted it creates `q` in the global scope of  the current module, since it uses `eval`.


<a target='_blank' href='https://github.com/jmichel7/LaurentPolynomials.jl/blob/01ebe441ec7a6af50c20c26a187bb4183ecc9f06/src/LaurentPolynomials.jl#L284-L289' class='documenter-source'>source</a><br>

<a id='Base.divrem' href='#Base.divrem'>#</a>
**`Base.divrem`** &mdash; *Function*.



`divrem(a::Pol, b::Pol)`

`a` and `b` should be true polynomials (nonnegative valuation). Computes  `(q,r)` such  that `a=q*b+r`  and `degree(r)<degree(b)`. Type stable if the coefficients of `b` are in a field.


<a target='_blank' href='https://github.com/jmichel7/LaurentPolynomials.jl/blob/01ebe441ec7a6af50c20c26a187bb4183ecc9f06/src/LaurentPolynomials.jl#L522-L528' class='documenter-source'>source</a><br>

<a id='Base.gcd-Tuple{Pol, Pol}' href='#Base.gcd-Tuple{Pol, Pol}'>#</a>
**`Base.gcd`** &mdash; *Method*.



`gcd(p::Pol,  q::Pol)` computes the  `gcd` of the  polynomials. It uses the subresultant algorithms for the `gcd` of integer polynomials.

```julia-repl
julia> gcd(2q+2,q^2-1)
Pol{Int64}: q+1

julia> gcd(q+1//1,q^2-1//1)
Pol{Rational{Int64}}: (1//1)q+1//1
```


<a target='_blank' href='https://github.com/jmichel7/LaurentPolynomials.jl/blob/01ebe441ec7a6af50c20c26a187bb4183ecc9f06/src/LaurentPolynomials.jl#L643-L654' class='documenter-source'>source</a><br>

<a id='Base.gcdx-Tuple{Pol, Pol}' href='#Base.gcdx-Tuple{Pol, Pol}'>#</a>
**`Base.gcdx`** &mdash; *Method*.



`gcdx(a::Pol,b::Pol)` 

for  polynomials  over  a  field  returns `d,u,v`  such  that `d=ua+vb` and `d=gcd(a,b)`.

```julia-repl
julia> gcdx(q^3-1//1,q^2-1//1)
((1//1)q-1//1, 1//1, (-1//1)q)
```


<a target='_blank' href='https://github.com/jmichel7/LaurentPolynomials.jl/blob/01ebe441ec7a6af50c20c26a187bb4183ecc9f06/src/LaurentPolynomials.jl#L667-L677' class='documenter-source'>source</a><br>

<a id='LaurentPolynomials.pseudodiv' href='#LaurentPolynomials.pseudodiv'>#</a>
**`LaurentPolynomials.pseudodiv`** &mdash; *Function*.



`pseudodiv(a::Pol, b::Pol)`

pseudo-division  of `a` by `b`.  If `d` is the  leading coefficient of `b`, computes   `(q,r)`   such   that   `d^(degree(a)+1-degree(b))a=q*b+r`   and `degree(r)<degree(b)`. Does not do division so works over any ring. For true polynomials (errors if the valuation of `a` or of `b` is negative).

See Knuth AOCP2 4.6.1 Algorithm R


<a target='_blank' href='https://github.com/jmichel7/LaurentPolynomials.jl/blob/01ebe441ec7a6af50c20c26a187bb4183ecc9f06/src/LaurentPolynomials.jl#L569-L578' class='documenter-source'>source</a><br>

<a id='LaurentPolynomials.srgcd' href='#LaurentPolynomials.srgcd'>#</a>
**`LaurentPolynomials.srgcd`** &mdash; *Function*.



`srgcd(a::Pol,b::Pol)`

sub-resultant gcd: gcd of polynomials over a unique factorization domain

See Knuth AOCP2 4.6.1 Algorithm C


<a target='_blank' href='https://github.com/jmichel7/LaurentPolynomials.jl/blob/01ebe441ec7a6af50c20c26a187bb4183ecc9f06/src/LaurentPolynomials.jl#L601-L607' class='documenter-source'>source</a><br>

<a id='Base.powermod' href='#Base.powermod'>#</a>
**`Base.powermod`** &mdash; *Function*.



`powermod(p::Pol, x::Integer, q::Pol)` computes $p^x \pmod m$.

```julia-repl
julia> powermod(q-1,3,q^2+q+1)
Pol{Int64}: 6q+3
```


<a target='_blank' href='https://github.com/jmichel7/LaurentPolynomials.jl/blob/01ebe441ec7a6af50c20c26a187bb4183ecc9f06/src/LaurentPolynomials.jl#L694-L700' class='documenter-source'>source</a><br>

<a id='LaurentPolynomials.randpol' href='#LaurentPolynomials.randpol'>#</a>
**`LaurentPolynomials.randpol`** &mdash; *Function*.



`randpol(T,d)`

random polynomial of degree `d` with coefficients from `T`


<a target='_blank' href='https://github.com/jmichel7/LaurentPolynomials.jl/blob/01ebe441ec7a6af50c20c26a187bb4183ecc9f06/src/LaurentPolynomials.jl#L718-L722' class='documenter-source'>source</a><br>

<a id='LaurentPolynomials.Frac' href='#LaurentPolynomials.Frac'>#</a>
**`LaurentPolynomials.Frac`** &mdash; *Type*.



`Frac(a::Pol,b::Pol;prime=false)

Polynomials  `a` and `b` are promoted to same coefficient type, and checked for  being true polynomials (otherwise they are both multiplied by the same power  of  the  variable  so  they  become  true  polynomials),  and unless `prime=true` they are checked for having a non-trivial `gcd`.


<a target='_blank' href='https://github.com/jmichel7/LaurentPolynomials.jl/blob/01ebe441ec7a6af50c20c26a187bb4183ecc9f06/src/LaurentPolynomials.jl#L866-L873' class='documenter-source'>source</a><br>

