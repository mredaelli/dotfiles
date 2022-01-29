require("lsp")
require("treesitter")
require("dap")
require("completion")
require("telesc")

require("iron").core.set_config({
	preferred = {
		python = "ipython",
	},
})

require("nvim-web-devicons").setup({ default = true })

require("diffview").setup({
	diff_binaries = false,
	use_icons = true,
	file_panel = {
		width = 35,
	},
})
-- require("trouble").setup({})

require('pretty-fold').setup{}
require('pretty-fold.preview').setup_keybinding('h')

require('specs').setup{}
require('spellsitter').setup()

require('mini.surround').setup({
	mappings = {
    add = '<leader>sa',
    delete = '<leader>sd',
    find = '<leader>sf',
    find_left = '<leader>sF',
    highlight = '<leader>sh',
    replace = '<leader>sr',
    update_n_lines = '<leader>sn',
  }
})

local catppuccin = require("catppuccin")

catppuccin.setup({
	colorscheme = "dark_catppuccin",
	transparent_background = true,
	styles = {
		comments = "italic",
		functions = "NONE",
		keywords = "bold",
		-- strings = "NONE",
		variables = "italic",
	},
	integrations = {
		treesitter = true,
		native_lsp = {
			enabled = true,
			styles = {
				errors = "italic",
				hints = "italic",
				warnings = "italic",
				information = "italic",
			},
		},
		-- lsp_trouble = true,
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
		hop=false,
	},
})
catppuccin.load()
