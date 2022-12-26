local wezterm = require("wezterm")

local KEYMOD = "CTRL|SHIFT"

local function key(k, a, mod)
	local d = {
		mods = mod or KEYMOD,
		key = k,
	}
	if type(a) == "string" then
		d["action"] = a
	else
		d["action"] = wezterm.action(a)
	end
	return d
end

local shell = "fish"
local function workspace(name, path)
	local cwd = path or ("/home/turing/src/" .. name)
	local action = {
		cwd = cwd,
		args = {
			shell,
			"-c",
			"wezterm cli split-pane --horizontal " .. shell .. "; direnv exec . nvim; exec " .. shell,
		},
	}
	return { name = name, spawn = action }
end

local hints = {}
local function hint(pattern, k, action)
	local act
	if action then
		act = wezterm.action_callback(action)
	else
		act = nil
	end
	table.insert(hints, {
		key = k,
		mods = "",
		action = wezterm.action({ QuickSelectArgs = { patterns = { pattern }, action = act } }),
	})
	table.insert(hints, { key = k, mods = "SHIFT", action = wezterm.action({ Search = { Regex = pattern } }) })
end

hint("(?:\\S.+\\S)", "l")
hint("(?:\\S*?/[\r\\S]+)|(?:\\S[\r\\S]*\\.[a-zA-Z0-9\r]{2,7})", "p")
local url_regex =
	"(?:https?://(www[.])?[-a-zA-Z0-9@:%._+~#=]{1,256}[.][a-zA-Z0-9()]{1,6}\\b[-a-zA-Z0-9()@:%_+.~#?&/=]*)"
hint(url_regex, "u")
hint(url_regex, "f", function(window, pane)
	local url = window:get_selection_text_for_pane(pane)
	wezterm.open_with(url)
end)
local key_tables = {
	hints = hints,
	resize = {
		{ key = "h", action = { AdjustPaneSize = { "Left", 1 } } },
		{ key = "l", action = { AdjustPaneSize = { "Right", 1 } } },
		{ key = "k", action = { AdjustPaneSize = { "Up", 1 } } },
		{ key = "j", action = { AdjustPaneSize = { "Down", 1 } } },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "=", action = "IncreaseFontSize" },
		{ key = "-", action = "DecreaseFontSize" },
	},
}
local keys = {
	key("s", { SwitchToWorkspace = workspace("lari/crawlers/spiders") }, "CTRL|SUPER"),
	key("c", { SwitchToWorkspace = workspace("lari/crawlers/crawlers") }, "CTRL|SUPER"),
	key("f", { SwitchToWorkspace = workspace("lari/platform/frontend") }, "CTRL|SUPER"),
	key("b", { SwitchToWorkspace = workspace("lari/platform/backend") }, "CTRL|SUPER"),
	key("l", { SwitchToWorkspace = workspace("lari/crawlers/laricli") }, "CTRL|SUPER"),
	key("a", { SwitchToWorkspace = workspace("lari/systems/server-admin") }, "CTRL|SUPER"),
	key("A", { SwitchToWorkspace = workspace("lari/systems/admin") }, "CTRL|SUPER"),
	key("e", { SwitchToWorkspace = workspace("lari/systems/ssh_everywhere") }, "CTRL|SUPER"),
	key("q", { SwitchToWorkspace = workspace("lari/platform/automated-qa") }, "CTRL|SUPER"),
	key("d", { SwitchToWorkspace = workspace("lari/platform/laridiff") }, "CTRL|SUPER"),
	key("0", { SwitchToWorkspace = { name = "default" } }),
	key(">", { SwitchWorkspaceRelative = 1 }),
	key("<", { SwitchWorkspaceRelative = -1 }),

	key("UpArrow", { ScrollByLine = -3 }),
	key("DownArrow", { ScrollByLine = 3 }),
	key("b", { ScrollByPage = -1 }),
	key("f", { ScrollByPage = 1 }),

	key("r", { ActivateKeyTable = { name = "resize", one_shot = false } }),

	key("]", { ActivatePaneDirection = "Next" }),
	key("[", { ActivatePaneDirection = "Prev" }),
	key("h", { ActivatePaneDirection = "Left" }),
	key("j", { ActivatePaneDirection = "Down" }),
	key("k", { ActivatePaneDirection = "Up" }),
	key("l", { ActivatePaneDirection = "Right" }),
	key("Enter", { SplitHorizontal = { domain = "CurrentPaneDomain" } }),
	key("\\", { SplitHorizontal = { domain = "CurrentPaneDomain" } }),
	key("_", { SplitVertical = { domain = "CurrentPaneDomain" } }),
	key("z", "TogglePaneZoomState"),
	key("w", { CloseCurrentPane = { confirm = true } }),

	key("t", { SpawnTab = "CurrentPaneDomain" }),
	key("Tab", { ActivateTabRelative = -1 }),
	key("Tab", { ActivateTabRelative = 1 }, "CTRL"),
	key("q", { CloseCurrentTab = { confirm = true } }),
	key("PageDown", { MoveTabRelative = 1 }),
	key("PageUp", { MoveTabRelative = -1 }),
	key("n", "ShowTabNavigator"),
	key("*", "ShowLauncher"),
	--key="9", mods="ALT", action=wezterm.action{ShowLauncherArgs={flags="FUZZY|WORKSPACES"}}},

	key("u", { ActivateKeyTable = { name = "hints" } }),
	key("v", "ActivateCopyMode"),
	key("s", { Search = { CaseSensitiveString = "" } }),
	key("y", { CopyTo = "Clipboard" }),
	key("p", { PasteFrom = "Clipboard" }),
}

for i = 1, 9 do
	table.insert(keys, key(tostring(i), { ActivateTab = i }, "CTRL"))
end

local catppuccin = {
	foreground = "#dadae8",
	background = "#1e1e29",
	cursor_bg = "#b1e3ad",
	cursor_border = "#b1e3ad",
	cursor_fg = "#1E1E28",
	compose_cursor = "orange", -- ?
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

wezterm.on("update-right-status", function(window, pane)
	local status = window:active_workspace()
	if window:leader_is_active() then
		status = status .. ", LEADER"
	end
	local name = window:active_key_table()
	if name then
		status = "TABLE: " .. name
	end
	local compose = window:composition_status()
	if compose then
		status = status .. ", COMPOSING: " .. compose
	end
	window:set_right_status(status)
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local has_unseen_output = false
	for _, pane in ipairs(tab.panes) do
		if pane.has_unseen_output then
			has_unseen_output = true
			break
		end
	end
	if has_unseen_output then
		return {
			{ Background = { Color = "maroon" } },
			{ Text = " *" .. tab.active_pane.title .. " " },
		}
	end
end)

return {
	unix_domains = {
		{
			name = "unix",
		},
	},
	-- default_gui_startup_args = { "connect", "unix" },
	enable_wayland = true,
	font = wezterm.font({
		family = "JetBrains Mono",
		harfbuzz_features = { "calt=1", "clig=1", "liga=1" },
		weight = "Medium",
	}),
	line_height = 1.15,
	check_for_updates = false,
	keys = keys,
	key_tables = key_tables,
	disable_default_key_bindings = true,
	enable_kitty_graphics = true,
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,
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
	warn_about_missing_glyphs=false,
}
