set noshowmode

if new_nvim

lua <<EOF

local err = '😡'
local warn = '😱'
local info = '🙏'
local hint = '🙈'

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = {
      spacing = 2,
      prefix = '😾',
    },
    signs = true,
  }
)

vim.fn.sign_define('LspDiagnosticsSignErrpr', { text = err })
vim.fn.sign_define('LspDiagnosticsSignWarning', { text = warn })


local lsp_status = require('lsp-status')
lsp_status.config {
  indicator_errors = err,
  indicator_warnings = warn,
  indicator_info = info,
  indicator_hint = hint,
  status_symbol = "",
}
lsp_status.register_progress()

require('lualine').setup{
  options = { 
      theme = 'catppuccin' 
  },
  sections = {
    lualine_a = { {'mode', fmt = function(mode_name) return mode_name:sub(1,1).upper end} },
    lualine_b = { {'branch', icon = '', fmt = function(name) return name:sub(1,10) end} },
    lualine_c = { {'filename', file_status = true}, 'diff', {'diagnostics', sources = {'nvim_lsp'}, symbols = {error = err, warn = warn, info = info} } },
    lualine_x = { {'fileformat', full_path=true, shorten=true}, 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location'  },
  },
}
EOF

endif
