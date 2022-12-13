# auto-generated tests from julia-repl docstrings
using Test, LaurentPolynomials
function mytest(f::String,a::String,b::String)
  println(f," ",a)
  omit=a[end]==';'
  a=replace(a,"\\\\"=>"\\")
  a=repr(MIME("text/plain"),eval(Meta.parse(a)),context=:limit=>true)
  if omit a="nothing" end
  a=replace(a,r" *(\n|$)"s=>s"\1")
  a=replace(a,r"\n$"s=>"")
  b=replace(b,r" *(\n|$)"s=>s"\1")
  b=replace(b,r"\n$"s=>"")
  i=1
  while i<=lastindex(a) && i<=lastindex(b) && a[i]==b[i]
    i=nextind(a,i)
  end
  if a!=b print("exec=$(repr(a[i:end]))\nmanl=$(repr(b[i:end]))\n") end
  a==b
end
@testset verbose = true "Gapjm" begin
@testset "README.md" begin
@test mytest("README.md","Pol(:q)","Pol{Int64}: q")
@test mytest("README.md","@Pol q","Pol{Int64}: q")
@test mytest("README.md","Pol([1,2])","Pol{Int64}: 2q+1")
@test mytest("README.md","2q+1","Pol{Int64}: 2q+1")
@test mytest("README.md","Pol()","Pol{Int64}: q")
@test mytest("README.md","p=Pol([1,2,1],-1)","Pol{Int64}: q+2+q⁻¹")
@test mytest("README.md","q+2+q^-1","Pol{Int64}: q+2+q⁻¹")
@test mytest("README.md","valuation(p),degree(p)","(-1, 1)")
@test mytest("README.md","p[0], p[1], p[-1], p[10]","(2, 1, 1, 0)")
@test mytest("README.md","p[valuation(p):degree(p)]","3-element Vector{Int64}:\n 1\n 2\n 1")
@test mytest("README.md","p[begin:end]","3-element Vector{Int64}:\n 1\n 2\n 1")
@test mytest("README.md","coefficients(p)","3-element Vector{Int64}:\n 1\n 2\n 1")
@test mytest("README.md","Pol(1)","Pol{Int64}: 1")
@test mytest("README.md","convert(Pol{Int},1)","Pol{Int64}: 1")
@test mytest("README.md","scalar(Pol(1))","1")
@test mytest("README.md","convert(Int,Pol(1))","1")
@test mytest("README.md","Int(Pol(1))","1")
@test mytest("README.md","scalar(q+1)","nothing")
@test mytest("README.md","derivative(p)","Pol{Int64}: 1-q⁻²")
@test mytest("README.md","p=(q+1)^2","Pol{Int64}: q²+2q+1")
@test mytest("README.md","p=(q+1)^2","Pol{Int64}: q²+2q+1")
@test mytest("README.md","p/2","Pol{Float64}: 0.5q²+1.0q+0.5")
@test mytest("README.md","p//2","Pol{Rational{Int64}}: (1//2)q²+(1//1)q+1//2")
@test mytest("README.md","p(1//2)","9//4")
@test mytest("README.md","p(0.5)","2.25")
@test mytest("README.md","Pol([1,2,3],[2.0,1.0,3.0])","Pol{Float64}: 1.5q²-5.5q+6.0")
@test mytest("README.md","divrem(q^3+1,2q+1)","(0.5q²-0.25q+0.125, 0.875)")
@test mytest("README.md","divrem(q^3+1,2q+1//1)","((1//2)q²+(-1//4)q+1//8, 7//8)")
@test mytest("README.md","pseudodiv(q^3+1,2q+1)","(4q²-2q+1, 7)")
@test mytest("README.md","(4q^2-2q+1)*(2q+1)+7","Pol{Int64}: 8q³+8")
@test mytest("README.md","exactdiv(q+1,2.0)","Pol{Float64}: 0.5q+0.5")
@test mytest("README.md","a=1/(q+1)","Frac{Pol{Int64}}: 1/(q+1)")
@test mytest("README.md","Pol(2/a)","Pol{Int64}: 2q+2")
@test mytest("README.md","numerator(a)","Pol{Int64}: 1")
@test mytest("README.md","denominator(a)","Pol{Int64}: q+1")
@test mytest("README.md","m=[q+1 q+2;q-2 q-3]","2×2 Matrix{Pol{Int64}}:\n q+1  q+2\n q-2  q-3")
@test mytest("README.md","n=inv(Frac.(m))","2×2 Matrix{Frac{Pol{Int64}}}:\n (-q+3)/(2q-1)  (-q-2)/(-2q+1)\n (q-2)/(2q-1)   (q+1)/(-2q+1)")
@test mytest("README.md","map(x->x(1),n)","2×2 Matrix{Float64}:\n  2.0   3.0\n -1.0  -2.0")
@test mytest("README.md","map(x->x(1;Rational=true),n)","2×2 Matrix{Rational{Int64}}:\n  2//1   3//1\n -1//1  -2//1")
end
@testset "LaurentPolynomials.jl" begin
@test mytest("LaurentPolynomials.jl","gcd(2q+2,q^2-1)","Pol{Int64}: q+1")
@test mytest("LaurentPolynomials.jl","gcd(q+1//1,q^2-1//1)","Pol{Rational{Int64}}: (1//1)q+1//1")
@test mytest("LaurentPolynomials.jl","gcdx(q^3-1//1,q^2-1//1)","((1//1)q-1//1, 1//1, (-1//1)q)")
@test mytest("LaurentPolynomials.jl","powermod(q-1//1,3,q^2+q+1)","Pol{Rational{Int64}}: (6//1)q+3//1")
@test mytest("LaurentPolynomials.jl","p=Pol([1,1,1])","Pol{Int64}: q²+q+1")
@test mytest("LaurentPolynomials.jl","vals=p.(1:5)","5-element Vector{Int64}:\n  3\n  7\n 13\n 21\n 31")
@test mytest("LaurentPolynomials.jl","Pol(1:5,vals*1//1)","Pol{Rational{Int64}}: (1//1)q²+(1//1)q+1//1")
@test mytest("LaurentPolynomials.jl","Pol(1:5,vals*1.0)","Pol{Float64}: 1.0q²+1.0q+1.0")
end
end
