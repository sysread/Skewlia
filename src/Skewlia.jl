"""
Skewlia

    h = Skewlia.SkewHeap()

"""
module Skewlia

import Base.+
import Base.iterate

struct SkewNode
    left::Union{SkewNode, Nothing}
    right::Union{SkewNode, Nothing}
    item

    SkewNode(item, left=nothing, right=nothing) = new(left, right, item)
end

const Node = Union{SkewNode, Nothing}

(+)(a::Nothing,  b::Nothing)  = nothing
(+)(a::SkewNode, b::Nothing)  = a
(+)(a::Nothing,  b::SkewNode) = b

function (+)(a::SkewNode, b::SkewNode)
    if a.item <= b.item
        SkewNode(a.item, b + a.right, a.left)
    else
        b + a
    end
end


"""    SkewHeap() ::SkewHeap

Initialize a new skew heap. Elements inserted into the heap will be ordered
using `<=`.
"""
mutable struct SkewHeap
    size::UInt64
    root::Node

    SkewHeap() = new(0, nothing)
end


"""    iterate(h::SkewHeap)

Returns an iterator that will sequentially retrieve each item from the heap.
Adding new items while iterating over the heap is perfectly acceptable.
"""
function Base.iterate(h::SkewHeap, state=true)
    if is_empty(h)
        return nothing
    else
        return take!(h), true
    end
end


"""    length(h::SkewHeap)

Returns the number of items in the heap.
"""
function length(h::SkewHeap)
    return h.size
end


"""    is_empty(h::SkewHeap)

Returns true if the heap is empty.
"""
function is_empty(h::SkewHeap)
    return length(h) == 0
end


"""    put(h::SkewHeap, items...)

Inserts new items into the heap and returns the heap's new size.
"""
function put!(h::SkewHeap, items...)
    for item in items
        h.root = h.root + SkewNode(item, nothing, nothing)
        h.size += 1
    end

    return h.size
end


"""    take(h::SkewHeap)

Removes and returns the next item from the heap or `nothing` if it is empty.
"""
function take!(h::SkewHeap)
    if h.size > 0
        item = h.root.item
        h.root = h.root.left + h.root.right
        h.size -= 1
        return item
    end

    return nothing
end


"""    peek(h::SkewHeap)
Returns the next item from the heap without removing it, or `nothing` if empty.
"""
function peek(h::SkewHeap)
    if h.size > 0
        return h.root.item
    end

    return nothing
end


"""    explain(h::SkewHeap)

Prints out the structure of the heap.
"""
function explain(n::SkewNode, indent)
    print(repeat("  ", indent))
    println(" - ", n.item)

    explain(n.left, indent + 1)
    explain(n.right, indent + 1)
end

function explain(n::Nothing, indent)
    print(repeat("  ", indent))
    println(" - Leaf")
end

function explain(h::SkewHeap)
    println("SkewHeap(size=", h.size, ")")
    println("  -Root:")
    explain(h.root, 1)
end


end
