local igt = require "igt"

local contains = require("igt.strings").contains

describe("compile", function()
  it("should have pre-defined glossing abbreviations", function()
    local html = igt.compile [[
      Elefanten sind Tiere.
      elefant-en sind tier-e
      elephant-PL be.PRS;PL animal-PL
      "Elephants are animals."
    ]]
    assert.is_true(contains(html, "plural"))
    assert.is_true(contains(html, "present"))

    -- Tests if the semicolon gets tokenized.
    assert.is_true(contains(html, "</span>;<span"))
  end)
end)
