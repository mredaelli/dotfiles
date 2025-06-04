vim.cmd([[ set noshowmode ]])

local err = "😡"
local warn = "😱"
local info = "🙏"

vim.fn.sign_define("LspDiagnosticsSignErrpr", { text = err })
vim.fn.sign_define("LspDiagnosticsSignWarning", { text = warn })

return {
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				theme = "catppuccin",
				icons_enabled = true,
				disabled_filetypes = { "alpha", "Outline", "plugins", "CHADTree", "[No Name]", "OUTLINE", "vim-plug" },
				globalstatus = true,
			},
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(mode_name)
							return mode_name:sub(1, 1).upper
						end,
					},
				},
				lualine_b = {
					{
						"branch",
						icon = "",
						fmt = function(name)
							return name:sub(1, 10)
						end,
					},
				},
				lualine_c = {
					{ "filename", file_status = true, path = 1, shorting_target = 40 },
					"diff",
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						symbols = {
							error = err,
							warn = warn,
							info = info,
						},
					},
				},
				lualine_x = { { "fileformat", full_path = true, shorten = true }, "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			extensions = { "fzf", "fugitive", "quickfix" },
		},
	},
}
