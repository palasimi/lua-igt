#!/usr/bin/env bash

"pandoc$1" README.md -s --lua-filter ../../build/filter.lua \
	--include-in-header style.html \
	--metadata-file metadata.yaml
