local filename
local M = {}
local lib = require("oishiline.modules.lib")

function M.init(globalArgs, moduleArgs)
	local colors = globalArgs.colors

	local dataHl = {
		fg = colors.black,
		ctermfg = "black",
		bg = colors.blue,
		ctermbg = "darkblue",
		bold = true,
	}

	local dataHlAlt = {
		fg = colors.white,
		ctermfg = "lightgray",
		bg = colors.brightblack,
		ctermbg = "darkgray",
	}

	filename = lib.stdModule("Filename", moduleArgs, {
		leftSepHl = dataHl,
		leftSepHlAlt = dataHlAlt,
		iconHl = dataHl,
		iconHlAlt = dataHlAlt,
		dataHl = dataHl,
		dataHlAlt = dataHlAlt,

		rightSepHl = {
			fg = colors.blue,
			ctermfg = "darkblue",
			bg = colors.black,
			ctermbg = "black",
		},

		rightSepHlAlt = {
			fg = colors.brightblack,
			ctermfg = "darkgray",
			bg = colors.black,
			ctermbg = "black",
		},

		leftSep = {
			gui = "",
			tty = "⠀",
		},

		icon = {
			gui = "",
			tty = "",
		},

		rightSep = {
			gui = "",
			tty = "",
		},
	})
end

function M.run()
	return lib.stdFormat(filename, "%f%( %w%h%m%r%)")
end

return M
