require("lazyp")

vim.opt.mouse = ""
vim.g.catppuccin_flavour = "macchiato"
vim.cmd([[colorscheme catppuccin]])
vim.cmd([[
	runtime misc.vim
	runtime mappings.vim
	runtime git.vim
	autocmd BufRead,BufNewFile *.myst set filetype=markdown
	autocmd FileType markdown setlocal spell
	autocmd FileType gitcommit setlocal spell
]])
