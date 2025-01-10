local lib = require("oishiline.modules.lib")
local tabline, hasDevicons
local M = {}

local function activeTabline(activeTab, tab, str, hl)
	return string.format("%%#%s#%s", activeTab == tab and hl.hl or hl.alt, str)
end

function M.init(globalArgs, moduleArgs)
	local colors = globalArgs.colors
	local default = globalArgs.default
	local suffix = moduleArgs.suffix or ""
	hasDevicons = vim.opt.termguicolors._value and package.loaded["nvim-web-devicons"]

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
		start = lib.empty,
		leftPad = lib.pad,
		rightPad = lib.pad,
		iconHl = dataHl,
		iconHlAlt = dataHlAlt,
		dataHl = dataHl,
		dataHlAlt = dataHlAlt,

		leftSep = {
			gui = "",
			tty = "",
		},

		rightSep = {
			gui = "",
			tty = " ",
		},

		leftSepHl = {
			fg = default.bg,
			bg = colors.darkblue,
			ctermfg = default.ctermbg,
			ctermbg = 4,
		},

		leftSepHlAlt = {
			fg = default.bg,
			bg = colors.darkgray,
			ctermfg = default.ctermbg,
			ctermbg = 8,
		},

		rightSepHl = {
			fg = colors.darkblue,
			bg = colors.black,
			ctermfg = 4,
			ctermbg = 0,
		},

		rightSepHlAlt = {
			fg = colors.darkgray,
			bg = default.bg,
			ctermfg = 8,
			ctermbg = default.ctermbg,
		},
	})

	tabline = {
		start = lib.gui(args.start),
		leftSep = lib.gui(args.leftSep),
		leftPad = lib.gui(args.leftPad),
		rightPad = lib.gui(args.rightPad),
		rightSep = lib.gui(args.rightSep),
		leftSepHl = lib.mkHl(string.format("Oishiline%sLeftSep", suffix), args.leftSepHl, args.leftSepHlAlt),
		iconHl = lib.mkHl(string.format("Oishiline%sIcon", suffix), args.iconHl, args.iconHlAlt),
		dataHl = lib.mkHl(string.format("Oishiline%sData", suffix), args.dataHl, args.dataHlAlt),
		rightSepHl = lib.mkHl(string.format("Oishiline%sRightSep", suffix), args.rightSepHl, args.rightSepHlAlt),
	}
end

function M.run()
	local activeTab = vim.fn.tabpagenr()
	local results = {}
	local i, j = 1, 1

	while i <= vim.fn.tabpagenr("$") do
		local buf = vim.fn.tabpagebuflist(i)[vim.fn.tabpagewinnr(i)]
		local basename = string.gsub(vim.api.nvim_buf_get_name(buf), ".*/", "")

		j = lib.insert(
			results,
			j,
			activeTabline(activeTab, i, i == 1 and tabline.start or tabline.leftSep, tabline.leftSepHl)
		)

		j = lib.insert(
			results,
			j,
			activeTabline(
				activeTab,
				i,
				hasDevicons and
				string.format(" %s", require("nvim-web-devicons").get_icon(basename, vim.bo[buf].filetype)) or
				"",
				tabline.iconHl
			)
		)

		j = lib.insert(results, j, tabline.leftPad)

		j = lib.insert(
			results,
			j,
			activeTabline(activeTab, i, basename == "" and "[No Name]" or basename, tabline.dataHl)
		)

		j = lib.insert(results, j, tabline.rightPad)
		j = lib.insert(results, j, activeTabline(activeTab, i, tabline.rightSep, tabline.rightSepHl))
		i = i + 1
	end

	j = lib.insert(results, j, lib.default)

	return table.concat(results)
end

return M
