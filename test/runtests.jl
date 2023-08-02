using Test: @testset, @test, @inferred
using Random: bitrand
using ConditionalSwaps: swap

@testset "swap (tests generated by copilot)" begin
    x = [1, 2, 3]
    y = [4, 5, 6]
    @test swap(falses(3), x, y) == swap(false, x, y) == (x, y)
    @test swap(trues(3), x, y)  == swap(true, x, y)  == (y, x)

    conditions = [true, false, true]
    x_new, y_new = swap(conditions, x, y)
    @test x_new == [4, 2, 6]
    @test y_new == [1, 5, 3]
end

@testset "swap (random tests)" begin
    cond = bitrand(10, 7)
    A = randn(size(cond))
    B = randn(size(cond))
    A_new, B_new = swap(cond, A, B)
    for i in 1:4, j in 1:3
        if cond[i,j] # swapped
            @test A_new[i,j] == B[i,j] && B_new[i,j] == A[i,j]
        else # not swapped
            @test A_new[i,j] == A[i,j] && B_new[i,j] == B[i,j]
        end
    end
    swap((!).(cond), A, B) == swap(cond, B, A)
end
