local modes = require "modes"
local vtabs = require "vertical_tabs"
local select = require "select"

select.label_maker = function ()
  local chars = interleave("qwertasdfgzxcvb", "yuiophjklnm")
    return trim(sort(reverse(chars)))
end
modes.add_binds("normal", {
    { "y", "Copy selected text.", function ()
        luakit.selection.clipboard = luakit.selection.primary
    end},
})
modes.add_binds("normal", {
    { "Y", "Copy url.", function (w)
    local uri = string.gsub(w.view.uri or "", " ", "%%20")
                luakit.selection.primary = uri
                w:notify("Yanked uri: " .. uri)
    end},
})
