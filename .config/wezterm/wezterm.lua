local wezterm = require("wezterm")

function key(k, a)
	local d = {}
	d["mods"] = "CTRL|SHIFT"
	d["key"] = k
	if type(a) == "string" then
		d["action"] = a
	else
		d["action"] = wezterm.action(a)
	end
	return d
end

local keys = {
	-- key("UpArrow", { ScrollToPrompt = -1 }),
	-- key("DownArrow", { ScrollToPrompt = -1 }),
	key("UpArrow", { ScrollByLine = -1 }),
	key("DownArrow", { ScrollByLine = 10 }),
	key("PageUp", { ScrollByPage = -1 }),
	key("PageDown", { ScrollByPage = 1 }),
	-- key("", "SpawnWindow"),
	key("j", { ActivatePaneDirection = "Down" }),
	key("k", { ActivatePaneDirection = "Up" }),
	key("h", { ActivatePaneDirection = "Left" }),
	key("l", { ActivatePaneDirection = "Right" }),
	key("w", { CloseCurrentPane = { confirm = true } }),
	key("Enter", { SplitHorizontal = { domain = "CurrentPaneDomain" } }),
	key("z", "TogglePaneZoomState"),
	-- map ctrl+shift+b        move_window_backward
	key("t", { SpawnTab = "CurrentPaneDomain" }),
	key("{", { ActivateTabRelative = -1 }),
	key("}", { ActivateTabRelative = 1 }),
	key("+", "IncreaseFontSize"),
	key("_", "DecreaseFontSize"),
-- map ctrl+shift+backspace restore_font_size
}

-- shift+number doesn't seem to work
-- for i = 1, 8 do
-- 	table.insert(keys, key(tostring(i), { ActivateTab = i - 1 }))
-- end

-- enabled_layouts tall:bias=70,grid,fat,horizontal,vertical,stack
-- map ctrl+shift+l>t goto_layout tall:bias=70
-- # stack, or only 1, or zoom
-- map ctrl+shift+l>s goto_layout stack
-- map ctrl+shift+l>1 goto_layout stack
-- # and back
-- map ctrl+shift+l>\ last_used_layout
-- map ctrl+shift+\ last_used_layout
-- map ctrl+shift+l>f goto_layout fat
-- map ctrl+shift+l>g goto_layout grid
-- map ctrl+shift+l>h goto_layout horizontal
-- map ctrl+shift+l>v goto_layout vertical
-- map ctrl+shift+l>] next_layout

-- # map ctrl+alt+a send_text normal Word\x1b[H

-- # also hash, regex
-- # - = paste, @= copy to clipboard
-- map ctrl+shift+y>u kitten hints --type url --program firefox
-- map ctrl+shift+y>shift+u kitten hints --type url --program @
-- map ctrl+shift+y>p kitten hints --type path --program -
-- map ctrl+shift+y>shift+p kitten hints --type path --program @
-- map ctrl+shift+y>l kitten hints --type line --program -
-- map ctrl+shift+y>shift+l kitten hints --type line --program @
-- map ctrl+shift+y>w kitten hints --type word --program -
-- map ctrl+shift+y>shift+w kitten hints --type word --program @
-- map ctrl+shift+y>h kitten hints --type hash --program -
-- map ctrl+shift+y>shift+h kitten hints --type hash --program @

-- # scrollback
-- map ctrl+shift+s>l pipe @ansi overlay less +G -R
-- map ctrl+shift+s>v pipe @text window nvim -
-- map ctrl+shift+s>shift+v pipe @text tab nvim -

return {
	enable_wayland = true,
	font = wezterm.font("JetBrains Mono", { weight = "Medium" }),
	line_height = 1.15,
	check_for_updates = false,
	keys = keys,
	disable_default_key_bindings = true,
}
