return function(colors)
	local lib = require('modules.lib')
	local module = 'Encoding'

	local fmt = lib.mkHl(lib.hlName(module, 'Fmt'), {
		fg = colors.white,
		bg = colors.brightBlack,
	})

	local leftSep = lib.mkHlStr(lib.gui('', ' '), lib.hlName(module, 'Left'), {
		fg = colors.brightBlack,
		bg = colors.black,
	})

	return function()
		local left = lib.colorStr(leftSep.str, leftSep)
		local right = lib.colorStr(lib.gui('', '|'), fmt)

		local encoding = string.format(' %s', vim.bo.fileencoding)

		return string.format('%s%s %s', left, lib.colorStr(encoding, fmt), right)
	end
end
