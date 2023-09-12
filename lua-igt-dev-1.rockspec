package = "lua-igt"
version = "dev-1"
rockspec_format = "3.0"
source = {
   url = "git://github.com/palasimi/lua-igt"
}
description = {
   summary = "Pure lua module for converting interlinear glosses to HTML",
   detailed = [[
      Pure lua module for converting interlinear glosses to HTML.
      Available as a library and as a pandoc filter.
   ]],
   homepage = "https://github.com/palasimi/lua-igt",
   license = "MIT"
}
dependencies = {
   "lua >= 5.1, < 5.5"
}
build_dependencies = {
   "amalg"
}
test_dependencies = {
   "busted",
   "luacheck"
}
build = {
   type = "builtin",
   modules = {
      igt = "src/init.lua",
      ["igt.html"] = "src/html.lua",
      ["igt.parser"] = "src/parser.lua"
   }
}
test = {
   type = "command",
   script = "scripts/test.lua"
}
