local leftSepHl, iconHl, branchHl, rightSepHl, leftSep, icon, rightSep, oldPath, branch
local M = {}
local lib = require("oishiline.modules.lib")

function M.init(globalArgs, moduleArgs)
	local colors = globalArgs.colors

	local branchHlData = vim.tbl_deep_extend("keep", moduleArgs.branchHl or {}, {
		fg = colors.black,
		bg = colors.darkblue,
		ctermfg = "black",
		ctermbg = "darkblue",
		bold = true,
	})

	local branchHlAlt = vim.tbl_deep_extend("keep", moduleArgs.branchHlAlt or {}, {
		fg = colors.lightgray,
		bg = colors.darkgray,
		ctermfg = "lightgray",
		ctermbg = "darkgray",
	})

	leftSepHl = lib.mkHl(
		"OishilineStatuslineBranchLeftSep",
		vim.tbl_deep_extend("keep", moduleArgs.leftSepHl or {}, branchHlData),
		vim.tbl_deep_extend("keep", moduleArgs.leftSepHlAlt or {}, branchHlAlt)
	)

	iconHl = lib.mkHl(
		"OishilineStatuslineBranchIcon",
		vim.tbl_deep_extend("keep", moduleArgs.iconHl or {}, branchHlData),
		vim.tbl_deep_extend("keep", moduleArgs.iconHlAlt or {}, branchHlAlt))

	branchHl = lib.mkHl("OishilineStatuslineBranchFmt", branchHlData, branchHlAlt)

	rightSepHl = lib.mkHl(
		"OishilineStatuslineBranchRightSep",
		vim.tbl_deep_extend("keep", moduleArgs.rightSepHl or {}, branchHlData),
		vim.tbl_deep_extend("keep", moduleArgs.rightSepHlAlt or {}, branchHlAlt)
	)

	icon = lib.gui(vim.tbl_deep_extend("keep", moduleArgs.icon or {}, {
		gui = "  ",
		tty = "",
	}))

	leftSep = lib.gui(vim.tbl_deep_extend("keep", moduleArgs.leftSep or {}, {
		gui = "",
		tty = " ",
	}))

	rightSep = lib.gui(vim.tbl_deep_extend("keep", moduleArgs.rightSep or {}, {
		gui = " ",
		tty = " |",
	}))
end

function M.run()
	local path = string.match(vim.api.nvim_buf_get_name(0), ".*/")

	if path ~= oldPath then
		branch = lib.run(string.format("git -C '%s' branch --show-current 2> /dev/null", path))
	end

	oldPath = path

	if branch == nil then
		return ""
	end

	return string.format(
		"%s%s%s%s%s",
		lib.colorStr(leftSep, leftSepHl),
		lib.colorStr(icon, iconHl),
		lib.colorStr(branch, branchHl),
		lib.colorStr(rightSep, rightSepHl),
		lib.default
	)
end

return M
