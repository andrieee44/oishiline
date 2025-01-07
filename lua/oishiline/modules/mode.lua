return function()
	local lib = require("oishiline.modules.lib")
	local mode, colors, default, modeColors, suffix
	local M = {}

	local modes = {
		n = "NORMAL",
		niI = "NORMAL",
		niR = "NORMAL",
		niV = "NORMAL",
		nt = "NORMAL",
		ntT = "NORMAL",
		no = "O-PENDING",
		nov = "O-PENDING",
		noV = "O-PENDING",
		["no\22"] = "O-PENDING",
		v = "VISUAL",
		vs = "VISUAL",
		V = "V-LINE",
		Vs = "V-LINE",
		["\22"] = "V-BLOCK",
		["\22s"] = "V-BLOCK",
		s = "SELECT",
		S = "S-LINE",
		["\19"] = "S-BLOCK",
		i = "INSERT",
		ic = "INSERT",
		ix = "INSERT",
		R = "REPLACE",
		Rc = "REPLACE",
		Rx = "REPLACE",
		Rv = "V-REPLACE",
		Rvc = "V-REPLACE",
		Rvx = "V-REPLACE",
		c = "COMMAND",
		cv = "EX",
		ce = "EX",
		r = "REPLACE",
		rm = "MORE",
		["r?"] = "CONFIRM",
		["!"] = "SHELL",
		t = "TERMINAL",
	}

	function M.init(globalArgs, moduleArgs)
		colors = globalArgs.colors
		default = globalArgs.default
		suffix = moduleArgs.suffix or ""

		local args = vim.tbl_deep_extend("keep", moduleArgs, {
			normal = {
				bg = colors.darkblue,
				ctermbg = 4,
			},

			visual = {
				bg = colors.darkmagenta,
				ctermbg = 5,
			},

			insert = {
				bg = colors.darkgreen,
				ctermbg = 2,
			},

			replace = {
				bg = colors.darkred,
				ctermbg = 1,
			},

			command = {
				bg = colors.darkblue,
				ctermbg = 4,
			},

			terminal = {
				bg = colors.darkgreen,
				ctermbg = 2,
			},

			leftSep = {
				gui = "",
				tty = "",
			},

			leftPad = {
				gui = " ",
				tty = " ",
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

		modeColors = {
			NORMAL = args.normal,
			["O-PENDING"] = args.normal,
			VISUAL = args.visual,
			["V-LINE"] = args.visual,
			["V-BLOCK"] = args.visual,
			SELECT = args.visual,
			["S-LINE"] = args.visual,
			["S-BLOCK"] = args.visual,
			INSERT = args.insert,
			REPLACE = args.replace,
			["V-REPLACE"] = args.replace,
			COMMAND = args.command,
			EX = args.command,
			MORE = args.command,
			CONFIRM = args.command,
			SHELL = args.normal,
			TERMINAL = args.terminal,
		}

		mode = {
			leftSep = lib.gui(args.leftSep),
			leftPad = lib.gui(args.leftPad),
			rightPad = lib.gui(args.rightPad),
			rightSep = lib.gui(args.rightSep),
		}
	end

	function M.run()
		local modeCode = vim.api.nvim_get_mode().mode

		local altHl = {
			fg = colors.lightgray,
			bg = colors.darkgray,
			ctermfg = 7,
			ctermbg = 8,
		}

		local dataHl = lib.mkHl(string.format("OishilineMode%sData", suffix), {
			fg = colors.black,
			bg = modeColors[modes[modeCode]].bg,
			ctermfg = 0,
			ctermbg = modeColors[modes[modeCode]].ctermbg,
			bold = true,
		}, altHl)

		local leftSepHl = lib.mkHl(string.format("OishilineMode%sLeftSep", suffix), {
			fg = default.bg,
			bg = modeColors[modes[modeCode]].bg,
			ctermfg = default.ctermbg,
			ctermbg = modeColors[modes[modeCode]].ctermbg,
		}, {
			fg = default.bg,
			bg = colors.darkgray,
			ctermbg = default.ctermbg,
			ctermfg = 7,
		})

		local rightSepHl = lib.mkHl(string.format("OishilineMode%sRightSep", suffix), {
			fg = modeColors[modes[modeCode]].bg,
			bg = default.bg,
			ctermfg = modeColors[modes[modeCode]].ctermbg,
			ctermbg = default.ctermbg,
		}, {
			fg = colors.darkgray,
			bg = default.bg,
			ctermbg = 7,
			ctermfg = default.ctermbg,
		})

		return string.format(
			"%s%s%s",
			lib.colorStr(mode.leftSep, leftSepHl),
			lib.colorStr(string.format("%s%s%s", mode.leftPad, modes[modeCode], mode.rightPad), dataHl),
			lib.colorStr(mode.rightSep, rightSepHl)
		)
	end

	return M
end
