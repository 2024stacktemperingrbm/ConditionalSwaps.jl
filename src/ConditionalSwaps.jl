module ConditionalSwaps


"""
    swap(conditions, x, y)

Returns `a, b`, where `a[i], b[i] == y[i], x[i]` or `a[i], b[i] == x[i], y[i]`,
depending to whether the corresponding `condition[i]` is true or false.
"""
function swap(conditions::Union{AbstractArray{Bool}, Bool}, x, y)
    x_new = ifelse.(conditions, y, x)
    y_new = ifelse.(conditions, x, y)
    return x_new, y_new
end


"""
    swap!(x, y, conditions)

Sets `x[i], y[i] == y[i], x[i]` or `x[i], y[i] == x[i], y[i]` in-place,
depending to whether the corresponding `condition[i]` is true or false.
"""
function swap!(x::AbstractArray, y::AbstractArray, conditions::AbstractArray{Bool})
    if size(x) == size(y) == size(conditions)
        for i in eachindex(x, y, conditions)
            if conditions[i]
                x[i], y[i] = y[i], x[i]
            else
                x[i], y[i] = x[i], y[i]
            end
        end
        return x, y
    else
        throw(DimensionMismatch("x, y and conditions must have the same size"))
    end
end

function swap!(x::AbstractArray, y::AbstractArray, condition::Bool)
    if size(x) == size(y)
        for i in eachindex(x, y)
            if condition
                x[i], y[i] = y[i], x[i]
            else
                x[i], y[i] = x[i], y[i]
            end
        end
        return x, y
    else
        throw(ArgumentError("x and y must have the same size"))
    end
end


end # module
