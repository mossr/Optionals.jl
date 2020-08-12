"""
Light-weight Optional types in Julia.
"""
module Optionals

export Optional,
       isthere,
       OptionalTupleType,
       TupleType,
       yield

const Optional{T} = Union{T, Missing}

isthere(var::Optional{T}) where {T} = !isa(var, Missing)
isthere(var::Optional{T}) where {T <: String} = !isa(var, Missing) && !isempty(var)

OptionalTupleType(T) = Tuple{map(t->Optional{t}, T.types)...}
TupleType(T) = Tuple{T.types...} # e.g. creates a Tuple{String,String,String}

import Base.yield
yield(::Type{T}, x::Tuple) where {T} = all(map(isthere, x)) ? T(x...) : missing


end # module