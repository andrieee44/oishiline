local branch, oldPath, branchName
local M = {}
local lib = require("oishiline.modules.lib")

function M.init(globalArgs, moduleArgs)
	local colors = globalArgs.colors

	local fmtHl = {
		fg = colors.black,
		bg = colors.darkblue,
		ctermfg = "black",
		ctermbg = "darkblue",
		bold = true,
	}

	local fmtHlAlt = {
		fg = colors.lightgray,
		bg = colors.darkgray,
		ctermfg = "lightgray",
		ctermbg = "darkgray",
	}

	branch = lib.stdModule("Branch", moduleArgs, {
		leftSepHl = fmtHl,
		leftSepHlAlt = fmtHlAlt,
		iconHl = fmtHl,
		iconHlAlt = fmtHlAlt,
		fmtHl = fmtHl,
		fmtHlAlt = fmtHlAlt,
		rightSepHl = fmtHl,
		rightSepHlAlt = fmtHlAlt,

		leftSep = {
			gui = "",
			tty = " ",
		},

		icon = {
			gui = "  ",
			tty = "",
		},

		rightSep = {
			gui = " ",
			tty = " |",
		},
	})
end

function M.run()
	local path = string.match(vim.api.nvim_buf_get_name(0), ".*/")

	if path ~= oldPath then
		branchName = lib.run(string.format("git -C '%s' branch --show-current 2> /dev/null", path))
	end

	oldPath = path

	if branchName == nil then
		return ""
	end

	return string.format(
		"%s%s%s%s%s",
		lib.colorStr(branch.leftSep, branch.leftSepHl),
		lib.colorStr(branch.icon, branch.iconHl),
		lib.colorStr(branchName, branch.fmtHl),
		lib.colorStr(branch.rightSep, branch.rightSepHl),
		lib.default
	)
end

return M
