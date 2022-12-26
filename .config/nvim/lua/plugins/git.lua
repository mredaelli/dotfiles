return {

	"tpope/vim-fugitive",
	"TimUntersberger/neogit",
	"samoshkin/vim-mergetool",
	"junegunn/gv.vim",
	"tpope/vim-git",
	{ "rhysd/git-messenger.vim", config=function() 
	vim.cmd([[
	function! s:setup_git_messenger_popup() abort
			nmap <buffer>[ o
			nmap <buffer>] O
	endfunction
	autocmd FileType gitmessengerpopup call <SID>setup_git_messenger_popup()
	]])
end
},
	"sodapopcan/vim-twiggy",
	{
		"sindrets/diffview.nvim",
		config = {
			diff_binaries = false,
			use_icons = true,
			file_panel = {
				win_config = {
					width = 35,
				},
			},
		},
	},
	{ "lewis6991/gitsigns.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config={
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
} },
}
