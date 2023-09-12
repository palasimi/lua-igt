# Contributing

This guide assumes that you have a working installation of [lua](https://www.lua.org/download.html) and [luarocks](https://github.com/luarocks/luarocks/wiki/Download).

To get started, run the following command in the root directory of the project.

```bash
luarocks init
luarocks make
```

## Running tests

```bash
luarocks test
```

This will automatically install testing dependencies and run all tests and linters.

## Pandoc filter

The source code for the pandoc filter can be found at `src/filter.lua`.
This needs to be built before it can be used as a filter.

```bash
lua scripts/bundle.lua
```

This will build the filter in the `build` directory.
See the `examples` for usage instructions.
