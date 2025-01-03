local separator, dataHl
local M = {}
local lib = require("oishiline.modules.lib")

function M.init(globalArgs, moduleArgs)
	local colors = globalArgs.colors
	local default = globalArgs.default

	separator = vim.tbl_deep_extend("keep", moduleArgs, {
		active = {
			gui = "",
			tty = "",
		},

		inactive = {
			gui = "",
			tty = "",
		},

		dataHl = {
			fg = default.bg,
			bg = colors.darkblue,
			ctermfg = default.ctermbg,
			ctermbg = 4,
		},

		dataHlAlt = {
			fg = default.bg,
			bg = colors.darkgray,
			ctermfg = default.ctermbg,
			ctermbg = 8,
		},
	})

	dataHl = lib.mkHl(string.format("OishilineStatuslineSeparator%sData", moduleArgs.suffix or ""), separator.dataHl,
		separator.dataHlAlt)
end

function M.run()
	local sep = lib.gui(lib.active(separator.active, separator.inactive))

	return lib.colorStr(sep, dataHl)
end

return M
