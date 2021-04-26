using Test

mutable struct Foo
    i::Int
    s::String
end
Base.==(b1::Foo, b2::Foo) = b1.i == b2.i && b1.s == b2.s

@testset "FlatBuffersTypeSerializers" begin
    foo_value = Foo(integer_value, string_value)
    stream = serialize(FlatBuffersTypeSerializer{Foo}, foo_value)
    seekstart(stream)
    @test deserialize(FlatBuffersTypeSerializer{Foo}, stream) == foo_value
end
