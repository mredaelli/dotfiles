return {
	"antoinemadec/FixCursorHold.nvim",

	"ThePrimeagen/refactoring.nvim",

	"sheerun/vim-polyglot",

	"wellle/targets.vim",
	{"ggandor/leap.nvim", config=function()
		local leap = require("leap")
			leap.add_default_mappings()
			leap.opts.highlight_unlabeled_phase_one_targets = true
			leap.opts.case_sensitive = true
		end
	},

	"tpope/vim-unimpaired",
	"tpope/vim-eunuch",
	"mhinz/vim-sayonara",
	{ "numToStr/Comment.nvim", config = true },

	"dbeniamine/cheat.sh-vim",

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

	{ "edluffy/specs.nvim", config = true },
	"elihunter173/dirbuf.nvim",

	{ "kyazdani42/nvim-web-devicons", config = { default = true } },
	{ "lukas-reineke/indent-blankline.nvim", config = function()
			vim.g.indent_blankline_buftype_exclude = {'terminal'}
			vim.g.indent_blankline_filetype_exclude = {'help'}
			vim.g.indent_blankline_char = '▏'
			vim.g.indent_blankline_space_char = ' '
			vim.g.indent_blankline_space_char_blankline_highlight_list = {'IndentNegative', 'StatusLine'}
			vim.g.indent_blankline_show_trailing_blankline_indent = 0
			vim.g.indent_blankline_use_treesitter = 1
		end
	},
	"p00f/nvim-ts-rainbow",

	"AndrewRadev/inline_edit.vim",
	"bogado/file-line",
}
