return function()
	local lib = require("oishiline.modules.lib")
	local format
	local M = {}

	local icons = {
		unix = lib.gui({
			gui = "",
			tty = "unix",
		}),

		dos = lib.gui({
			gui = "",
			tty = "dos",
		}),

		mac = lib.gui({
			gui = "",
			tty = "mac",
		}),
	}

	function M.init(globalArgs, moduleArgs)
		local colors = globalArgs.colors

		local dataHl = {
			fg = colors.lightgray,
			bg = colors.darkgray,
			ctermfg = 7,
			ctermbg = 8,
		}

		format = lib.stdModule(string.format("Format%s", moduleArgs.suffix or ""), moduleArgs, {
			leftSep = lib.empty,
			leftPad = lib.pad,
			icon = lib.empty,
			rightPad = lib.pad,
			rightSep = lib.empty,
			leftSepHl = dataHl,
			leftSepHlAlt = dataHl,
			iconHl = dataHl,
			iconHlAlt = dataHl,
			dataHl = dataHl,
			dataHlAlt = dataHl,
			rightSepHl = dataHl,
			rightSepHlAlt = dataHl,
		})
	end

	function M.run()
		return lib.stdFormat(format, icons[vim.bo.fileformat] or vim.bo.fileformat)
	end

	return M
end
