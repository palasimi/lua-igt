local strings = require "igt.strings"

describe("contains", function()
  describe("if first arg contains second arg", function()
    it("should return true", function()
      assert.is_true(strings.contains("ab", "a"))
      assert.is_true(strings.contains("ab", "b"))
      assert.is_true(strings.contains("ab", "ab"))
    end)
  end)

  describe("if first arg does not contain second arg", function()
    it("should return false,", function()
      assert.is_false(strings.contains("a", "b"))
      assert.is_false(strings.contains("", "b"))
    end)
  end)
end)

describe("join", function()
  describe("with sep argument", function()
    it("should insert sep between each string", function()
      local out = strings.join({"a", "b", "c"}, "12")
      local expected = "a12b12c"
      assert.is.equal(out, expected)
    end)
  end)

  describe("without sep argument", function()
    it("should simply concatenate strings in the table", function()
      local out = strings.join {"a", "b", "c"}
      local expected = "abc"
      assert.is.equal(out, expected)
    end)
  end)
end)

describe("indent", function()
  describe("with prefix argument", function()
    it("should prefix each line by the given prefix", function()
      local out = strings.indent("a\nb\nc", ":)")
      local expected = ":)a\n:)b\n:)c"
      assert.is.equal(out, expected)
    end)
  end)

  describe("without prefix argument", function()
    it("should prefix each line with a tab character", function()
      local out = strings.indent "a\nb\nc"
      local expected = "\ta\n\tb\n\tc"
      assert.is.equal(out, expected)
    end)
  end)
end)

describe("trim", function()
  it("should remove surrounding whitespace", function()
    local out = strings.trim " \t\na b\tc\nd\n\t "
    local expected = "a b\tc\nd"
    assert.is.equal(out, expected)
  end)
end)
