return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"JoosepAlviste/nvim-ts-context-commentstring",
			"nvim-treesitter/nvim-treesitter-refactor",
			"windwp/nvim-ts-autotag",
		},
		opts = {
			ensure_installed = "all",
			highlight = {
				enable = true,
				-- additional_vim_regex_highlighting = { "markdown" },
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gnn",
					node_incremental = "grn",
					scope_incremental = "grc",
					node_decremental = "grm",
				},
			},
			indent = {
				enable = false,
			},
			autotag = {
				enable = true,
			},
			rainbow = {
				enable = true,
				extended_mode = true,
			},
			context_commentstring = {
				enable = true,
			},
			textobjects = {
				select = {
					enable = true,
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				swap = {
					enable = true,
					-- swap_next = {
					--  ["<leader>a"] = "@parameter.inner",
					-- },
				},
				move = {
					enable = true,
					-- goto_next_start = {
					--   ["]m"] = "@function.outer",
					--   ["]]"] = "@class.outer",
					-- },
				},
			},
		},
	},
}
