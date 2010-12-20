symbol = tostring

env = {}
env["+"] = function(...)
    local sum = 0
    for _, v in pairs({...}) do
        sum = sum + v
    end
    return sum
end

function env:find(var)
    return self
end


function atom(token)
    return tonumber(token) or symbol(token)
end

function read_from(tokens)
    if #tokens == 0 then
        error("Unexpected EOF while reading.")
    end
    local token = pop(tokens)
    if "(" == token then
        local l = {}
        while tokens[1] ~= ")" do
            l[#l + 1] = read_from(tokens)
        end
        pop(tokens)
        return l
    elseif ")" == token then
        error("Unexpected )")
    else
        return atom(token)
    end
end

function isa(o, t)
    return type(o) == t
end

function eval(x)
    if isa(x, "string") then
        return env:find(x)[x]
    elseif not isa(x, "table") then
        return x
    elseif x[1] == "quote" then
        pop(x)
        return unpack(x)
    elseif x[1] == "if" then
    elseif x[1] == "set!" then
    elseif x[1] == "define" then
    elseif x[1] == "lambda" then
    elseif x[1] == "begin" then
    else
        local exps = map(eval, x)
        local proc = pop(exps)
        return proc(unpack(exps))
    end
end

function map(f, t)
    local res = {}
    for _, v in pairs(t) do
        res[#res + 1] = f(v)
    end
    return res
end

function pop(t)
    return table.remove(t, 1)
end

function tokenize(s)
    local str = s:gsub("%(", " ( "):gsub("%)", " ) ")
    local tokens = {}
    for word in str:gmatch("%S+") do
        tokens[#tokens + 1] = word
    end
    return tokens
end

function read(s)
    return read_from(tokenize(s))
end

parse = read

function to_string(exp)
    return isa(exp, "table")
        and "(" .. table.concat(map(to_string, exp), " ") .. ")"
        or  tostring(exp)
end

function repl()
    while true do
        local val = eval(parse(io.read()))
        if val then
            print(to_string(val))
        end
    end
end

repl()
