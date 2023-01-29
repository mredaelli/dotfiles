FormatToggle = function(value)
	vim.g[string.format("format_disabled_%s", vim.bo.filetype)] = value
end

_G.formatting = function()
	if not vim.g[string.format("format_disabled_%s", vim.bo.filetype)] then
		vim.lsp.buf.formatting_seq_sync(vim.g[string.format("format_options_%s", vim.bo.filetype)] or {}, 5000)
	end
end

local map = function(mode, key, result, noremap)
	if noremap == nil then
		noremap = true
	end
	vim.api.nvim_buf_set_keymap(0, mode, key, result, { noremap = noremap, silent = true })
end

local on_attach = function(client)
	local msg = "LSP " .. client.name
	if client.server_capabilities.document_formatting then
		msg = msg .. " fmt"
		vim.cmd([[augroup Format]])
		vim.cmd([[autocmd! * <buffer>]])
		vim.cmd([[autocmd BufWritePost <buffer> lua formatting()]])
		vim.cmd([[augroup END]])
	end

	if client.server_capabilities.signature_help then
		require("lsp_signature").on_attach()
		client.signature_help_trigger_characters = { "(", ",", "=" }
	end

	map("n", "<C-e>", "<cmd>lua vim.diagnostic.open_float()<CR>")
	map("n", "<Leader>xx", "<cmd>TroubleToggle<CR>")
	if client.server_capabilities.document_highlight then
		map("n", "<Leader>h", "<cmd>lua vim.lsp.buf.document_highlight()<CR>")
		vim.cmd([[augroup LspHighlight]])
		vim.cmd([[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]])
		vim.cmd([[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]])
		vim.cmd([[augroup END]])
		msg = msg .. " high"
	end
	if client.server_capabilities.document_range_formatting then
		map("v", "<Leader>=", "<cmd>lua vim.lsp.buf.document_range_formatting()<CR>")
		map("x", "<Leader>=", "<cmd>lua vim.lsp.buf.document_range_formatting()<CR>")
		msg = msg .. " rfmt"
	end
	if client.server_capabilities.document_symbol then
		map("n", "<Leader>s", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
		msg = msg .. " symb"
	end
	if client.server_capabilities.code_action then
		map("n", "<Leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>")
		vim.cmd([[augroup lightbulbSymbol]])
		vim.cmd([[autocmd CursorHold  <buffer> lua require'nvim-lightbulb'.update_lightbulb()]])
		vim.cmd([[augroup END]])
		msg = msg .. " action"
	end
	if client.server_capabilities.goto_definition then
		map("n", "<C-]>", "<cmd>lua vim.lsp.buf.definition()<CR>")
		msg = msg .. " def"
	end
	if client.server_capabilities.completion then
		msg = msg .. " compl"
	end
	if client.server_capabilities.hover then
		map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
		msg = msg .. " hover"
	end
	if client.server_capabilities.find_references then
		map("n", "<Leader>*", ":lua vim.lsp.buf.references()<CR>")
		msg = msg .. " refs"
	end
	if client.server_capabilities.rename then
		map("n", "<leader>cn", "<cmd>lua vim.lsp.buf.rename()<CR>")
		msg = msg .. " ren"
	end

	-- other capabilities
	-- call_hierarchy = false,
	-- declaration = false,
	-- execute_command = true,
	-- implementation = false,
	-- type_definition = false,
	-- workspace_folder_properties = {
	--   changeNotifications = true,
	--   supported = true
	-- },
	-- workspace_symbol = false
	map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev({ severity= 'ERROR' })<CR>")
	map("n", "]d", "<cmd>lua vim.diagnostic.goto_next({ severity= 'ERROR' })<CR>")
	map("n", "[D", "<cmd>lua vim.diagnostic.goto_prev({ severity= 'WARNING' })<CR>")
	map("n", "]D", "<cmd>lua vim.diagnostic.goto_next({ severity= 'WARNING' })<CR>")

	print(msg)
end

local angular_cmd = {
	"ngserver",
	"--stdio",
	"--tsProbeLocations",
	".",
	"--ngProbeLocations",
	".",
}
local function get_lua_runtime()
	local result = {}
	for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
		local lua_path = path .. "/lua/"
		if vim.fn.isdirectory(lua_path) then
			result[lua_path] = true
		end
	end
	result[vim.fn.expand("$VIMRUNTIME/lua")] = true
	result[vim.fn.expand("~/build/neovim/src/nvim/lua")] = true

	return result
end

return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			require("lsp_extensions").inlay_hints({
				highlight = "Comment",
				prefix = " > ",
				aligned = false,
				only_current_line = false,
				enabled = { "TypeHint", "ChainingHint", "ParameterHint" },
			})
			vim.lsp.handlers["textDocument/formatting"] = function(err, _, result, _, bufnr)
				if err ~= nil or result == nil then
					return
				end
				if not vim.api.nvim_buf_get_option(bufnr, "modified") then
					local view = vim.fn.winsaveview()
					vim.lsp.util.apply_text_edits(result, bufnr)
					vim.fn.winrestview(view)
					if bufnr == vim.api.nvim_get_current_buf() then
						vim.cmd([[noautocmd :update]])
						vim.cmd([[GitGutter]])
					end
				end
			end

			vim.lsp.handlers["textDocument/publishDiagnostics"] = function(...)
				vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
					underline = true,
					update_in_insert = false,
					float = { border = "single" },
					virtual_text = {
						spacing = 2,
						prefix = "😾",
					},
					signs = true,
				})(...)
				-- pcall(vim.lsp.diagnostic.set_loclist, {open_loclist = false})
			end
			vim.cmd([[command! FormatDisable lua FormatToggle(true)]])
			vim.cmd([[command! FormatEnable lua FormatToggle(false)]])

			lspconfig.pyright.setup({ on_attach = on_attach, capabilities = capabilities })
			lspconfig.marksman.setup({})
			lspconfig.tsserver.setup({
				capabilities = capabilities,
				on_attach = function(client)
					client.server_capabilities.document_formatting = false
					on_attach(client)
				end,
			})

			lspconfig.angularls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				cmd = angular_cmd,
				on_new_config = function(new_config, _new_root_dir)
					new_config.cmd = angular_cmd
				end,
			})

			lspconfig.sumneko_lua.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				cmd = { "lua-language-server" },
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						completion = {
							keywordSnippet = "Disable",
						},
						diagnostics = {
							enable = true,
							globals = {
								-- Neovim
								"vim",
								-- Busted
								"describe",
								"it",
								"before_each",
								"after_each",
								"teardown",
								"pending",
							},
							workspace = {
								library = get_lua_runtime(),
								maxPreload = 1000,
								preloadFileSize = 1000,
							},
						},
					},
				},
			})

			lspconfig.vimls.setup({ on_attach = on_attach, capabilities = capabilities })

			lspconfig.rust_analyzer.setup({ on_attach = on_attach, capabilities = capabilities })

			lspconfig.bashls.setup({ on_attach = on_attach, capabilities = capabilities })
		end,
		dependencies = {
			"nvim-lua/lsp_extensions.nvim",
			"kosayoda/nvim-lightbulb",
			"onsails/lspkind-nvim",
			"ray-x/lsp_signature.nvim",
			{
				"nvim-lua/lsp-status.nvim",
				config = function()
					local lsp_status = require("lsp-status")
					local err = "😡"
					local warn = "😱"
					local info = "🙏"
					local hint = "🙈"
					lsp_status.config({
						indicator_errors = err,
						indicator_warnings = warn,
						indicator_info = info,
						indicator_hint = hint,
						status_symbol = "",
					})
					lsp_status.register_progress()
				end,
			},
			"folke/trouble.nvim",
			{
				"scalameta/nvim-metals",
				config = function()
					vim.cmd([[augroup lsp]])
					vim.cmd([[autocmd!]])
					vim.cmd([[autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc]])
					vim.cmd([[autocmd FileType scala,sbt lua require("metals").initialize_or_attach(MetalsConfig)]])
					vim.cmd([[augroup end]])

					MetalsConfig = require("metals").bare_config()
					MetalsConfig.settings = {
						showImplicitArguments = true,
						useGlobalExecutable = true,
					}
					-- MetalsConfig.capabilities = capabilities
					MetalsConfig.on_attach = on_attach
				end,
			},
			{
				"jose-elias-alvarez/null-ls.nvim",
				config = function()
					local null_ls = require("null-ls")
					local h = require("null-ls.helpers")
					local methods = require("null-ls.methods")

					local FORMATTING = methods.internal.FORMATTING

					local pandoc = h.make_builtin({
						name = "pandoc",
						method = FORMATTING,
						filetypes = { "markdown" },
						generator_opts = {
							command = "mkdownfmt",
							to_stdin = true,
						},
						factory = h.formatter_factory,
					})
					null_ls.setup({
						on_attach = on_attach,
						sources = {
							null_ls.builtins.formatting.stylua,
							null_ls.builtins.formatting.nixpkgs_fmt,
							null_ls.builtins.diagnostics.statix,
							null_ls.builtins.diagnostics.shellcheck,
							null_ls.builtins.formatting.shfmt,
							null_ls.builtins.diagnostics.flake8,
							null_ls.builtins.formatting.black,
							null_ls.builtins.formatting.isort,
							null_ls.builtins.diagnostics.yamllint,
							null_ls.builtins.formatting.prettier.with({
								filetypes = { "html", "json", "yaml", "javascript", "typescript" },
							}),
							null_ls.builtins.formatting.eslint,
							null_ls.builtins.formatting.elm_format,
							null_ls.builtins.code_actions.refactoring,
							null_ls.builtins.diagnostics.alex,
							null_ls.builtins.diagnostics.proselint,
							pandoc,
							-- null_ls.builtins.completion.spell,
							-- null_ls.builtins.formatting.autopep8,
							-- null_ls.builtins.formatting.yapf,
							-- null_ls.builtins.formatting.scalafmt,
							-- null_ls.builtins.formatting.rustfmt,
							-- null_ls.builtins.formatting.cbfmt
						},
						update_in_insert = false,
						debounce = 2000,
					})
				end,
			},
		},
	},
}
