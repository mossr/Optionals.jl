struct Customer
    firstName::String
    lastName::String
    phoneNumber::String
end

struct Address
    number::String
    street::String
    city::String
    state::String
    zip::String
    country::String
end

const bar = repeat("-",10)

import Base.println
println(customers::Vector{Customer}) = map(println, customers)
function println(addresses::Vector{Address})
    for address in addresses
        println(bar)
        println(address.number, " ", address.street)
        println(address.city, ", ", address.state, ", ", address.country)
        println(address.zip)
        println(bar)
    end
end

flatmap(c::Optional{T}) where {T} = ismissing(c) ? println("Could not create a customer for: $c") == Nothing : isthere(c)

barprintln(str::String) = printstyled(bar, str, bar, '\n')


"""
An example and test of the Optional type with customers and addresses.
"""
function optional_testing()

    ## Customers
    customerTuples::Vector{OptionalTupleType(Customer)} = [
        ("Patrick", "McGee", "6035555555"),
        ("Ruble", "Moses", missing),
        ("Robert", "Moss", "9785555555"),
        (missing, "Fontina", missing)
    ]

    ## Partial customers
    maybeCustomers::Vector{Optional{Customer}} = map(x->yield(Customer, x), customerTuples)
    barprintln("Maybe Customers")
    map(c->@info(c), maybeCustomers)

    ## Good customers (with logging)
    barprintln("Only full customers (logging)")
    goodCustomersLogging::Vector{Customer} = filter(flatmap, maybeCustomers)
    @info goodCustomersLogging

    ## Good customers (full)
    barprintln("Only full customers")
    goodCustomers::Vector{Customer} = filter(isthere, maybeCustomers)
    @info goodCustomers

    ## Addresses
    addressTuples::Vector{OptionalTupleType(Address)} = [
        ("42", "Garden Road", "Woburn", "MA", "01801", "USA"),
        (missing, missing, "Boston", "MA", missing, "USA"),
        (missing, missing, "Rockport", "MA", missing, "USA"),
        ("7", "Harvard Street", "Cambridge", "MA", "02138", "USA"),
        (missing, "Powow Street", missing, "MA", missing, "USA")
    ]

    barprintln("Addresses")
    goodAddresses::Vector{Address} = filter(isthere, map(x->yield(Address, x), addressTuples))
    @info goodAddresses

    return nothing
end

@test optional_testing() === nothing