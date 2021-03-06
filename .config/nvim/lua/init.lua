require "lsp"
require "treesitter"
-- require "my-debug"
require "dap"
require "completion"
require "mysnippets"

local iron = require('iron')

iron.core.set_config {
  preferred = {
    python = "ipython",
  }
}

require('telescope').setup{
  defaults = {
    prompt_prefix = ">",
   --" layout_strategy = "vertical",
    --results_height = 12,
    set_env = { ['COLORTERM'] = 'truecolor' },
  }
}
-- require('telescope').load_extension('dap')

require'nvim-web-devicons'.setup { default = true; }

require'diffview'.setup {
  diff_binaries = false,    -- Show diffs for binaries
  file_panel = {
    width = 35,
    use_icons = true        -- Requires nvim-web-devicons
  }
}
 require("trouble").setup {}
