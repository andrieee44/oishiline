return function()
	local separator, dataHl
	local M = {}
	local lib = require("oishiline.modules.lib")

	function M.init(globalArgs, moduleArgs)
		local colors = globalArgs.colors
		local default = globalArgs.default
		local gui = vim.opt.termguicolors._value

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
			},

			dataHlAlt = {
				fg = default.bg,
				bg = colors.darkgray,
			},

			dataHlTty = {
				ctermfg = 7,
				ctermbg = default.ctermbg,
			},

			dataHlAltTty = {
				ctermfg = 7,
				ctermbg = default.ctermbg,
			},
		})

		dataHl = lib.mkHl(
			string.format("OishilineSeparator%sData", moduleArgs.suffix or ""),
			gui and separator.dataHl or separator.dataHlTty,
			gui and separator.dataHlAlt or separator.dataHlAltTty
		)
	end

	function M.run()
		local sep = lib.gui(lib.active(separator.active, separator.inactive))

		return lib.colorStr(sep, dataHl)
	end

	return M
end
