local snippets = require'snippets'
local U = require'snippets.utils'
snippets.use_suggested_mappings()
snippets.snippets = {
  -- ${=vim.fn.getreg('"')}
  python = {
    childrenode = U.match_indentation [[
        {
        "id": "$2",
        "name":"$1",
        "children": [

        ],
        }
    ]];
    spidernode = U.match_indentation [[
        {
        "id": "$2",
        "name":"$1",
        "spiders": [

        ],
        }
    ]];
    spider = U.match_indentation [[
        {"name": "$1"},
        ]];
  };
  _global = {
  };
}
