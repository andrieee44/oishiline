local lib = require("oishiline.modules.lib")
local M = {}

function M.init(globalArgs, moduleArgs)
	colors = globalArgs.colors
	default = globalArgs.default
	suffix = moduleArgs.suffix or ""

	local sep = {
		gui = "",
		tty = "",
	}

	local dataHl = {
		fg = colors.black,
		bg = colors.darkblue,
		ctermfg = 0,
		ctermbg = 4,
		bold = true,
	}

	local dataHlAlt = {
		fg = colors.lightgray,
		bg = colors.darkgray,
		ctermfg = 7,
		ctermbg = 8,
	}

	local args = vim.tbl_deep_extend("keep", moduleArgs, {
		start = sep,
		leftSep = sep,
		leftPad = lib.pad,
		rightPad = lib.pad,
		rightSep = sep,
		startHl = dataHl,
		startHlAlt = dataHlAlt,
		leftSepHl = dataHl,
		leftSepHlAlt = dataHlAlt,
		iconHl = dataHl,
		iconHlAlt = dataHlAlt,
		dataHl = dataHl,
		dataHlAlt = dataHlAlt,
		rightSepHl = dataHl,
		rightSepHlAlt = dataHlAlt,
	})
end

function M.run()
	local currentTab = vim.fn.tabpagenr()
	local results = {}
	local j = 1

	for i = 1, vim.fn.tabpagenr("$") do
		local basename =
			string.gsub(vim.api.nvim_buf_get_name(vim.fn.tabpagebuflist(i)[vim.fn.tabpagewinnr(i)]), ".*/", "")

		results[j] = basename == "" and "[No Name]" or basename
		j = j + 1
	end

	return table.concat(results)
end

return M
