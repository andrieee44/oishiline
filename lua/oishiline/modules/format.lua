local format
local M = {}
local lib = require("oishiline.modules.lib")

local icons = {
	unix = lib.gui("", "unix"),
	dos = lib.gui("", "dos"),
	mac = lib.gui("", "mac"),
}

function M.init(globalArgs, moduleArgs)
	local colors = globalArgs.colors

	local dataHl = {
		fg = colors.lightgray,
		bg = colors.darkgray,
		ctermfg = 7,
		ctermbg = 8,
	}

	format = lib.stdModule("Format", moduleArgs, {
		leftSepHl = dataHl,
		leftSepHlAlt = dataHl,
		iconHl = dataHl,
		iconHlAlt = dataHl,
		dataHl = dataHl,
		dataHlAlt = dataHl,
		rightSepHl = dataHl,
		rightSepHlAlt = dataHl,

		leftSep = {
			gui = "",
			tty = "",
		},

		leftPad = {
			gui = " ",
			tty = " ",
		},

		icon = {
			gui = "",
			tty = "",
		},

		rightPad = {
			gui = " ",
			tty = " ",
		},

		rightSep = {
			gui = "",
			tty = "|",
		},
	})
end

function M.run()
	return lib.stdFormat(format, icons[vim.bo.fileformat] or vim.bo.fileformat)
end

return M
