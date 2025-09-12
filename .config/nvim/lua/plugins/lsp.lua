local on_attach = function(client, bufnr)
	local map = function(mode, key, result, noremap)
		vim.keymap.set(mode, key, result, { noremap = noremap or true, silent = true, buffer = bufnr })
	end
	local msg = "LSP " .. client.name

	if client.server_capabilities.signatureHelpProvider then
		require("lsp_signature").on_attach()
		client.signature_help_trigger_characters = { "(", ",", "=" }
	end

	map("n", "<C-e>", "<cmd>lua vim.diagnostic.open_float()<CR>")
	map("n", "<Leader>xx", "<cmd>TroubleToggle<CR>")
	if client.server_capabilities.documentHighlightProvider then
		map("n", "<Leader>h", "<cmd>lua vim.lsp.buf.document_highlight()<CR>")
		vim.cmd([[augroup LspHighlight]])
		vim.cmd([[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]])
		vim.cmd([[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]])
		vim.cmd([[augroup END]])
		msg = msg .. " high"
	end
	if client.server_capabilities.documentRangeFormattingProvider then
		map("v", "<Leader>=", "<cmd>lua vim.lsp.buf.document_range_formatting()<CR>")
		map("x", "<Leader>=", "<cmd>lua vim.lsp.buf.document_range_formatting()<CR>")
		msg = msg .. " rfmt"
	end
	if client.server_capabilities.documentSymbolProvider then
		map("n", "<Leader>s", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
		msg = msg .. " symb"
	end
	if client.server_capabilities.codeActionProvider then
		map("n", "<Leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>")
		vim.cmd([[augroup lightbulbSymbol]])
		vim.cmd([[autocmd CursorHold  <buffer> lua require'nvim-lightbulb'.update_lightbulb()]])
		vim.cmd([[augroup END]])
		msg = msg .. " action"
	end
	if client.server_capabilities.gotoDefinitionProvider then
		map("n", "<C-]>", "<cmd>lua vim.lsp.buf.definition()<CR>")
		msg = msg .. " def"
	end
	if client.server_capabilities.completionProvider then
		msg = msg .. " compl"
	end
	if client.server_capabilities.hoverProvider then
		map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
		msg = msg .. " hover"
	end
	if client.server_capabilities.referencesProvider then
		map("n", "<Leader>*", ":lua vim.lsp.buf.references()<CR>")
		msg = msg .. " refs"
	end
	if client.server_capabilities.renameProvider then
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
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

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

			local pyright_opts = {
				single_file_support = true,
				settings = {
					pyright = {
						disableLanguageServices = false,
						disableOrganizeImports = false,
						autoImportCompletion = true,
					},
					python = {
						analysis = {
							autoImportCompletions = true,
							autoSearchPaths = true,
							diagnosticMode = "openFilesOnly", -- openFilesOnly, workspace
							typeCheckingMode = "basic", -- off, basic, strict
							useLibraryCodeForTypes = false,
						},
					},
				},
				capabilities = capabilities,
				on_attach = on_attach,
			}
			lspconfig.pyright.setup(pyright_opts)
			lspconfig.markdown_oxide.setup({ on_attach = on_attach, capabilities = capabilities })
			lspconfig.denols.setup({
				capabilities = capabilities,
				-- on_attach = function(client)
				-- 	client.server_capabilities.document_formatting = false
				-- 	on_attach(client)
				-- end,
				on_attach = on_attach,
				root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
				single_file_support = false,
			})

			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				on_attach = function(client)
					client.server_capabilities.document_formatting = false
					on_attach(client)
				end,
				root_dir = lspconfig.util.root_pattern("package.json"),
				single_file_support = false,
			})

			lspconfig.angularls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				cmd = angular_cmd,
				on_new_config = function(new_config, _new_root_dir)
					new_config.cmd = angular_cmd
				end,
			})

			lspconfig.lua_ls.setup({
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
			lspconfig.statix.setup({ on_attach = on_attach, capabilities = capabilities })
			-- lspconfig.nixd.setup({ on_attach = on_attach, capabilities = capabilities })
			lspconfig.nil_ls.setup({ on_attach = on_attach, capabilities = capabilities })
			lspconfig.bashls.setup({ on_attach = on_attach, capabilities = capabilities })
			lspconfig.yamlls.setup({ on_attach = on_attach, capabilities = capabilities })
			lspconfig.eslint.setup({ on_attach = on_attach, capabilities = capabilities })
			lspconfig.jdtls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
			-- vim.lsp.enable("jdtls")
			lspconfig.beancount.setup({
				init_options = { journal_file = os.getenv("BEANCOUNT_FILE") },
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end,
		dependencies = {
			"nvim-lua/lsp_extensions.nvim",
			"kosayoda/nvim-lightbulb",
			"onsails/lspkind-nvim",
			"ray-x/lsp_signature.nvim",
			"mfussenegger/nvim-jdtls",
			{
				"stevearc/conform.nvim",
				opts = {
					formatters_by_ft = {
						lua = { "stylua" },
						python = { "ruff_organize_imports", "ruff_format" },
						rust = { "rustfmt" },
						bash = { "shfmt" },
						javascript = { "prettierd", "prettier", stop_after_first = true },
						typescript = { "prettierd", "prettier", stop_after_first = true },
						html = { "prettierd", "prettier", stop_after_first = true },
						json = { "prettierd", "prettier", stop_after_first = true },
						beancount = { "bean-format" },
						nix = { "nixfmt" },
						java = { "astyle" },
					},
					format_on_save = {
						timeout_ms = 1000,
						lsp_format = "fallback",
					},
				},
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
		},
	},
}
