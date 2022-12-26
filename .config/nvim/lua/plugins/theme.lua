vim.cmd([[
if (has("termguicolors"))
	set termguicolors
endif

set background=dark

augroup vimrc_todo
		au!
		au Syntax * syn match MyTodo /\v<(FIXME|NOTE|TODO|OPTIMIZE):/
					\ containedin=.*Comment,vimCommentTitle
augroup END
hi def link MyTodo Todo

highlight ExtraWhitespace ctermbg=red guibg=ivory4
autocmd Syntax * syn match ExtraWhitespace /\s\+$/ containedin=ALL
]])

return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config=false
	},
}
