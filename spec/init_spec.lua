local igt = require "igt"

-- Checks if string s contains t as a substring.
local function contains(s, t)
  return string.find(s, t, 1, true) ~= nil
end

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
