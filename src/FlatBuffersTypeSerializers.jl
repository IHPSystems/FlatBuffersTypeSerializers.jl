module FlatBuffersTypeSerializers

using FlatBuffers
using TypeSerializers

export FlatBuffersTypeSerializer, serialize, deserialize

abstract type FlatBuffersTypeSerializer{T} <: AbstractTypeSerializer{T} end

function serialize(::Type{TSerializer}, value::T)::IO where {T, TSerializer <: FlatBuffersTypeSerializer{T}}
    buffer = FlatBuffers.build!(value)
    data = FlatBuffers.bytes(buffer)
    return IOBuffer(data, read = true, write = true)
end

function deserialize(::Type{TSerializer}, stream::IO)::T where {T, TSerializer <: FlatBuffersTypeSerializer{T}}
    return FlatBuffers.deserialize(stream, T)
end

end
