require "lsp"
require "treesitter"
-- require "my-debug"
require "dap"
require "mysnippets"

local iron = require('iron')

iron.core.set_config {
  preferred = {
    python = "ipython",
  }
}

