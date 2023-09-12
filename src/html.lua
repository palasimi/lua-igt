-- Iterates over pairs of segments.
local function iter_word_pairs(segments, gloss)
	local start = 1
	return function()
		if start > #segments then
			return nil
		end

		-- Look for end of word.
		local i = start + 1
		while i <= #segments and segments[i] ~= " " do
			i = i + 1
		end

		-- Store word in tables.
		local a = {table.unpack(segments, start, i - 1)}
		local b = {table.unpack(gloss, start, i - 1)}

		-- Skip over spaces.
		start = i
		while start <= #segments and segments[start] == " " do
			start = start + 1
		end

		return a, b
	end
end

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

local sanitation_table = {
	["&"] = "&amp;",
	["'"] = "&#039;",
	["<"] = "&lt;",
	[">"] = "&gt;",
	['"'] = "&quot;",
}

-- Sanitizes string so it can be used as text in an HTML document.
local function sanitize(s)
	if s == nil then
		return ""
	end
	local t, _ = string.gsub(s, [=[[&<>"']]=], sanitation_table)
	return t
end

-- Returns HTML for element attributes (i.e. "id", "class", "style", etc.).
-- Example: attrs{class="foobar", style="display:flex"}
local function attrs(t)
	local result = ""
	for k, v in pairs(t) do
		result = result .. string.format([[ %s="%s"]], sanitize(k), sanitize(v))
	end
	return result
end

-- Returns an HTML element.
-- Supports "innerHTML" and "textContent".
-- Other keys are treated as attributes.
--
-- If the input table contains "innerHTML" and "textContent", "textContent" is
-- inserted first.
local function element(tag, t)
	local text_content = t.textContent
	local inner_html = t.innerHTML
	t.textContent = nil
	t.innerHTML = nil

	local html = string.format(
		[[<%s%s>%s%s</%s>]],
		tag,
		attrs(t),
		sanitize(text_content),
		inner_html or "",
		tag
		)

	t.textContent = text_content
	t.innerHTML = inner_html
	return html
end

-- Returns a div HTML element.
-- See also: element(t).
local function div(t)
	return element("div", t)
end

-- Returns an i HTML element.
-- See also: element(t).
local function i_(t)
	return element("i", t)
end

-- Returns a span HTML element.
-- See also: element(t).
local function span(t)
	return element("span", t)
end

-- Tokenizes morpheme so that category labels occur as tokens.
local function tokenize(m)
	-- Note: % escapes %]
	local pattern = "[.<>~;:\\[%]]"

	local t = {}

	local start = 0
	while start <= #m do
		local i = string.find(m, pattern, start + 1) or (#m + 1)

		-- Insert non-separator token.
		table.insert(t, string.sub(m, start, i-1))

		-- Insert separator.
		if i <= #m then
			table.insert(t, string.sub(m, i, i))
		end

		start = i + 1
	end

	return t
end

-- Creates HTML for a word (table of morphemes) in the meta language.
-- Tokens that appear in the abbreviations table get labeled.
local function create_metaword(w, abbreviations)
	local html = ""
	for _, morpheme in ipairs(w) do
		for _, token in ipairs(tokenize(morpheme)) do
			local meaning = abbreviations[token]
			if meaning == nil then
				html = html .. sanitize(token)
			else
				html = html .. span{
					textContent = token,
					class = "igt-label",
					title = meaning,
				}
			end
		end
	end
	return div{innerHTML = html}
end

-- Creates HTML for alignment of morphemes between example and gloss.
-- Both segments and gloss are tables of strings.
-- Uses a table of abbreviations to determine which tokens to label.
local function create_alignment(segments, gloss, abbreviations)
	local html = ""
	for a, b in iter_word_pairs(segments, gloss) do
		local a_html = i_{textContent = join(a)}
		local b_html = create_metaword(b, abbreviations)
		html = html .. div{innerHTML = a_html .. b_html}
	end
	return div{innerHTML = html, style = "display: flex; gap: 1em"}
end

-- Converts pre-parsed gloss to HTML.
-- Uses a table of abbreviations to determine which tokens to label.
local function create_igt(gloss, abbreviations)
	local html = ""
	if gloss.original ~= nil and gloss.original ~= "" then
		html = html .. i_{textContent = gloss.original}
	end
	html = html .. create_alignment(gloss.segments, gloss.gloss, abbreviations)
	html = html .. div{textContent = gloss.translation}
	return div{innerHTML = html, class = "igt"}
end

return {create_igt = create_igt}
