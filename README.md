# lua-igt

Pure lua module for converting interlinear glosses to HTML.

Available as a library and as a pandoc filter.

## Installation

```bash
luarocks install lua-igt
```

Or [download](https://github.com/palasimi/lua-igt/releases).

## Library usage

```lua
-- example.lua
local igt = require "igt"

local html = igt.compile [[
    ne-e a-khim-chi n-yuNNa
    DEM-LOC 1SG.POSS-house-PL 3NSG-be.NPST
    "Here are my houses."
]]

print(html)
```

(Example taken from the [Leipzig Glossing Rules](https://www.eva.mpg.de/lingua/resources/glossing-rules.php))

**Note**: If you installed `lua-igt` in a custom directory (e.g. `lua_modules`),
you may have to [update `package.path`](https://leafo.net/guides/customizing-the-luarocks-tree.html#the-install-locations/using-a-custom-directory/quick-guide/running-scripts-with-packages)
before loading `igt`, like so:

```lua
-- before.lua
local version = _VERSION:match "%d+%.%d+"
package.path = "lua_modules/share/lua/" .. version .. "/?.lua;lua_modules/share/lua/" .. version .. "/?/init.lua;" .. package.path
```

Then load `before.lua` before running the script:

```bash
lua -l before example.lua
```

## Pandoc filter usage

The pandoc filter converts every code block containing the `gloss` class into a nicely formatted gloss.
It tries to follow the conventions described by the [Leipzig Glossing Rules](https://www.eva.mpg.de/lingua/resources/glossing-rules.php).
There's a pre-defined list of glossing abbreviations, but you can define your own abbreviations using a YAML file.

See [examples](https://github.com/palasimi/lua-igt/tree/main/examples).

## Styling

Add this to your CSS stylesheet:

```css
.igt {
  margin: 1em 2em;
}
.igt-label {
  font-variant: small-caps;
  text-decoration: underline dashed;
  text-transform: lowercase;
}
```

## License

[MIT](./LICENSE)
