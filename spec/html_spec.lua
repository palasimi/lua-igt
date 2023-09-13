local html = require "igt.html"
local parser = require "igt.parser"

local contains = require("igt.strings").contains

describe("create_igt", function()
  local example = parser.parse [[
    Hola.
    hola
    hello.INJ
    "Hello."
  ]]

  describe("with empty abbreviations table", function()
    it("should not label any morpheme", function()
      local out = html.create_igt(example, {})
      assert.is_false(contains(out, "igt-label"))
    end)
  end)

  describe("with non-empty abbreviations table", function()
    it("should label morphemes that appear in the table", function()
      local abbreviations = {
        INJ = "interjection",
      }
      local out = html.create_igt(example, abbreviations)
      assert.is_true(contains(out, "igt-label"))
      assert.is_true(contains(out, "interjection"))
    end)
  end)
end)
