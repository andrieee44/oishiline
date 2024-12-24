local M = {}
local lib = require("oishiline.modules.lib")

function M.init(globalArgs, moduleArgs)
	local colors = globalArgs.colors

	M.fmt = lib.mkHl(lib.hlName("Branch", "Fmt"), {
		fg = colors.black,
		ctermfg = "black",
		bg = colors.blue,
		ctermbg = "darkblue",
		bold = true,
	}, {
		fg = colors.white,
		ctermfg = "lightgray",
		bg = colors.brightblack,
		ctermbg = "darkgray",
	})
end

function M.run()
	local path = string.match(vim.api.nvim_buf_get_name(0), ".*/")
	local cmd = string.format("git -C '%s' branch --show-current 2> /dev/null", path)
	local branch = lib.run(cmd)

	if branch == nil then
		return ""
		
	end

	return string.format(" %s%s %s", lib.colorStr(lib.gui(" ", ""), M.fmt), branch, lib.gui("", "|"))
end

return M
