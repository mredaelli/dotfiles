local snippets = require'snippets'
local U = require'snippets.utils'

snippets.use_suggested_mappings()

function for_each(txt, sep_in, sep_out, f)
  local res = ''

  for v in txt:gmatch('([^'..sep_in..']+)') do
    if not (res == '') then res = res .. sep_out end
    res = res .. f(v:match( "^%s*(.-)%s*$" ))
  end
  return res
end


function mkspider(s) return '{"name": "'..s..'"}' end

snippets.snippets = {
  python = {
    childrennode = U.match_indentation [[
{
  "id": "$2",
  "name": "$1",
  "children": [
    $0
  ],
}]];
    spidernode = U.match_indentation [[
{
  "id": "$2",
  "name": "$1",
  "spiders": [
    $0
  ],
}]];
    spider = U.match_indentation[[{"name": "${1:=vim.fn.getreg('"')}"}]];
    ["spider,"] = U.match_indentation[[${1=vim.fn.getreg('"')|for_each(S.v, ',', '\n', mkspider )}]];
    spidern = U.match_indentation[[${1=vim.fn.getreg('"')|for_each(S.v, '\n', '\n', mkspider )}]];
  };
  _global = {
  };
}
