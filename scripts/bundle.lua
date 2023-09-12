-- Executes command.
-- Raises an error on failure.
local function exec(command)
  if not os.execute(command) then
    error "command failed"
  end
end

exec "mkdir -p build"

local args = "igt igt.html igt.parser"
local opts = "-s src/filter.lua -o build/filter.lua -p scripts/license.lua"
local command = "lua_modules/bin/amalg.lua %s %s"
exec(command:format(args, opts))
