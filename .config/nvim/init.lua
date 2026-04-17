require("lazyp")

vim.opt.mouse = ""
vim.cmd([[colorscheme catppuccin-mocha]])
vim.cmd([[
	runtime misc.vim
	runtime mappings.vim
	runtime git.vim
	autocmd BufRead,BufNewFile *.myst set filetype=markdown
	autocmd FileType markdown setlocal spell
	autocmd FileType gitcommit setlocal spell
]])
