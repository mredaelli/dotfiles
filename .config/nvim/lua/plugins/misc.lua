return {
	{
		"folke/which-key.nvim",
		config = function()
			vim.g.timeoutlen = 400
			local which = require("which-key")
			which.setup({})
		end,
	},

	"antoinemadec/FixCursorHold.nvim",

	{
		"ThePrimeagen/refactoring.nvim",
		config = function()
			require("refactoring").setup({})
			vim.keymap.set({ "n", "x" }, "<leader>R", function()
				require("refactoring").select_refactor()
			end)
		end,
	},

	"sheerun/vim-polyglot",

	"wellle/targets.vim",

	{
		"https://codeberg.org/andyg/leap.nvim",
		config = function()
			local leap = require("leap")
			vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
			vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
			vim.keymap.set("n", "gs", "<Plug>(leap-from-window)")
			vim.keymap.set({ "x", "o" }, "x", "<Plug>(leap-forward-till)")
			vim.keymap.set({ "x", "o" }, "X", "<Plug>(leap-backward-till)")
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

	"elihunter173/dirbuf.nvim",

	{ "kyazdani42/nvim-web-devicons", opts = { default = true } },
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
	"HiPhish/rainbow-delimiters.nvim",

	"AndrewRadev/inline_edit.vim",
	"bogado/file-line",
}
