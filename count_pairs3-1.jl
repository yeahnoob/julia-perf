function groupby{T} (fn, seq::Array{T})
    dict = Dict{Any, Array{T}}()
    #set the initial-size of "dict", for better running time performance.
    sizehint(dict, length(seq) >> 5)
    for item in seq
        key = fn(item)
        if !haskey(dict, key)
            dict[key] = []
        end
        push!(dict[key], item)
    end
    return dict
end

function wordreduce(ss::String)
    t = split(strip(ss), ',', 50)
    return t
end

function processdata(filename::String)
    file = open(filename, "r")
    try
        lines::Array{String,1} = readlines(file)
        @time begin
            global wordreduce
            word_pairs::Array{Array{String,1},1}  = map(wordreduce, lines)
        end
        global groupby
        result = groupby(a->a[1], word_pairs)
        return result
    finally
        close(file)
    end
end

println("... Process \"dummy.txt\" and \"word-paris.txt\" ", int(ARGS[1]), " Times ...")

for i = 1:int(ARGS[1])
    processdata("dummy.txt")
    # wait for sevaral seconds, take easy.:) Hardisk I/O
    y = 0
    for i = 1:10^8
        ret = i
        ret = i + 2
        ret = i + 1
        y += ret
    end
    processdata("word-pairs.txt")
end

None 
