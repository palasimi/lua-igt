local parser = require "igt.parser"

-- Checks if string s contains t as a substring.
local function contains(s, t)
  return string.find(s, t, 1, true) ~= nil
end

describe("parse", function()
  describe("with too few lines", function()
    it("should raise an error", function()
      local examples = {
        "",
        "Hello, world!",
        [[
          Hello, world!
          hello world
        ]],
      }

      for _, example in ipairs(examples) do
        local ok, message = pcall(parser.parse, example)
        assert.is_false(ok)
        assert.is_true(contains(message, "missing text"))
      end
    end)
  end)

  describe("with too many lines", function()
    it("should raise an error", function()
      local example = [[
        a
        b
        c
        d
        e
      ]]

      local ok, message = pcall(parser.parse, example)
      assert.is_false(ok)
      assert.is_true(contains(message, "too many lines"))
    end)
  end)

  describe("with unquoted translation", function()
    it("should raise an error", function()
      local example = [[
        Hola.
        hello
        Hello.
      ]]

      local ok, message = pcall(parser.parse, example)
      assert.is_false(ok)
      assert.is_true(contains(message, "unquoted translation"))
    end)
  end)

  it("should not complain about single-quoted translations", function()
    parser.parse [[
      Hola.
      hello
      'Hello.'
    ]]
  end)

  it("should not complain about double-quoted translation", function()
    parser.parse [[
      Hola.
      hola
      hello
      "Hello."
    ]]
  end)

  describe("gloss alignment", function()
    describe("if glosses have an unequal number of morphemes", function()
      it("should raise an error", function()
        local examples = {
          [[
            Hola.
            hola
            hello world
            "Hello, world!"
          ]],
          [[
            Hola.
            ho-la
            hello
            "Hello, world!"
          ]]
        }

        for _, example in ipairs(examples) do
          local ok, message = pcall(parser.parse, example)
          assert.is_false(ok)
          assert.is_true(contains(message, "misaligned gloss"))
        end
      end)
    end)
  end)
end)
