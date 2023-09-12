-- Executes command.
-- Raises an error on failure.
local function exec(command)
  if not os.execute(command) then
    error "command failed"
  end
end

exec "mkdir -p build"

local args = "-o build/filter.lua -s src/filter.lua igt igt.html igt.parser"
local command = "lua_modules/bin/amalg.lua %s"
exec(command:format(args))
