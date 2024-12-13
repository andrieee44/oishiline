return function(colors)
	local lib = require("oishiline.modules.lib")
	local module = "Mode"

	local commonColors = {
		["normal"] = {
			bg = colors.blue,
			ctermbg = "darkblue",
		},

		["visual"] = {
			bg = colors.magenta,
			ctermbg = "darkmagenta",
		},

		["insert"] = {
			bg = colors.green,
			ctermbg = "darkgreen",
		},

		["replace"] = {
			bg = colors.red,
			ctermbg = "darkred",
		},

		["command"] = {
			bg = colors.blue,
			ctermbg = "darkblue",
		},

		["terminal"] = {
			bg = colors.green,
			ctermbg = "darkgreen",
		},
	}

	local modeColors = {
		["NORMAL"] = commonColors.normal,
		["O-PENDING"] = commonColors.normal,
		["VISUAL"] = commonColors.visual,
		["V-LINE"] = commonColors.visual,
		["V-BLOCK"] = commonColors.visual,
		["SELECT"] = commonColors.visual,
		["S-LINE"] = commonColors.visual,
		["S-BLOCK"] = commonColors.visual,
		["INSERT"] = commonColors.insert,
		["REPLACE"] = commonColors.replace,
		["V-REPLACE"] = commonColors.replace,
		["COMMAND"] = commonColors.command,
		["EX"] = commonColors.command,
		["MORE"] = commonColors.command,
		["CONFIRM"] = commonColors.command,
		["SHELL"] = commonColors.normal,
		["TERMINAL"] = commonColors.terminal,
	}

	local rightSep2 = lib.mkHlStr(lib.gui("", ""), lib.hlName(module, "Right2"), {
		fg = colors.black,
		ctermfg = "black",
		bg = colors.blue,
		ctermbg = "darkblue",
		bold = true,
	}, {
		fg = colors.black,
		ctermfg = "black",
		bg = colors.brightblack,
		ctermbg = "darkgray",
	})

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

	return function()
		local sep = lib.colorStr(rightSep2.str, rightSep2)
		local modeCode = vim.api.nvim_get_mode().mode
		local mode = modes[modeCode]

		local fmt = lib.mkHl(lib.hlName(module, "Fmt"), {
			fg = colors.black,
			ctermfg = "black",
			bg = modeColors[mode].bg,
			ctermbg = modeColors[mode].ctermbg,
			bold = true,
		})

		local rightSep = lib.mkHlStr(lib.gui("", " "), lib.hlName(module, "Right"), {
			fg = modeColors[mode].bg,
			ctermfg = modeColors[mode].ctermbg,
			bg = colors.black,
			ctermbg = "black",
		})

		local right = lib.colorStr(rightSep.str, rightSep)

		return string.format("%s %s%s", lib.colorStr(string.format(" %s", mode), fmt), right, sep)
	end
end
