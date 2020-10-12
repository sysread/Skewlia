using Skewlia
using Random
using Test

@testset "SkewNode" begin
    h = Skewlia.SkewHeap()
    a = Skewlia.SkewNode(1)
    b = Skewlia.SkewNode(4)

    @test nothing + nothing === nothing
    @test a + nothing === a
    @test nothing + b === b
    @test a + b == Skewlia.SkewNode(1, b, nothing) # in order
    @test b + a == Skewlia.SkewNode(1, b, nothing) # out of order
end

@testset "SkewHeap" begin
    ordered = 0:9
    shuffled = Random.shuffle(ordered)

    h = Skewlia.SkewHeap()
    @test Skewlia.take!(h) === nothing
    @test Skewlia.peek(h) === nothing
    @test Skewlia.length(h) == 0
    @test Skewlia.is_empty(h)

    @test Skewlia.put!(h, shuffled...) == length(shuffled)
    @test Skewlia.length(h) == length(shuffled)

    size = length(shuffled)

    for i in ordered
        @test Skewlia.length(h) == size

        size -= 1

        @test Skewlia.peek(h) == i
        @test Skewlia.take!(h) == i
        @test Skewlia.peek(h) != i
        @test Skewlia.length(h) == size
    end

    @test Skewlia.take!(h) === nothing
    @test Skewlia.peek(h) === nothing
    @test Skewlia.length(h) == 0
    @test Skewlia.is_empty(h)
end

@testset "Iteration" begin
    ordered = 0:9
    shuffled = Random.shuffle(ordered)

    h = Skewlia.SkewHeap()
    Skewlia.put!(h, shuffled...)

    expect = 0
    for i in h
       @test i == expect
       expect += 1
    end
end
