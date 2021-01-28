local dap = require('dap')
dap.adapters.cpp = {
  type = 'executable',
  attach = {
    pidProperty = "pid",
    pidSelect = "ask"
  },
  command = 'lldb-vscode',
  sourceLanguages = {"rust"},
  env = {
    LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
  },
  name = "lldb"
}
vim.g.dap_virtual_text = true

-- nnoremap <silent> <leader>xx :lua require'dap'.repl.toggle()<CR>
-- nnoremap <silent> <leader>x<Space> :lua require'dap'.continue()<CR>
-- nnoremap <silent> <leader>xs :lua require'dap'.step_over()<CR>
-- nnoremap <silent> <leader>xi :lua require'dap'.step_into()<CR>
-- nnoremap <silent> <leader>xo :lua require'dap'.step_out()<CR>
-- nnoremap <silent> <leader>xb :lua require'dap'.toggle_breakpoint()<CR>
