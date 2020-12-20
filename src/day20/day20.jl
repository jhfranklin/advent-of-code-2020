using AdventOfCode2020

getinput() = readlines(getInputPath(20),keep=true)

function convertedge(x::BitVector)
    n = length(x)
    return sum(x .<< (0:(n-1)))
end

struct Tile
    id::Int
    array::BitMatrix
    edges::Dict{Symbol,Int}

    function Tile(id, array)
        vectorEdges = Dict{Symbol,BitVector}(
            :N => array[1,:],
            :E => array[:,end],
            :S => array[end,:],
            :W => array[:,1],
        )
        vectorEdges[:Nf] = reverse(vectorEdges[:N])
        vectorEdges[:Ef] = reverse(vectorEdges[:E])
        vectorEdges[:Sf] = reverse(vectorEdges[:S])
        vectorEdges[:Wf] = reverse(vectorEdges[:W])
        edges = Dict{Symbol,Int}()
        for (k, v) in vectorEdges
            edges[k] = convertedge(v)
        end
        array = array[2:end-1, 2:end-1] # border not part of actual image
        return new(id, array, edges)
    end
end

struct PlacedTile
    tile::Tile
    rot::Int # rotate first, then flip
    ref::Bool
end

function createtiles(input)
    numberOfTiles = length(input) ÷ 12
    tiles = Array{Tile}(undef,numberOfTiles)
    for i in 1:numberOfTiles
        rawData = strip.(input[(i-1)*12 + 1:12*i - 1])
        id = parse(Int,rawData[1][6:end-1])
        rawTile = permutedims(hcat(collect.(strip.(input[(i-1)*12 + 2:12*i - 1]))...))
        array = BitArray([x == '#' for x in rawTile])
        tiles[i] = Tile(id, array)
    end
    return tiles
end

function createedgedict(tiles)
    edgeDict = Dict{Int,Set{Tile}}()
    for t in tiles
        for (k,e) in t.edges
            current = get(edgeDict,e,Set{Tile}())
            edgeDict[e] = push!(current, t)
        end
    end
    return edgeDict
end

function getborderedges(edges)
    jigsawBorderEdges = Set{Int}()
    for (edge, tileset) in edges
        if length(tileset) == 1
            push!(jigsawBorderEdges, edge)
        end
    end
    return jigsawBorderEdges
end

function getcorners(tiles, borders)
    corners = Set{Tile}()
    for t in tiles
        numBorders = 0
        for (k,te) in t.edges
            if te ∈ borders
                numBorders += 1
            end
        end
        if numBorders == 4
            push!(corners, t)
        end
    end
    return corners
end

function part1()
    tiles = getinput() |> createtiles
    edges = createedgedict(tiles)
    borderEdges = getborderedges(edges)
    corners = getcorners(tiles, borderEdges)
    return prod([t.id for t in corners])
end

println("part 1: ", part1())

tiles = getinput() |> createtiles
edges = createedgedict(tiles)
borderEdges = getborderedges(edges)
corners = getcorners(tiles, borderEdges)

#= 
function part2()
    tiles = getinput() |> createtiles
    edges = createedgedict(tiles)
    borderEdges = getborderedges(edges)
    corners = getcorners(tiles, borderEdges)
    flatPicture = Array{} =#