require("lazyp")

vim.g.catppuccin_flavour = "macchiato"
vim.cmd([[colorscheme catppuccin]])
vim.cmd([[
	runtime misc.vim
	runtime mappings.vim
	runtime git.vim
]])
