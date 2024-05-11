return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-lua/plenary.nvim",
			"nvim-lua/popup.nvim",
			"crispgm/telescope-heading.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
		},
		config = function()
			local actions = require("telescope.actions")
			local telescope = require("telescope")

			telescope.setup({
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
				defaults = {
					mappings = {
						n = {
							["<esc>"] = actions.close,
							["<C-b>"] = actions.results_scrolling_up,
							["<C-f>"] = actions.results_scrolling_down,
						},
						i = {
							["<esc>"] = actions.close,
							["<C-b>"] = actions.results_scrolling_up,
							["<C-f>"] = actions.results_scrolling_down,
						},
					},
					prompt_prefix = ">",
				},
			})
			telescope.load_extension("fzf")
			telescope.load_extension("heading")
			telescope.load_extension("file_browser")
			-- require('telescope').load_extension('dap')

			vim.api.nvim_set_keymap(
				"n",
				"<leader>o",
				'<cmd>lua require("other")()<CR>',
				{ noremap = true, silent = true }
			)
			vim.api.nvim_set_keymap("n", "<leader>tf", ":Telescope file_browser<CR>", { noremap = true })
			vim.keymap.set("n", "<leader>t<space>", ":Telescope resume<cr>", { noremap = true })
			vim.cmd([[
  nnoremap <Leader>r <cmd>Telescope live_grep<CR>
  nnoremap <Leader>f <cmd>Telescope git_files show_untracked=false recurse_submodules=true<CR>
  nnoremap <Leader>F <cmd>Telescope file_browser path=%:p:h<CR>
  " nnoremap <Leader>F <cmd>Telescope find_files<CR>
  nnoremap <Leader>b <cmd>Telescope buffers<CR>
  nnoremap <Leader>th <cmd>Telescope command_history<CR>
  nnoremap <Leader>tc <cmd>Telescope commands<CR>
  nnoremap <Leader>tm <cmd>Telescope marks<CR>
  nnoremap <Leader>tt <cmd>Telescope treesitter<CR>
  nnoremap <Leader>/ <cmd>Telescope current_buffer_fuzzy_find<CR>
  nnoremap <Leader>tT <cmd>Telescope current_buffer_tags<CR>
  nnoremap <Leader>q <cmd>Telescope quickfix<CR>
  nnoremap <Leader>l <cmd>Telescope loclist<CR>
  nnoremap <Leader>tH <cmd>Telescope help_tags<CR>
  nnoremap <Leader>tr <cmd>Telescope lsp_references<CR>
  nnoremap <Leader>ta <cmd>Telescope lsp_code_actions<CR>
  nnoremap <Leader>t] <cmd>Telescope lsp_code_definitions<CR>
  nnoremap <Leader>e <cmd>Telescope diagnostics bufnr=0<CR>
  nnoremap <Leader>E <cmd>Telescope diagnostics<CR>
  nnoremap <Leader>td <cmd>Telescope diagnostics bufnr=0<CR>
  nnoremap <Leader>tD <cmd>Telescope diagnostics<CR>
  nnoremap <Leader>gh <cmd>Telescope git_commits<CR>
  nnoremap <Leader>gH <cmd>Telescope git_bcommits<CR>
  nnoremap <Leader>gB <cmd>Telescope git_branches<CR>
]])
		end,
	},
}
