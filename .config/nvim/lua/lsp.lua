-- mostly copied from https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/lsp.lua
local lspconfig = require "lspconfig"

local map = function(mode, key, result, noremap)
    if noremap == nil then
        noremap = true
    end
    vim.api.nvim_buf_set_keymap(0, mode, key, result, {noremap = noremap, silent = true})
end

-- vim.cmd[[highlight LspReference guifg=NONE guibg=#665c54 guisp=NONE gui=NONE cterm=NONE ctermfg=NONE ctermbg=59]]
-- vim.cmd[[highlight! link LspReferenceText LspReference]]
-- vim.cmd[[highlight! link LspReferenceRead LspReference]]
-- vim.cmd[[highlight! link LspReferenceWrite LspReference]]

vim.lsp.handlers["textDocument/formatting"] = function(err, _, result, _, bufnr)
    if err ~= nil or result == nil then
        return
    end
    if not vim.api.nvim_buf_get_option(bufnr, "modified") then
        local view = vim.fn.winsaveview()
        vim.lsp.util.apply_text_edits(result, bufnr)
        vim.fn.winrestview(view)
        if bufnr == vim.api.nvim_get_current_buf() then
            vim.cmd [[noautocmd :update]]
            vim.cmd [[GitGutter]]
        end
    end
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = function(...)
    vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
            underline = true,
            update_in_insert = false,
            signs = true,
            virtual_text = {
                spacing = 2,
                prefix = '💔',
            },
        }
        )(...)
    pcall(vim.lsp.diagnostic.set_loclist, {open_loclist = false})
end

-- local format_options_prettier = {
    --     tabWidth = 4,
    --     singleQuote = true,
    --     trailingComma = "all",
    --     configPrecedence = "prefer-file"
-- }
-- vim.g.format_options_typescript = format_options_prettier
-- vim.g.format_options_javascript = format_options_prettier
-- vim.g.format_options_json = format_options_prettier
-- vim.g.format_options_css = format_options_prettier
-- vim.g.format_options_scss = format_options_prettier
-- vim.g.format_options_html = format_options_prettier
-- vim.g.format_options_yaml = format_options_prettier
-- vim.g.format_options_markdown = format_options_prettier

FormatToggle = function(value)
    vim.g[string.format("format_disabled_%s", vim.bo.filetype)] = value
end
vim.cmd [[command! FormatDisable lua FormatToggle(true)]]
vim.cmd [[command! FormatEnable lua FormatToggle(false)]]

_G.formatting = function()
    if not vim.g[string.format("format_disabled_%s", vim.bo.filetype)] then
        vim.lsp.buf.formatting_seq_sync(vim.g[string.format("format_options_%s", vim.bo.filetype)] or {}, 1000)
    end
end

