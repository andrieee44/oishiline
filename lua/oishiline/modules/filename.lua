return function(colors)
	local lib = require('oishiline.modules.lib')
	local module = 'Filename'

	local fmt = lib.mkHlStr('%f%( %w%h%m%r%)', lib.hlName(module, 'Fmt'), {
		fg = colors.bg,
		ctermfg = 'black',
		bg = colors.normal,
		ctermbg = 'blue',
		bold = true,
	}, {
		fg = colors.fg,
		ctermfg = 'white',
		bg = colors.alt_bg,
		ctermbg = 'black',
	})

	local rightSep = lib.mkHlStr(lib.gui('', ' '), lib.hlName(module, 'Right'), {
		fg = colors.normal,
		ctermfg = 'blue',
		bg = colors.bg,
		ctermbg = 'black',
	}, {
		fg = colors.alt_bg,
		ctermfg = 'black',
		bg = colors.bg,
		ctermbg = 'black',
	})

	return function()
		local right = lib.colorStr(rightSep.str, rightSep)

		return string.format(' %s %s', lib.colorStr(fmt.str, fmt), right)
	end
end
