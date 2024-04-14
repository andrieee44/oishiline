return function(colors)
	local lib = require('modules.lib')
	local module = 'Mode'

	local cfg = {
		hl = lib.mkHl(lib.hlName(module, 'Fmt'), {
			fg = colors.black,
			bg = colors.cyan,
			bold = true,
		}, {
			fg = colors.white,
			bg = colors.brightBlack,
		}),

		right = lib.mkHlStr(lib.gui('', ' '), lib.hlName(module, 'Right'), {
			fg = colors.cyan,
			bg = colors.black,
		}, {
			fg = colors.brightBlack,
			bg = colors.black,
		}),

		sep = lib.mkHlStr(lib.gui('', ' '), lib.hlName(module, 'Sep'), {
			fg = colors.black,
			bg = colors.cyan,
		}, {
			fg = colors.black,
			bg = colors.brightBlack,
		}),

		modes = {
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
		},
	}

	return function()
		local right = lib.colorStr(cfg.right.str, cfg.right)
		local sep = lib.colorStr(cfg.sep.str, cfg.sep)

		local modeCode = vim.api.nvim_get_mode().mode
		local mode = cfg.modes[modeCode] or modeCode

		return string.format('%s %s%s', lib.colorStr(string.format(' %s', mode), cfg.hl), right, sep)
	end
end
