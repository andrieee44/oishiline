return function(colors)
	local lib = require('oishiline.modules.lib')
	local module = 'Filename'

	local fmt = lib.mkHlStr('%f%( %w%h%m%r%)', lib.hlName(module, 'Fmt'), {
		fg = colors.black,
		ctermfg = 'black',
		bg = colors.blue,
		ctermbg = 'darkblue',
		bold = true,
	}, {
		fg = colors.white,
		ctermfg = 'lightgray',
		bg = colors.brightblack,
		ctermbg = 'darkgray',
	})

	local rightSep = lib.mkHlStr(lib.gui('', ' '), lib.hlName(module, 'Right'), {
		fg = colors.blue,
		ctermfg = 'darkblue',
		bg = colors.black,
		ctermbg = 'black',
	}, {
		fg = colors.brightblack,
		ctermfg = 'darkgray',
		bg = colors.black,
		ctermbg = 'black',
	})

	return function()
		local right = lib.colorStr(rightSep.str, rightSep)

		return string.format(' %s %s', lib.colorStr(fmt.str, fmt), right)
	end
end
