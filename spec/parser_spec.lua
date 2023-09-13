local parser = require "igt.parser"

local contains = require("igt.strings").contains

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
