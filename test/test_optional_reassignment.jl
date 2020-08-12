@test begin
    let x::Optional{Int} = 10
        x = missing # works!
    end
end === missing


@test begin
    try
        let x::Int = 10
            x = missing # errors!
        end
        return false
    catch err
        return true # this _should_ error.
    end
end