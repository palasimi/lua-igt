local strings = require "igt.strings"

local iter_lines = strings.iter_lines
local iter_words = strings.iter_words
local trim = strings.trim

-- Iterates over morphemes of word.
local function iter_morphemes(w)
	return string.gmatch(w, "[^-]+")
end

-- Splits string into segments of morphemes, dashes and spaces.
local function split_segments(s)
	local t = {}
	for w in iter_words(s) do
		-- Insert space between words.
		if #t > 0 then
			table.insert(t, " ")
		end

		for m in iter_morphemes(w) do
			-- Insert dash between morphemes in words.
			if t[#t] ~= nil and t[#t] ~= " " then
				table.insert(t, "-")
			end

			-- Insert morpheme.
			table.insert(t, m)
		end
	end
	return t
end

-- Checks if the two segment sequences are aligned.
-- Two sequences are aligned if they contain word at morpheme boundaries at
-- exactly the same positions.
local function is_aligned(s, t)
	if #s ~= #t then
		return false
	end

	for i = 1, #s do
		if s[i] == " " and t[i] ~= " " then
			return false
		end
		if s[i] == "-" and t[i] ~= "-" then
			return false
		end
	end
	return true
end

-- Parses interlinear gloss.
-- Raises an error if there's something wrong with the input.
local function parse(interlinear)
	local lines = {}
	for line in iter_lines(interlinear) do
		local trimmed = trim(line)
		if #trimmed > 0 then
			table.insert(lines, trimmed)
		end
	end

	if #lines < 3 then
		error "missing text, gloss or translation"
	end

	local t = {}

	-- Ignore original text.
	if #lines > 3 then
		t.original = table.remove(lines, 1)
	end

	-- Check number of lines.
	if #lines > 3 then
		error "too many lines"
	end

	-- Align segmented text and gloss.
	local segments = split_segments(lines[1])
	local gloss = split_segments(lines[2])
	if not is_aligned(segments, gloss) then
		error "misaligned gloss"
	end

	t.segments = segments
	t.gloss = gloss
	t.translation = lines[3]
	return t
end

return {parse = parse}
