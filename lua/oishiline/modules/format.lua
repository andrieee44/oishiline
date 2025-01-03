local format
local M = {}
local lib = require("oishiline.modules.lib")

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
