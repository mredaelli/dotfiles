require("lsp")
require("treesitter")
-- require "my-debug"
require("dap")

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

-- local check_back_space = function()
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col == 0 or vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') ~= nil
-- end

local cmp = require("cmp")
cmp.setup({
	sources = {
		{ name = "nvim_lsp" },
		{ name = "cmp-buffer " },
		{ name = "cmp-path " },
		--	 { name = 'treesitter' },
	},
	mapping = {
		["<Tab>"] = function(fallback)
			if vim.fn.pumvisible() == 1 then
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-n>", true, true, true), "n", true)
			elseif check_back_space() then
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true)
			elseif vim.fn["vsnip#available"]() == 1 then
				vim.api.nvim_feedkeys(
					vim.api.nvim_replace_termcodes("<Plug>(vsnip-expand-or-jump)", true, true, true),
					"",
					true
				)
			else
				fallback()
			end
		end,
	},
	formatting = {
		format = function(entry, vim_item)
			-- fancy icons and a name of kind
			vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind

			-- set a name for each source
			vim_item.menu = ({
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				path = "[Path]",
			})[entry.source.name]
			return vim_item
		end,
	},
})

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
		-- indent_blankline = true,
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
