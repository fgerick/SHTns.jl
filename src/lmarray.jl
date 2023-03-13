struct LMIndex <: Base.IndexStyle; end

struct LMArray{T} <: AbstractArray{T,1}
    data::Array{T,1}
    nlm::Int
    lmax::Int
    mmax::Int
	mres::Int
end

function LM(lmax, mres, l,m)  
    return (Cint(m/mres)*(2*lmax + 2 - (m+mres)))>>1 + l + 1
end
# LMArray{T}(::Type{T}, n::Int, lb::Int = 0) = LMArray(Array{T,1}(n), n, lb, lb+n-1);
Base.size(a::LMArray) = (a.nlm,)
Base.IndexStyle(::Type{<:LMArray}) = LMIndex()
# Base.similar(a::LMArray, ::Type{T}, d::Dims{1}) where {T} = LMArray(T, d[1])
Base.getindex(a::LMArray, l::Int, m::Int) = a.data[LM(a.lmax,a.mres,l,m)]
Base.setindex!(a::LMArray, v, l::Int, m::Int) = (a.data[LM(a.lmax,a.mres,l,m)] = v)
# Base.indices(a::LMArray) = [(l,m) for m in 0:a.lmax for l in 0:a.lmax if m<=l]