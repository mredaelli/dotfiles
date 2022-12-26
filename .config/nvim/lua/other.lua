local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values
local Path = require("plenary.path")
local os_sep = Path.path.sep
local scan = require("plenary.scandir")

local function starts_with(str, start)
	return str:sub(1, #start) == start
end

local function get_others(file)
	local path = Path:new(file):absolute()
	local parent = vim.fn.fnamemodify(path, ":p:h")
	local fn = vim.fn.fnamemodify(path, ":t:r")
	local results, prefix = {}, parent .. os_sep .. fn
	for _, f in ipairs(scan.scan_dir(parent, { add_dirs = false, depth = 1 })) do
		if starts_with(f, prefix) and f ~= path then
			table.insert(results, f)
		end
	end
	return results
end

local others_picker = function(others, opts)
	opts = opts or {}
	pickers
		.new(opts, {
			prompt_title = "others for ",
			finder = finders.new_table({
				results = others,
				entry_maker = make_entry.gen_from_file(opts),
			}),
			sorter = conf.file_sorter(opts),
			previewer = conf.file_previewer(opts),
		})
		:find()
end

local _M = function(file, opts)
	file = file or vim.api.nvim_buf_get_name(0)
	print(file)
	if file == nil or file == "" then
		print("No file selected")
		return
	end
	local others = get_others(file)
	if #others == 1 then
		print("Found one")
	else
		others_picker(others, opts)
	end
end

return _M
