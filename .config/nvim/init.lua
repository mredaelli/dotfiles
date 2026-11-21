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
vim.keymap.set("n", "<Leader>w", function()
	vim.cmd("normal! ciw")
	local word = vim.fn.getreg('"')
	vim.api.nvim_put({ "{}`" .. word .. "`" }, "c", false, false)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("F{a", true, false, true), "n", false)
end)

vim.keymap.set("v", "<Leader>w", function()
	vim.cmd("normal! c")
	local sel = vim.fn.getreg('"')
	vim.api.nvim_put({ "{}`" .. sel .. "`" }, "c", false, false)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("F{a", true, false, true), "n", false)
end)
