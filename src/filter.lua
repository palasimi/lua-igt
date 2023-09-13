-- This needs to be built using scripts/bundle.lua.

local igt = require "igt"
local pandoc = require "pandoc"

local indent = require("igt.strings").indent

local config = {ignore_errors = false}

-- Gets custom glossing abbreviations from document meta information.
local function get_abbreviations(m)
	local t = {}
	for k, v in pairs(m["glossing-abbreviations"] or {}) do
		t[k] = pandoc.utils.stringify(v)
	end
	return t
end

-- Initializes gloss compiler.
local function Meta(m)
	if m["igt-ignore-errors"] then
		config.ignore_errors = true
	end
	for k, v in pairs(get_abbreviations(m)) do
		igt.config.abbreviations[k] = v
	end
end

-- Checks if the code block has a "gloss" class.
local function is_gloss(block)
	for _, class in ipairs(block.classes) do
		if class == "gloss" then
			return true
		end
	end
	return false
end

-- Formats "gloss" code blocks.
local function CodeBlock(block)
	if not is_gloss(block) then
		return
	end

	local template = [[%s

%s

Pass "--metadata igt-ignore-errors" to pandoc to ignore glossing errors.
]]
	local ok, html = pcall(igt.compile, block.text)
	if not ok then
		if config.ignore_errors then
			return
		end

		local message = template:format(html, indent(block.text))
		error(message, 0)
	end

	local doc = pandoc.read(html, "html")
	return doc.blocks[1]
end

return {
	{Meta = Meta},
	{CodeBlock = CodeBlock},
}
