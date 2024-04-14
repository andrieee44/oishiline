return function(colors)
	local lib = require('modules.lib')
	local module = 'Filename'

	local fmt = lib.mkHlStr('%f%( %w%h%m%r%)', lib.hlName(module, 'Fmt'), {
		fg = colors.black,
		ctermfg = 'black',
		bg = colors.cyan,
		ctermbg = 'cyan',
		bold = true,
	}, {
		fg = colors.white,
		ctermfg = 'white',
		bg = colors.brightBlack,
		ctermbg = 'black',
	})

	local rightSep = lib.mkHlStr(lib.gui('', ' '), lib.hlName(module, 'Right'), {
		fg = colors.cyan,
		ctermfg = 'cyan',
		bg = colors.black,
		ctermbg = 'black',
	}, {
		fg = colors.brightBlack,
		ctermfg = 'black',
		bg = colors.white,
		ctermbg = 'white',
	})

	return function()
		local fmt = lib.colorStr(fmt.str, fmt)
		local right = lib.colorStr(rightSep.str, rightSep)

		return string.format(' %s %s', fmt, right)
	end
end
