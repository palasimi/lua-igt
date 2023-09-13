#!/usr/bin/env bash

"pandoc$1" README.md -s --lua-filter ../../build/filter.lua
