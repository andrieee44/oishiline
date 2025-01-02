local mode, allModes
local M = {}
local lib = require("oishiline.modules.lib")

local modes = {
	["n"] = "NORMAL",
	["niI"] = "NORMAL",
	["niR"] = "NORMAL",
	["niV"] = "NORMAL",
	["nt"] = "NORMAL",
	["ntT"] = "NORMAL",
	["no"] = "O-PENDING",
	["nov"] = "O-PENDING",
	["noV"] = "O-PENDING",
	["no\22"] = "O-PENDING",
	["v"] = "VISUAL",
	["vs"] = "VISUAL",
	["V"] = "V-LINE",
	["Vs"] = "V-LINE",
	["\22"] = "V-BLOCK",
	["\22s"] = "V-BLOCK",
	["s"] = "SELECT",
	["S"] = "S-LINE",
	["\19"] = "S-BLOCK",
	["i"] = "INSERT",
	["ic"] = "INSERT",
	["ix"] = "INSERT",
	["R"] = "REPLACE",
	["Rc"] = "REPLACE",
	["Rx"] = "REPLACE",
	["Rv"] = "V-REPLACE",
	["Rvc"] = "V-REPLACE",
	["Rvx"] = "V-REPLACE",
	["c"] = "COMMAND",
	["cv"] = "EX",
	["ce"] = "EX",
	["r"] = "REPLACE",
	["rm"] = "MORE",
	["r?"] = "CONFIRM",
	["!"] = "SHELL",
	["t"] = "TERMINAL",
}

function M.init(globalArgs, moduleArgs)
	local colors = globalArgs.colors

	local commonModes = {
		["normal"] = {
			bg = colors.darkblue,
			ctermbg = 4,
		},

		["visual"] = {
			bg = colors.darkmagenta,
			ctermbg = 5,
		},

		["insert"] = {
			bg = colors.darkgreen,
			ctermbg = 2,
		},

		["replace"] = {
			bg = colors.darkred,
			ctermbg = 1,
		},

		["command"] = {
			bg = colors.darkblue,
			ctermbg = 4,
		},

		["terminal"] = {
			bg = colors.darkgreen,
			ctermbg = 2,
		},
	}

	allModes = {
		["NORMAL"] = commonModes.normal,
		["O-PENDING"] = commonModes.normal,
		["VISUAL"] = commonModes.visual,
		["V-LINE"] = commonModes.visual,
		["V-BLOCK"] = commonModes.visual,
		["SELECT"] = commonModes.visual,
		["S-LINE"] = commonModes.visual,
		["S-BLOCK"] = commonModes.visual,
		["INSERT"] = commonModes.insert,
		["REPLACE"] = commonModes.replace,
		["V-REPLACE"] = commonModes.replace,
		["COMMAND"] = commonModes.command,
		["EX"] = commonModes.command,
		["MORE"] = commonModes.command,
		["CONFIRM"] = commonModes.command,
		["SHELL"] = commonModes.normal,
		["TERMINAL"] = commonModes.terminal,
	}

	local dataHl = {
		fg = colors.black,
		bg = colors.darkblue,
		ctermfg = 0,
		ctermbg = 4,
		bold = true,
	}

	local dataHlAlt = {
		fg = colors.lightgray,
		bg = colors.darkgray,
		ctermfg = 7,
		ctermbg = 8,
	}

	mode = lib.stdModule("Mode", moduleArgs, {
		leftSepHl = dataHl,
		leftSepHlAlt = dataHlAlt,
		iconHl = dataHl,
		iconHlAlt = dataHlAlt,
		dataHl = dataHl,
		dataHlAlt = dataHlAlt,

		rightSepHl = {
			fg = colors.darkblue,
			bg = globalArgs.default.bg,
			ctermfg = 4,
			ctermbg = globalArgs.default.ctermbg,
		},

		rightSepHlAlt = {
			fg = colors.darkgray,
			bg = globalArgs.default.bg,
			ctermfg = 8,
			ctermbg = globalArgs.default.ctermbg,
		},

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
			gui = "",
			tty = "",
		},
	})
end

function M.run()
	local modeCode = vim.api.nvim_get_mode().mode

	return lib.stdFormat(mode, modes[modeCode])
end

return M
