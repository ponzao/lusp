local lusp = require('lusp')

function repl()
  while true do
    local val = lusp.eval(lusp.parse(io.read()), lusp.env)
    if val then
      print(lusp.to_string(val))
    end
  end
end

repl()

