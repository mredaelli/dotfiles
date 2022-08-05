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
-- require('telescope').load_extension('dap')

vim.cmd([[
  command! -nargs=1 Rg call luaeval('require("fzf-commands").rg(_A)', <f-args>)
  " nnoremap <Leader>r :<c-u>Rg<space>
  nnoremap <Leader>r <cmd>Telescope live_grep<CR>

  nnoremap <Leader>f <cmd>Telescope git_files show_untracked=false recurse_submodules=true<CR>
  nnoremap <Leader>F <cmd>Telescope find_files<CR>
  nnoremap <Leader>b <cmd>Telescope buffers<CR>
  nnoremap <Leader>th <cmd>Telescope command_history<CR>
  nnoremap <Leader>tc <cmd>Telescope commands<CR>
  nnoremap <Leader>tm <cmd>Telescope marks<CR>
  nnoremap <Leader>tt <cmd>Telescope treesitter<CR>
  nnoremap <Leader>ts <cmd>Telescope symbols<CR>
  nnoremap <Leader>/ <cmd>Telescope current_buffer_fuzzy_find<CR>
  nnoremap <Leader>tT <cmd>Telescope current_buffer_tags<CR>
  nnoremap <Leader>q <cmd>Telescope quickfix<CR>
  nnoremap <Leader>l <cmd>Telescope loclist<CR>
  nnoremap <Leader>tH <cmd>Telescope help_tags<CR>
  nnoremap <Leader>tr <cmd>Telescope lsp_references<CR>
  nnoremap <Leader>tr <cmd>Telescope lsp_references<CR>
  nnoremap <Leader>tS <cmd>Telescope lsp_workspace_symbols<CR>
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
