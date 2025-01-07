return function()
	local lib = require("oishiline.modules.lib")
	local location
	local M = {}

	function M.init(globalArgs, moduleArgs)
		local colors = globalArgs.colors

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

		location = lib.stdModule(string.format("Location%s", moduleArgs.suffix or ""), moduleArgs, {
			leftSepHl = dataHl,
			leftSepHlAlt = dataHlAlt,
			iconHl = dataHl,
			iconHlAlt = dataHlAlt,
			dataHl = dataHl,
			dataHlAlt = dataHlAlt,
			rightSepHl = dataHl,
			rightSepHlAlt = dataHlAlt,

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
				gui = "",
				tty = "",
			},
		})
	end

	function M.run()
		return lib.stdFormat(location, "%3l:%-2c")
	end

	return M
end
