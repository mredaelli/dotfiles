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
			on_attach = function(bufnr)
				    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map('n', ']h', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[h', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

		map('n', '<leader>ga', gs.stage_hunk)
		map('v', '<leader>ga', function() gs.stage_hunk({vim.fn.line("."), vim.fn.line("v")}) end )
		map('n', '<leader>gr', gs.undo_stage_hunk)
		map('n', '<leader>gu', gs.reset_hunk)
		map('v', '<leader>ru', function() gs.reset_hunk({vim.fn.line("."), vim.fn.line("v")}) end)
		map('n', '<leader>gd', gs.preview_hunk)
		map('n', '<leader>gb', function() gs.blame_line(true) end)
	end
} },
}
