require("lsp")
require("treesitter")
require("dap")
require("completion")
require("telesc")
-- require("zettel")

require("iron.core").setup({
	config = {
		repl_definition = {
			python = {
				command = { "ipython" },
			},
		},
		repl_open_cmd = 'belowright 15 split',
	},
	keymaps = {
		send_motion = "<space>ic",
		visual_send = "<space>ic",
		send_file = "<space>if",
		send_line = "<space>il",
		send_mark = "<space>im",
		-- mark_motion = "<space>ic",
		-- mark_visual = "<space>ic",
		-- remove_mark = "<space>id",
		cr = "<space>i<cr>",
		interrupt = "<space>i<space>",
		exit = "<space>iq",
		clear = "<space>iC",
	},
})

require("nvim-web-devicons").setup({ default = true })

require("diffview").setup({
	diff_binaries = false,
	use_icons = true,
	file_panel = {
		win_config = {
			width = 35,
		},
	},
})

-- require("pretty-fold").setup({})
-- require("pretty-fold.preview").setup_keybinding("h")

require("specs").setup({})
require("spellsitter").setup()

require("mini.surround").setup({
	mappings = {
		add = "<leader>sa",
		delete = "<leader>sd",
		find = "<leader>sf",
		find_left = "<leader>sF",
		highlight = "<leader>sh",
		replace = "<leader>sr",
		update_n_lines = "<leader>sn",
	},
})

local catppuccin = require("catppuccin")

catppuccin.setup({
	colorscheme = "dark_catppuccin",
	transparent_background = true,
	styles = {
		comments = { "italic" },
		functions = {},
		keywords = { "bold" },
		-- strings = "NONE",
		variables = { "italic" },
	},
	integrations = {
		treesitter = true,
		native_lsp = {
			enabled = true,
			styles = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
		},
		lsp_trouble = true,
		-- lsp_saga = true,
		gitsigns = true,
		telescope = true,
		indent_blankline = {
			enabled = true,
			colored_indent_levels = true,
		},
		vim_sneak = true,
		ts_rainbow = true,
		cmp = true,
		gitgutter = false,
		which_key = false,
		dashboard = false,
		neogit = false,
		fern = false,
		barbar = false,
		bufferline = false,
		markdown = true,
		lightspeed = true,
		hop = false,
	},
})
vim.cmd([[colorscheme catppuccin]])

local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

-- These two are optional and provide syntax highlighting
-- for Neorg tables and the @document.meta tag
parser_configs.norg_meta = {
	install_info = {
		url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
		files = { "src/parser.c" },
		branch = "main",
	},
}

parser_configs.norg_table = {
	install_info = {
		url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
		files = { "src/parser.c" },
		branch = "main",
	},
}

require("neorg").setup({
	load = {
		["core.defaults"] = {},
		["core.norg.dirman"] = {
			config = {
				workspaces = {
					kb = "~/carte/kb",
					zettel = "~/carte/zettel",
					journal = "~/carte/journal",
				},
			},
		},
		["core.norg.completion"] = {
			config = { -- Note that this table is optional and doesn't need to be provided
			},
		},
		["core.norg.concealer"] = {
			config = { -- Note that this table is optional and doesn't need to be provided
			},
		},
		["core.norg.journal"] = {
			config = { -- Note that this table is optional and doesn't need to be provided
				workspace = "journal",
			},
		},
	},
})

require("mkdnflow").setup({
	filetypes = { md = true, rmd = true, markdown = true },
	create_dirs = true,
	perspective = {
		priority = "first",
		fallback = "current",
		root_tell = false,
	},
	wrap = false,
	bib = {
		default_path = nil,
		find_in_root = true,
	},
	silent = false,
	use_mappings_table = true,
	mappings = {
		MkdnNextLink = { "n", "<Tab>" },
		MkdnPrevLink = { "n", "<S-Tab>" },
		MkdnNextHeading = { "n", "<leader>]" },
		MkdnPrevHeading = { "n", "<leader>[" },
		MkdnGoBack = { "n", "<BS>" },
		MkdnGoForward = { "n", "<Del>" },
		MkdnFollowLink = { { "n", "v" }, "<CR>" },
		MkdnDestroyLink = { "n", "<M-CR>" },
		MkdnYankAnchorLink = { "n", "ya" },
		MkdnYankFileAnchorLink = { "n", "yfa" },
		MkdnIncreaseHeading = { "n", "+" },
		MkdnDecreaseHeading = { "n", "-" },
		MkdnToggleToDo = { "n", "<C-Space>" },
		MkdnNewListItem = false,
	},
	links = {
		style = "markdown",
		implicit_extension = nil,
		transform_implicit = false,
		transform_explicit = function(text)
			text = text:gsub(" ", "-")
			text = text:lower()
			text = os.date("%Y-%m-%d_") .. text
			return text
		end,
	},
	to_do = {
		symbols = { " ", "-", "X" },
		update_parents = true,
		not_started = " ",
		in_progress = "-",
		complete = "X",
		config = { -- Note that this table is optional and doesn't need to be provided
			workspace = "journal",
		},
	},
})
require("mdeval").setup({ eval_options = {} })

local other = require("other")
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<leader>o", '<cmd>lua require("other")()<CR>', opts)
