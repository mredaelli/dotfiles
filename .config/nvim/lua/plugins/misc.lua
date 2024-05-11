return {
	{
		"folke/which-key.nvim",
		config = function()
			vim.g.timeoutlen = 400
			local which = require("which-key")
			which.setup({})
		end,
	},

	{
		"michaelb/sniprun",
		config = function()
			local lsp_status = require("sniprun")
			lsp_status.setup({
				display = { "TerminalWithCode" },
				selected_interpreters = { "Python3_fifo" },
				repl_enable = { "Python3_fifo" },
			})
			vim.api.nvim_set_keymap("v", "s", "<Plug>SnipRun", { silent = true })
			vim.api.nvim_set_keymap("n", "<leader>s", "<Plug>SnipRunOperator", { silent = true })
			vim.api.nvim_set_keymap("n", "<leader>ss", "<Plug>SnipRun", { silent = true })
		end,
	},

	"antoinemadec/FixCursorHold.nvim",

	"ThePrimeagen/refactoring.nvim",

	"sheerun/vim-polyglot",

	"wellle/targets.vim",
	{
		"ggandor/leap.nvim",
		config = function()
			local leap = require("leap")
			leap.add_default_mappings()
			leap.opts.highlight_unlabeled_phase_one_targets = true
			leap.opts.case_sensitive = true
		end,
	},

	"tpope/vim-unimpaired",
	"tpope/vim-eunuch",
	"mhinz/vim-sayonara",
	{
		"chrisgrieser/nvim-early-retirement",
		config = true,
		event = "VeryLazy",
		retirementAgeMins = 60,
	},
	{ "numToStr/Comment.nvim", config = true },

	{
		"dbeniamine/cheat.sh-vim",
		config = function()
			vim.g.CheatSheetStayInOrigBuf = 0
			vim.g.CheatSheetReaderCmd = "new"
			vim.g.CheatSheetShowCommentsByDefault = 1
			vim.g.CheatDoNotReplaceKeywordPrg = 1
			vim.g.CheatSheetDoNotMap = 1
			vim.cmd([[
				nnoremap <script> <silent> <leader>cs
										\ :call cheat#cheat("", getcurpos()[1], getcurpos()[1], 0, 0, '!')<CR>
				vnoremap <script> <silent> <leader>cs
										\ :call cheat#cheat("", -1, -1, 2, 0, '!')<CR>
			]])
		end,
	},

	"jubnzv/mdeval.nvim",
	"jakewvincent/mkdnflow.nvim",
	"mickael-menu/zk-nvim",

	{
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({
				providers = {
					"lsp",
					"treesitter",
				},
				delay = 1500,
				filetypes_denylist = {
					"dirvish",
					"fugitive",
				},
				-- modes_denylist: modes to not illuminate, this overrides modes_allowlist
				modes_denylist = {},
				-- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
				modes_allowlist = {},
				under_cursor = true,
			})
		end,
	},

	{ "edluffy/specs.nvim",    config = { show_jumps = true } },
	"elihunter173/dirbuf.nvim",

	{ "kyazdani42/nvim-web-devicons", config = { default = true } },
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			vim.g.indent_blankline_buftype_exclude = { "terminal" }
			vim.g.indent_blankline_filetype_exclude = { "help" }
			vim.g.indent_blankline_char = "▏"
			vim.g.indent_blankline_space_char = " "
			vim.g.indent_blankline_space_char_blankline_highlight_list = { "IndentNegative", "StatusLine" }
			vim.g.indent_blankline_show_trailing_blankline_indent = 0
			vim.g.indent_blankline_use_treesitter = 1
		end,
	},
	"p00f/nvim-ts-rainbow",

	"AndrewRadev/inline_edit.vim",
	"bogado/file-line",
}
