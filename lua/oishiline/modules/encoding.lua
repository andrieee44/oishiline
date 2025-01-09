return function()
	local lib = require("oishiline.modules.lib")
	local encoding
	local M = {}

	function M.init(globalArgs, moduleArgs)
		local colors = globalArgs.colors

		local leftSepHl = {
			fg = colors.darkgray,
			bg = globalArgs.default.bg,
			ctermfg = 8,
			ctermbg = globalArgs.default.ctermbg,
		}

		local dataHl = {
			fg = colors.lightgray,
			bg = colors.darkgray,
			ctermfg = 7,
			ctermbg = 8,
		}

		encoding = lib.stdModule(string.format("Encoding%s", moduleArgs.suffix or ""), moduleArgs, {
			leftSep = lib.empty,
			leftPad = lib.pad,
			icon = lib.empty,
			rightPad = lib.pad,
			leftSepHl = leftSepHl,
			leftSepHlAlt = leftSepHl,
			iconHl = dataHl,
			iconHlAlt = dataHl,
			dataHl = dataHl,
			dataHlAlt = dataHl,
			rightSepHl = dataHl,
			rightSepHlAlt = dataHl,

			rightSep = {
				gui = "",
				tty = "|",
			},
		})
	end

	function M.run()
		local enc = vim.bo.fileencoding

		return enc == "" and "" or lib.stdFormat(encoding, enc)
	end

	return M
end
