return function()
	local lib = require("oishiline.modules.lib")
	local separator, dataHl
	local M = {}

	function M.init(globalArgs, moduleArgs)
		local colors = globalArgs.colors
		local default = globalArgs.default

		separator = vim.tbl_deep_extend("keep", moduleArgs, {
			active = {
				gui = "",
				tty = " ",
			},

			inactive = {
				gui = "",
				tty = " ",
			},

			dataHl = {
				fg = default.bg,
				bg = colors.darkblue,
				ctermfg = 7,
				ctermbg = default.ctermbg,
			},

			dataHlAlt = {
				fg = default.bg,
				bg = colors.darkgray,
				ctermfg = 7,
				ctermbg = default.ctermbg,
			},
		})

		dataHl = lib.mkHl(
			string.format("OishilineSeparator%sData", moduleArgs.suffix or ""),
			separator.dataHl,
			separator.dataHlAlt
		)
	end

	function M.run()
		local sep = lib.gui(lib.active(separator.active, separator.inactive))

		return lib.colorStr(sep, dataHl)
	end

	return M
end
