local M = {}
local lib = require("oishiline.modules.lib")

function M.init(globalArgs, moduleArgs)
	local colors = globalArgs.colors

	M.fmt = lib.mkHl("OishilineStatuslineBranch",
		vim.tbl_deep_extend("keep", moduleArgs.fmt or {}, {
			fg = colors.black,
			bg = colors.darkblue,
			ctermfg = "black",
			ctermbg = "darkblue",
			bold = true,
		}), vim.tbl_deep_extend("keep", moduleArgs.fmtAlt or {}, {
			fg = colors.lightgray,
			bg = colors.darkgray,
			ctermfg = "lightgray",
			ctermbg = "darkgray",
		}))

	M.icon = lib.gui(vim.tbl_deep_extend("keep", moduleArgs.icon or {}, {
		gui = "",
		tty = "",
	}))

	M.leftSep = lib.gui(vim.tbl_deep_extend("keep", moduleArgs.leftSep or {}, {
		gui = " ",
		tty = " ",
	}))

	M.rightSep = lib.gui(vim.tbl_deep_extend("keep", moduleArgs.rightSep or {}, {
		gui = " ",
		tty = " |",
	}))
end

function M.run()
	local path = string.match(vim.api.nvim_buf_get_name(0), ".*/")

	if path ~= M.oldPath then
		M.branch = lib.run(string.format("git -C '%s' branch --show-current 2> /dev/null", path))
	end

	M.oldPath = path

	if M.branch == nil then
		return ""
	end

	return string.format("%s%s%s%s%s", lib.colorStr(M.icon, M.fmt), M.leftSep, M.branch, M.rightSep, lib.default)
end

return M
