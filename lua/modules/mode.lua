return function(colors)
	local lib = require('modules.lib')
	local module = 'Mode'

	local fmt = lib.mkHl(lib.hlName(module, 'Fmt'), {
		fg = colors.black,
		ctermfg = 'black',
		bg = colors.cyan,
		ctermbg = 'cyan',
		bold = true,
	})

	local rightSep = lib.mkHlStr(lib.gui('', ' '), lib.hlName(module, 'Right'), {
		fg = colors.cyan,
		ctermfg = 'cyan',
		bg = colors.black,
		ctermbg = 'black',
	})

	local rightSep2 = lib.mkHlStr(lib.gui('', ''), lib.hlName(module, 'Right2'), {
		fg = colors.black,
		ctermfg = 'black',
		bg = colors.cyan,
		ctermbg = 'cyan',
		bold = true,
	}, {
		fg = colors.black,
		ctermfg = 'black',
		bg = colors.brightBlack,
		ctermbg = 'black',
	})

	local modes = {
		['n'] = 'NORMAL',
		['niI'] = 'NORMAL',
		['niR'] = 'NORMAL',
		['niV'] = 'NORMAL',
		['nt'] = 'NORMAL',
		['ntT'] = 'NORMAL',
		['no'] = 'O-PENDING',
		['nov'] = 'O-PENDING',
		['noV'] = 'O-PENDING',
		['no\22'] = 'O-PENDING',
		['v'] = 'VISUAL',
		['vs'] = 'VISUAL',
		['V'] = 'V-LINE',
		['Vs'] = 'V-LINE',
		['\22'] = 'V-BLOCK',
		['\22s'] = 'V-BLOCK',
		['s'] = 'SELECT',
		['S'] = 'S-LINE',
		['\19'] = 'S-BLOCK',
		['i'] = 'INSERT',
		['ic'] = 'INSERT',
		['ix'] = 'INSERT',
		['R'] = 'REPLACE',
		['Rc'] = 'REPLACE',
		['Rx'] = 'REPLACE',
		['Rv'] = 'V-REPLACE',
		['Rvc'] = 'V-REPLACE',
		['Rvx'] = 'V-REPLACE',
		['c'] = 'COMMAND',
		['cv'] = 'EX',
		['ce'] = 'EX',
		['r'] = 'REPLACE',
		['rm'] = 'MORE',
		['r?'] = 'CONFIRM',
		['!'] = 'SHELL',
		['t'] = 'TERMINAL',
	}

	return function()
		local right = lib.colorStr(rightSep.str, rightSep)
		local sep = lib.colorStr(rightSep2.str, rightSep2)

		local modeCode = vim.api.nvim_get_mode().mode
		local mode = modes[modeCode] or modeCode

		return string.format('%s %s%s', lib.colorStr(string.format(' %s', mode), fmt), right, sep)
	end
end
