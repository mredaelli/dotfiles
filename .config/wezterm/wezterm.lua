local wezterm = require("wezterm")

local KEYMOD = "CTRL|SHIFT"

function set_title(title)
	return "printf '\\x1b]0;" .. title .. "\\x1b\\\\'"
end

function key(k, a, mod)
	local d = {
		mods = mod or KEYMOD,
		key = k
	}
	if type(a) == "string" then
		d["action"] = a
	else
		d["action"] = wezterm.action(a)
	end
	return d
end

local keys = {
	key("k", { ScrollByLine = -3 }),
	key("j", { ScrollByLine = 3 }),
	key("h", { ScrollToPrompt = -1 }),
	key("l", { ScrollToPrompt = 1 }),
	key("b", { ScrollByPage = -1 }),
	key("f", { ScrollByPage = 1 }),

	-- these are actually CTRL|SHIFT + ] and [
	key("}", { ActivatePaneDirection = "Next" }, "CTRL"),
	key("{", { ActivatePaneDirection = "Prev" }, "CTRL"),
	key("z", "TogglePaneZoomState"),
	key("Enter", { SplitHorizontal = { domain = "CurrentPaneDomain" } }),
	key("|", { SplitHorizontal = { domain = "CurrentPaneDomain" } }, "CTRL"),
	key("_", { SplitVertical = { domain = "CurrentPaneDomain" } }, "CTRL"),
	key("w", { CloseCurrentPane = { confirm = true } }),

	key("t", { SpawnTab = "CurrentPaneDomain" }),
	key("Tab", { ActivateTabRelative = -1 }),
	key("Tab", { ActivateTabRelative = 1 }, "CTRL"),
	key("q", { CloseCurrentTab = { confirm = true } }),
	key("PageDown", { MoveTabRelative = 1 }),
	key("PageUp", { MoveTabRelative = -1 }),
	key("n", "ShowTabNavigator"),
	key("*", "ShowLauncher", "CTRL"),

	key("+", "IncreaseFontSize", "LEADER"),
	key("_", "DecreaseFontSize", "LEADER"),

	key("r", "ReloadConfiguration"),

	key("v", "ActivateCopyMode"),
	key("s", { Search={CaseSensitiveString=""} }),
	key("y", { CopyTo = "Clipboard" }),
	key("p", { PasteFrom = "Clipboard" }),

	key("x", { Multiple = {
		{SendString="ciaoi\n"},
		{SpawnCommandInNewTab={args={"fish", "-C", set_title("src") .. "; cd ~/src"}}},
		{SpawnCommandInNewTab={args={"fish", "-C", set_title("media") .. "; cd ~/media"}}},
	}})
}

for i=1,9 do
	table.insert(keys, key(tostring(i), { ActivateTab = i }, "CTRL"))
end
for _, i in pairs({ "Left", "Right", "Up", "Down" }) do
	table.insert(keys, key(i .. "Arrow", { AdjustPaneSize = { i, 1 } }))
end

function hint(pattern, k, action)
	local act;
	if action then
		act = wezterm.action_callback(action)
	else
		act = nil
	end
	table.insert(keys, { key=k, mods="LEADER", action=wezterm.action { QuickSelectArgs={
		patterns={ pattern },
		action = act
	}}})
	table.insert(keys, { key=k, mods="LEADER|SHIFT", action=wezterm.action{ Search={Regex=pattern} } })
end

hint("(?:\\S.+\\S)", "l")
hint("(?:\\S*?/[\r\\S]+)|(?:\\S[\r\\S]*\\.[a-zA-Z0-9\r]{2,7})", "p")
local url_regex = "(?:https?://(www[.])?[-a-zA-Z0-9@:%._+~#=]{1,256}[.][a-zA-Z0-9()]{1,6}\\b[-a-zA-Z0-9()@:%_+.~#?&/=]*)"
hint(url_regex, "u")
hint(url_regex, "f", function(window, pane)
		local url = window:get_selection_text_for_pane(pane)
		wezterm.open_with(url)
	end
)

local catppuccin = {
	foreground = "#dadae8",
	background = "#1e1e29",
	cursor_bg = "#b1e3ad",
	cursor_border = "#b1e3ad",
	cursor_fg = "#1E1E28",
	selection_bg = "#332e41",
	selection_fg = "#e5b4e2",
	split = "#e5b4e2",
	ansi = { "#6e6c7e", "#e38c8f", "#b1e3ad", "#ebddaa", "#a4b9ef", "#c6aae8", "#e5b4e2", "#dadae8" },
	brights = { "#6e6c7e", "#e38c8f", "#b1e3ad", "#ebddaa", "#a4b9ef", "#c6aae8", "#e5b4e2", "#dadae8" },
	tab_bar = {
		background = "#15121c",
		active_tab = {
			bg_color = "#1e1e29",
			fg_color = "#dadae8",
			intensity = "Normal", -- "Half", "Normal" or "Bold" intensity for the
			underline = "None", -- "None", "Single" or "Double" underline for
			italic = false,
			strikethrough = false,
		},
		inactive_tab = {
			bg_color = "#1b1923",
			fg_color = "#a4b9ef",
		},
	},
}

return {
	enable_wayland = true,
	font = wezterm.font({
		family = "JetBrains Mono",
		harfbuzz_features = { "calt=1", "clig=1", "liga=1" },
		weight = "Medium",
	}),
	line_height = 1.15,
	check_for_updates = false,
	leader = { key = " ", mods = "CTRL|SHIFT", timeout_milliseconds = 1000 },
	keys = keys,
	disable_default_key_bindings = true,
	enable_kitty_graphics = true,
	tab_bar_at_bottom = true,
	hide_tab_bar_if_only_one_tab = true,
	inactive_pane_hsb = {
		saturation = 0.9,
		brightness = 0.7,
	},
	color_schemes = { ["Catppuccin"] = catppuccin },
	color_scheme = "Catppuccin",
	set_environment_variables = {
		VTE_VERSION = "6003", -- https://github.com/wez/wezterm/issues/115
	},
	window_padding = {
		left = "0",
		right = "0",
		top = "0",
		bottom = "0",
	},
}
