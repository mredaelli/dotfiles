function! SetupDev()
  " LSP mappings
  if exists(':LspInstallInfo')
    nnoremap <silent> <buffer> K <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <silent> <buffer> gd <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> <buffer> gD <cmd>lua vim.lsp.buf.declaration()<CR>
    nnoremap <silent> <buffer> cn <cmd>lua vim.lsp.buf.rename()<CR>
    nnoremap <silent> <buffer> gt <cmd>lua vim.lsp.buf.type_definition()<CR>
    nnoremap <silent> <buffer> gr <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <silent> <buffer> gi <cmd>lua vim.lsp.buf.implementation()<CR>
    " nnoremap <silent> <buffer> <Leader>*
    nnoremap <silent> <buffer> <Leader>s <cmd>lua vim.lsp.buf.document_symbol()<CR>
    " or <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
    nnoremap <silent> <buffer> <Leader>a <cmd>lua vim.lsp.buf.code_action()<CR>
    " nnoremap <silent> <buffer> <F8>  code-lens-action>
    nnoremap <silent> <buffer> <Leader>e  <cmd>lua vim.lsp.util.show_line_diagnostics()<CR>
    nnoremap <silent> <buffer> <F2> <cmd>lua vim.lsp.buf.formatting()<CR>
    inoremap <silent> <buffer> <C-s> <cmd>lua vim.lsp.buf.signature_help()<CR>
    nnoremap ]C <cmd>NextDiagnostic<CR>
    nnoremap [C <cmd>PrevDiagnostic<CR>

  elseif exists('g:LanguageClient_serverCommands')

    nnoremap <silent> <buffer> K <Plug>(lcn-hover)
    nnoremap <silent> <buffer> gd <Plug>(lcn-definition)
    " nnoremap <silent> <buffer> gd <Plug>(lcn-declaration) ??
    nnoremap <silent> <buffer> cn <Plug>(lcn-rename)
    nnoremap <silent> <buffer> gt <Plug>(lcn-type-definition)
    nnoremap <silent> <buffer> gr <Plug>(lcn-references)
    nnoremap <silent> <buffer> gi <Plug>(lcn-implementation)
    nnoremap <silent> <buffer> <Leader>* <Plug>(lcn-highlight)
    " nnoremap <silent> <buffer> document_symbol
    nnoremap <silent> <buffer> <Leader>s <Plug>(lcn-symbols)
    nnoremap <F1> <buffer> <Plug>(lcn-menu)
    nnoremap <silent> <buffer> <Leader>a <Plug>(lcn-code-action)
    nnoremap <silent> <buffer> <F8> <Plug>(lcn-code-lens-action)
    nnoremap <silent> <buffer> <Leader>e <Plug>(lcn-explain-error)
    nnoremap <silent> <buffer> <F2> <Plug>(lcn-format)
    " inoremap <silent> <buffer> <C-s> 

    " nnoremap <F1> <buffer> <Plug>(lcn-menu)
  endif
endfunction

