using Optionals
using Test

@testset "optional" begin
    testdir = joinpath(dirname(@__DIR__), "test")
    @testset "customers" begin
        include(joinpath(testdir, "test_optional_customers.jl"))
    end
end