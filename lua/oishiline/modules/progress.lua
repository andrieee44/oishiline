return function()
	local progress
	local M = {}
	local lib = require("oishiline.modules.lib")

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

		progress = lib.stdModule(string.format("Progress%s", moduleArgs.suffix or ""), moduleArgs, {
			iconHl = dataHl,
			iconHlAlt = dataHlAlt,
			dataHl = dataHl,
			dataHlAlt = dataHlAlt,
			rightSepHl = dataHl,
			rightSepHlAlt = dataHlAlt,

			leftSepHl = {
				fg = colors.darkblue,
				bg = colors.darkgray,
				ctermfg = 4,
				ctermbg = 8,
			},

			leftSepHlAlt = {
				fg = colors.darkgray,
				bg = colors.darkgray,
				ctermfg = 8,
				ctermbg = 8,
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
				gui = "",
				tty = "|",
			},
		})
	end

	function M.run()
		return lib.stdFormat(progress, "%P")
	end

	return M
end
