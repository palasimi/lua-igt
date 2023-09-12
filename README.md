# lua-igt

Pure lua module for converting interlinear glosses to HTML.

Available as a library and as a [pandoc filter](https://github.com/palasimi/lua-igt/releases).

## Library usage

```lua
local igt = require "igt"

local html = igt.compile [[
    ne-e a-khim-chi n-yuNNa
    DEM-LOC 1SG.POSS-house-PL 3NSG-be.NPST
    "Here are my houses."
]]

print(html)
```

(Example taken from the [Leipzig Glossing Rules](https://www.eva.mpg.de/lingua/resources/glossing-rules.php))

## Pandoc filter usage

See [examples](./examples).

## License

[MIT](./LICENSE)
