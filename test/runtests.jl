# auto-generated tests from julia-repl docstrings
using Test, LaurentPolynomials, LinearAlgebra
function mytest(file::String,cmd::String,man::String)
  println(file," ",cmd)
  exec=repr(MIME("text/plain"),eval(Meta.parse(cmd)),context=:limit=>true)
  if endswith(cmd,";") exec="nothing" 
  else exec=replace(exec,r"\s*$"m=>"")
       exec=replace(exec,r"\s*$"s=>"")
  end
  if exec!=man 
    i=1
    while i<=lastindex(exec) && i<=lastindex(man) && exec[i]==man[i]
      i=nextind(exec,i)
    end
    print("exec=$(repr(exec[i:end]))\nmanl=$(repr(man[i:end]))\n")
  end
  exec==man
end
@testset verbose = true "Gapjm" begin
@testset "LaurentPolynomials.jl" begin
@test mytest("LaurentPolynomials.jl","Pol(:q)","Pol{Int64}: q")
@test mytest("LaurentPolynomials.jl","@Pol q","Pol{Int64}: q")
@test mytest("LaurentPolynomials.jl","Pol([1,2])","Pol{Int64}: 2q+1")
@test mytest("LaurentPolynomials.jl","2q+1","Pol{Int64}: 2q+1")
@test mytest("LaurentPolynomials.jl","Pol()","Pol{Int64}: q")
@test mytest("LaurentPolynomials.jl","p=Pol([1,2,1],-1)","Pol{Int64}: q+2+q⁻¹")
@test mytest("LaurentPolynomials.jl","q+2+q^-1","Pol{Int64}: q+2+q⁻¹")
@test mytest("LaurentPolynomials.jl","valuation(p),degree(p)","(-1, 1)")
@test mytest("LaurentPolynomials.jl","p[0], p[1], p[-1], p[10]","(2, 1, 1, 0)")
@test mytest("LaurentPolynomials.jl","p[valuation(p):degree(p)]","3-element Vector{Int64}:\n 1\n 2\n 1")
@test mytest("LaurentPolynomials.jl","p[begin:end]","3-element Vector{Int64}:\n 1\n 2\n 1")
@test mytest("LaurentPolynomials.jl","coefficients(p)","3-element Vector{Int64}:\n 1\n 2\n 1")
@test mytest("LaurentPolynomials.jl","Pol(1)","Pol{Int64}: 1")
@test mytest("LaurentPolynomials.jl","convert(Pol{Int},1)","Pol{Int64}: 1")
@test mytest("LaurentPolynomials.jl","scalar(Pol(1))","1")
@test mytest("LaurentPolynomials.jl","convert(Int,Pol(1))","1")
@test mytest("LaurentPolynomials.jl","Int(Pol(1))","1")
@test mytest("LaurentPolynomials.jl","scalar(q+1)","nothing")
@test mytest("LaurentPolynomials.jl","derivative(p)","Pol{Int64}: 1-q⁻²")
@test mytest("LaurentPolynomials.jl","p=(q+1)^2","Pol{Int64}: q²+2q+1")
@test mytest("LaurentPolynomials.jl","p/2","Pol{Float64}: 0.5q²+1.0q+0.5")
@test mytest("LaurentPolynomials.jl","p//2","Pol{Rational{Int64}}: (1//2)q²+(1//1)q+1//2")
@test mytest("LaurentPolynomials.jl","p(1//2)","9//4")
@test mytest("LaurentPolynomials.jl","p(0.5)","2.25")
@test mytest("LaurentPolynomials.jl","Pol(1:3,[2.0,1.0,3.0])","Pol{Float64}: 1.5q²-5.5q+6.0")
@test mytest("LaurentPolynomials.jl","p=Pol([[1 1;0 1],[1 0; 0 1]])","Pol{Matrix{Int64}}: [1 0; 0 1]q+[1 1; 0 1]")
@test mytest("LaurentPolynomials.jl","p^3","Pol{Matrix{Int64}}: [1 0; 0 1]q³+[3 3; 0 3]q²+[3 6; 0 3]q+[1 3; 0 1]")
@test mytest("LaurentPolynomials.jl","divrem(q^3+1,2q+1)","(0.5q²-0.25q+0.125, 0.875)")
@test mytest("LaurentPolynomials.jl","divrem(q^3+1,2q+1//1)","((1//2)q²+(-1//4)q+1//8, 7//8)")
@test mytest("LaurentPolynomials.jl","pseudodiv(q^3+1,2q+1)","(4q²-2q+1, 7)")
@test mytest("LaurentPolynomials.jl","(4q^2-2q+1)*(2q+1)+7","Pol{Int64}: 8q³+8")
@test mytest("LaurentPolynomials.jl","LinearAlgebra.exactdiv(q+1,2.0)","Pol{Float64}: 0.5q+0.5")
@test mytest("LaurentPolynomials.jl","a=1/(q+1)","Frac{Pol{Int64}}: 1/(q+1)")
@test mytest("LaurentPolynomials.jl","Pol(2/a)","Pol{Int64}: 2q+2")
@test mytest("LaurentPolynomials.jl","numerator(a)","Pol{Int64}: 1")
@test mytest("LaurentPolynomials.jl","denominator(a)","Pol{Int64}: q+1")
@test mytest("LaurentPolynomials.jl","m=[q+1 q+2;q-2 q-3]","2×2 Matrix{Pol{Int64}}:\n q+1  q+2\n q-2  q-3")
@test mytest("LaurentPolynomials.jl","n=inv(Frac.(m))","2×2 Matrix{Frac{Pol{Int64}}}:\n (-q+3)/(2q-1)  (-q-2)/(-2q+1)\n (q-2)/(2q-1)   (q+1)/(-2q+1)")
@test mytest("LaurentPolynomials.jl","map(x->x(1),n)","2×2 Matrix{Float64}:\n  2.0   3.0\n -1.0  -2.0")
@test mytest("LaurentPolynomials.jl","map(x->x(1;Rational=true),n)","2×2 Matrix{Rational{Int64}}:\n  2//1   3//1\n -1//1  -2//1")
@test mytest("LaurentPolynomials.jl","pseudodiv(q^2+1,2q+1)","(2q-1, 5)")
@test mytest("LaurentPolynomials.jl","(2q+1)*(2q-1)+5","Pol{Int64}: 4q²+4")
@test mytest("LaurentPolynomials.jl","srgcd(4q+4,6q^2-6)","Pol{Int64}: 2q+2")
@test mytest("LaurentPolynomials.jl","gcd(2q+2,2q^2-2)","Pol{Int64}: 2q+2")
@test mytest("LaurentPolynomials.jl","gcd((2q+2)//1,(2q^2-2)//1)","Pol{Rational{Int64}}: (1//1)q+1//1")
@test mytest("LaurentPolynomials.jl","gcdx(q^3-1//1,q^2-1//1)","((1//1)q-1//1, 1//1, (-1//1)q)")
@test mytest("LaurentPolynomials.jl","powermod(q-1//1,3,q^2+q+1)","Pol{Rational{Int64}}: (6//1)q+3//1")
@test mytest("LaurentPolynomials.jl","p=Pol([1,1,1])","Pol{Int64}: q²+q+1")
@test mytest("LaurentPolynomials.jl","vals=p.(1:5)","5-element Vector{Int64}:\n  3\n  7\n 13\n 21\n 31")
@test mytest("LaurentPolynomials.jl","Pol(1:5,vals*1//1)","Pol{Rational{Int64}}: (1//1)q²+(1//1)q+1//1")
@test mytest("LaurentPolynomials.jl","Pol(1:5,vals*1.0)","Pol{Float64}: 1.0q²+1.0q+1.0")
end
end
