local fmt, icon, leftSep, rightSep, oldPath, branch
local M = {}
local lib = require("oishiline.modules.lib")

function M.init(globalArgs, moduleArgs)
	local colors = globalArgs.colors

	fmt = lib.mkHl(
		"OishilineStatuslineBranch",
		vim.tbl_deep_extend("keep", moduleArgs.fmt or {}, {
			fg = colors.black,
			bg = colors.darkblue,
			ctermfg = "black",
			ctermbg = "darkblue",
			bold = true,
		}),
		vim.tbl_deep_extend("keep", moduleArgs.fmtAlt or {}, {
			fg = colors.lightgray,
			bg = colors.darkgray,
			ctermfg = "lightgray",
			ctermbg = "darkgray",
		})
	)

	icon = lib.gui(vim.tbl_deep_extend("keep", moduleArgs.icon or {}, {
		gui = "",
		tty = "",
	}))

	leftSep = lib.gui(vim.tbl_deep_extend("keep", moduleArgs.leftSep or {}, {
		gui = " ",
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

	return string.format("%s%s%s%s%s", lib.colorStr(icon, fmt), leftSep, branch, rightSep, lib.default)
end

return M
