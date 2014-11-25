### Commentary:
### With JuliaLang v0.4-dev

@everywhere function groupby (fn, seq::Array)
    dict = Dict{String, Array}()
    #set the initial-size of "dict", for better running time performance.
    #sizehint(dict, length(seq) >> 5)
    for item in seq
        key = fn(item)
        if !haskey(dict, key)
            dict[key] = Any[]
        end
        push!(dict[key], item)
    end
    return dict
end

function processdata(filename::String)
    file = open(filename, "r")
    lines = readlines(file)

    rrefs = Any[]
    wpairs = Any[]
    np = nprocs()
    unitsize = ceil(length(lines)/np)
    for i in 1:np
        first = unitsize*(i-1)+1
        last = unitsize*i
        if last>length(lines)
            last = length(lines)
        end
        sublines = lines[int(first):int(last)]
        word_pairs = map(s->split(strip(s), ','; limit=2), sublines)
        global groupby
        push!( rrefs, @spawn groupby( a->a[1], word_pairs ) )
    end
    
    # fetch results
    while length(rrefs) > 0
        push!( wpairs, fetch( pop!(rrefs) ) )
    end
    return wpairs
    close(file)
end

function wpreduce(wp,keyword)
    count = 0
    for c in wp, (k,v) in c
        if k==keyword
            count += length(v)
        end
    end
    return count
end

println("... Process \"word-paris.txt\" ", int(ARGS[1]), " Times ...")

for i = 1:int(ARGS[1])
    
    # wait for sevaral seconds, take easy.:) Hardisk I/O
    y = 0
    for i = 1:10^8
        ret = i
        ret = i + 2
        ret = i + 1
        y += ret
    end
    print( "... [Map] time performance :\t")
    @time begin
        result = processdata("word-pairs.txt")
    end
    print( "... [Reduce] time performance :\t")
    @time wpcount = wpreduce(result,"her")
    println( "...... pairs of [\"her\"] = ", wpcount  )
end

None 
