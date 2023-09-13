-- Joins strings in table together; sep is inserted between each element.
-- If sep is nil, it's taken to be the empty string.
local function join(t, sep)
	sep = sep or ""
	local s = t[1] or ""
	for i = 2, #t do
		s = s .. string.format("%s%s", sep, t[i])
	end
	return s
end

-- Trims leading and trailing whitespace from string.
local function trim(s)
	local t, _ = string.gsub(s, "^%s*(.-)%s*$", "%1")
	return t
end

-- Iterates over lines in string.
local function iter_lines(s)
	return string.gmatch(trim(s), "[^\n]+")
end

-- Iterates over words in string.
local function iter_words(s)
	return string.gmatch(trim(s), "%S+")
end

-- Prefixes all lines in string by the given prefix (tab character by default).
local function indent(s, prefix)
	prefix = prefix or "\t"
	local t = {}
	for line in iter_lines(s) do
		table.insert(t, prefix .. line)
	end
	return join(t, "\n")
end

return {
	join = join,
	indent = indent,
	iter_lines = iter_lines,
	iter_words = iter_words,
	trim = trim,
}
