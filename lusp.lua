local M = {}

symbol = tostring

env = {}

env['true'] = true
env['false'] = false
env['nil'] = nil

function reduce(f, acc, coll)
  for _, v in pairs(coll) do
    acc = f(acc, v)
  end
  return acc
end

function reduce1(f, coll)
  local x = table.remove(coll, 1)
  local xs = coll
  return reduce(f, x, xs)
end

env['+'] = function(...)
  return reduce(function(a, b) return a + b end, 0, {...})
end

env['*'] = function(...)
  return reduce(function(a, b) return a * b end, 1, {...})
end

env['-'] = function(...)
  return reduce1(function(a, b) return a - b end, {...})
end

env['/'] = function(...)
  return reduce1(function(a, b) return a / b end, {...})
end

function find(env, var)
  return env
end

function atom(token)
  return tonumber(token) or symbol(token)
end

function read_from(tokens)
  if #tokens == 0 then
    error('Unexpected EOF while reading.')
  end
  local token = pop(tokens)
  if '(' == token then
    local l = {}
    while tokens[1] ~= ')' do
      l[#l + 1] = read_from(tokens)
    end
    pop(tokens)
    return l
  elseif ')' == token then
    error('Unexpected )')
  else
    return atom(token)
  end
end

function isa(o, t)
  return type(o) == t
end

function eval(x, local_env)
  if not local_env then local_env = env end
  if isa(x, 'string') then
    return find(local_env, x)[x]
  elseif not isa(x, 'table') then
    return x
  elseif x[1] == 'quote' then
    pop(x)
    return unpack(x)
  elseif x[1] == 'if' then
    local _ = pop(x)
    local test = pop(x)
    local exprs = pop(x)
    local alt_exprs = pop(x)
    return eval(eval(test, env) and exprs or alt_exprs, local_env)
  elseif x[1] == 'set!' then
  elseif x[1] == 'define' then
    local _ = pop(x)
    local var = pop(x)
    local exp = pop(x)
    local_env[var] = eval(exp, local_env)
  elseif x[1] == 'lambda' then
  elseif x[1] == 'begin' then
  else
    local exps = map(function(exp) return eval(exp, env) end, x)
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
  local str = s:gsub('%(', ' ( '):gsub('%)', ' ) ')
  local tokens = {}
  for word in str:gmatch('%S+') do
    tokens[#tokens + 1] = word
  end
  return tokens
end

function read(s)
  return read_from(tokenize(s))
end

parse = read

function to_string(exp)
  return isa(exp, 'table')
           and '(' .. table.concat(map(to_string, exp), ' ') .. ')'
           or  tostring(exp)
end

function repl()
  while true do
    local val = eval(parse(io.read()), env)
    if val then
      print(to_string(val))
    end
  end
end

M.repl = repl

return M

