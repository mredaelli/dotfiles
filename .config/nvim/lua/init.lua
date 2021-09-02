require("lsp")
require("treesitter")
-- require "my-debug"
require("dap")
require("mysnippets")

local iron = require("iron")

iron.core.set_config({
	preferred = {
		python = "ipython",
	},
})

require("telescope").setup({
	defaults = {
		prompt_prefix = ">",
		--" layout_strategy = "vertical",
		--results_height = 12,
		set_env = { ["COLORTERM"] = "truecolor" },
	},
})
-- require('telescope').load_extension('dap')

require("nvim-web-devicons").setup({ default = true })

require("diffview").setup({
	diff_binaries = false, -- Show diffs for binaries
	file_panel = {
		width = 35,
		use_icons = true, -- Requires nvim-web-devicons
	},
})
require("trouble").setup({})

require('gitsigns').setup({
		keymaps = {
    ['n ]h'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
    ['n [h'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

    ['n <leader>ga'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['v <leader>ga'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>gr'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>gu'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['v <leader>ru'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>gd'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <leader>gb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
  }})

local catppuccino = require("catppuccino")

catppuccino.setup({
	colorscheme = "dark_catppuccino",
	transparency = true,
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
		lsp_trouble = true,
		lsp_saga = true,
		gitgutter = true,
		gitsigns = false,
		telescope = true,
		nvimtree = {
			enabled = true,
			show_root = false,
		},
		which_key = false,
		indent_blankline = true,
		dashboard = false,
		neogit = false,
		vim_sneak = true,
		fern = false,
		barbar = false,
		bufferline = false,
		markdown = false,
		lightspeed = false,
		ts_rainbow = true,
	},
})
catppuccino.load()