local on_attach = function(client)
    local msg = "LSP " .. client.name
    if client.resolved_capabilities.document_formatting then
        msg = msg .. " fmt"
        vim.cmd [[augroup Format]]
        vim.cmd [[autocmd! * <buffer>]]
        vim.cmd [[autocmd BufWritePost <buffer> lua formatting()]]
        vim.cmd [[augroup END]]
    end

    -- other capabilities
    -- call_hierarchy = false,
    -- declaration = false,
    -- execute_command = true,
    -- implementation = false,
    if client.resolved_capabilities.signature_help then
            require "lsp_signature".on_attach() 
        client.signature_help_trigger_characters = { "(", ",", "=" }
    end
    -- type_definition = false,
    -- workspace_folder_properties = {
        --   changeNotifications = true,
        --   supported = true
    -- },
    -- workspace_symbol = false
    map("n", "<Leader>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
    map("n", "<Leader>E", "<cmd>TroubleToggle<CR>")
    if client.resolved_capabilities.document_highlight then
        map("n", "<Leader>h", "<cmd>lua vim.lsp.buf.document_highlight()<CR>")
        vim.cmd [[augroup LspHighlight]]
        vim.cmd [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
        vim.cmd [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
        vim.cmd [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
        vim.cmd [[augroup END]]
        msg = msg .. " high"
    end
    if client.resolved_capabilities.document_range_formatting then
        map("v", "<Leader>=", "<cmd>lua vim.lsp.buf.document_range_formatting()<CR>")
        map("x", "<Leader>=", "<cmd>lua vim.lsp.buf.document_range_formatting()<CR>")
        msg = msg .. " rfmt"
    end
    if client.resolved_capabilities.document_symbol then
        map("n", "<Leader>s", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
        msg = msg .. " symb"
    end
    if client.resolved_capabilities.code_action then
        map("n", "<Leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>")
        vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
        msg = msg .. " action"
    end
    if client.resolved_capabilities.goto_definition then
        map("n", "<C-]>", "<cmd>lua vim.lsp.buf.definition()<CR>")
        msg = msg .. " def"
    end
    if client.resolved_capabilities.completion then
        -- require "completion".on_attach(client)
        -- map("i", "<c-n>", "<Plug>(completion_trigger)", false)
        -- map("i", "<c-j>", "<Plug>(completion_next_source)", false)
        -- map("i", "<c-k>", "<Plug>(completion_prev_source)", false)
        msg = msg .. " compl"
    end
    if client.resolved_capabilities.hover then
        map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
        msg = msg .. " hover"
    end
    if client.resolved_capabilities.find_references then
        map("n", "<Leader>*", ":lua vim.lsp.buf.references()<CR>")
        msg = msg .. " refs"
    end
    if client.resolved_capabilities.rename then
        map("n", "<leader>cn", "<cmd>lua vim.lsp.buf.rename()<CR>")
        msg = msg .. " ren"
    end

    print(msg)
end

lspconfig.pyright.setup {on_attach = on_attach}
lspconfig.angularls.setup {on_attach = on_attach}
lspconfig.tsserver.setup {
    on_attach = function(client)
        client.resolved_capabilities.document_formatting = false
        on_attach(client)
    end
}

local project_library_path = "."
local cmd = {"ngserver", "--stdio", "--tsProbeLocations", project_library_path , "--ngProbeLocations", project_library_path}

require'lspconfig'.angularls.setup{
  cmd = cmd,
  on_new_config = function(new_config,new_root_dir)
    new_config.cmd = cmd
  end,
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
lspconfig.sumneko_lua.setup {
    on_attach = on_attach,
    cmd = {"lua-language-server"},
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT"
            },
            completion = {
                keywordSnippet = "Disable"
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
                    "pending"
                },
                workspace = {
                    library = get_lua_runtime(),
                    maxPreload = 1000,
                    preloadFileSize = 1000
                }
            }
        }
    }
}

lspconfig.vimls.setup {on_attach = on_attach}
lspconfig.rust_analyzer.setup{ on_attach = on_attach }
lspconfig.bashls.setup {on_attach = on_attach}
lspconfig.efm.setup {
    on_attach = on_attach,
    init_options = {documentFormatting = true},
}
lspconfig.metals.setup{}

-- lspconfig.jsonls.setup {
    --     on_attach = on_attach,
    --     cmd = {"json-languageserver", "--stdio"}
-- }
-- lspconfig.yamlls.setup {on_attach = on_attach}
-- lspconfig.sqlls.setup {on_attach = on_attach}
-- lspconfig.cssls.setup {on_attach = on_attach}
-- lspconfig.html.setup {on_attach = on_attach}
-- lspconfig.dockerls.setup {on_attach = on_attach}
-- lspconfig.terraformls.setup {
    --     on_attach = on_attach,
    --     cmd = {"terraform-ls", "serve"},
    --     filetypes = {"tf"}
-- }
-- lspconfig.clangd.setup {on_attach = on_attach}

require'lsp_extensions'.inlay_hints{
    highlight = "Comment",
    prefix = " > ",
    aligned = false,
    only_current_line = false,
    enabled = { "TypeHint", "ChainingHint", "ParameterHint" }
}
