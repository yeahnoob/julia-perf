function groupby{T} (fn, seq::Array{T})
    dict = Dict{Any, Array{T}}()
    for item in seq
        key = fn(item)
        if !haskey(dict, key)
            dict[key] = []
        end
        push!(dict[key], item)
    end
    return dict
end

function processdata(filename::String)
    file = open(filename)
    lines = readlines(file)
    #lines = convert(Array{String, 1}, map(strip, lines))
    lines = map(strip, lines)
    word_pairs = map(s->split(s, ','), lines)
    #@time begin
        result = groupby(a->a[1], word_pairs)
    #end
end

processdata("dummy.txt")
processdata("word-pairs2.txt")
processdata("dummy.txt")

@time begin
    processdata("word-pairs.txt")
end

None 
