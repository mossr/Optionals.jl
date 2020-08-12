# Optionals.jl
Light-weight `Optional{T}` types in Julia. Inspired by the [`Option`](https://www.scala-lang.org/api/current/scala/Option.html) type in Scala.

The `Optional{T}` is a simple alias for:
```julia
const Optional{T} = Union{T, Missing}
```

## Installation
```julia
] add https://github.com/mossr/Optionals.jl
```

## Usage
```julia
using Optionals
```

#### Example: Reassignment
```julia
let x::Optional{Int} = 10
    x = missing # works!
end
```
```julia
let x::Int = 10
    x = missing # errors!
end
```

#### Example: `isthere`
```julia
function example(input::Optional{Int})
    if isthere(input)
        println("The input $input is not missing!")
    else
        println("Input is missing.")
    end
end
```

```julia
julia> example(123)
The input 123 is not missing!

julia> example(missing)
Input is missing.
```


As see [`test_optional_customers.jl`](https://github.com/mossr/Optionals.jl/blob/master/test/test_optional_customers.jl) for a more detailed example.