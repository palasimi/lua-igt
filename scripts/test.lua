-- Executes command.
-- Raises an error on failure.
local function exec(command)
  if not os.execute(command) then
    error "command failed"
  end
end

exec "lua_modules/bin/busted"
exec "lua_modules/bin/luacheck src spec scripts"
