require("lsp")
require("treesitter")
require("dap")
require("completion")

local iron = require("iron")

iron.core.set_config({
	preferred = {
		python = "ipython",
	},
})

local actions = require("telescope.actions")
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<esc>"] = actions.close,
			},
		},
		prompt_prefix = ">",
	},
})
require('telescope').load_extension('fzf')
-- require('telescope').load_extension('dap')

require("nvim-web-devicons").setup({ default = true })

require("diffview").setup({
	diff_binaries = false,
	use_icons = true,
	file_panel = {
		width = 35,
	},
})
-- require("trouble").setup({})

require("gitsigns").setup({
	keymaps = {
		["n ]h"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'" },
		["n [h"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'" },

		["n <leader>ga"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
		["v <leader>ga"] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
		["n <leader>gr"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
		["n <leader>gu"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
		["v <leader>ru"] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
		["n <leader>gd"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
		["n <leader>gb"] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',

		-- Text objects
		["o ih"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
		["x ih"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
	},
})


require('pretty-fold').setup{}
require('pretty-fold.preview').setup_keybinding('h')

require('specs').setup{}
require('spellsitter').setup()

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
		markdown = false,
		lightspeed = false,
		hop=false,
	},
})
catppuccin.load()
