return function(args)
	local lib = require('modules.lib')
	local module = 'Mode'

	local cfg = {
		hl = lib.mkHl(lib.hlName(module, 'Fmt'), {
			fg = '#2E3440',
			bg = '#88C0D0',
			bold = true,
		}, {
			fg = '#E5E9F0',
			bg = '#4C566A',
		}),

		left = lib.mkHlStr('', lib.hlName(module, 'Left'), {
			fg = '#2E3440',
			bg = '#88C0D0',
		}, {
			fg = '#E5E9F0',
			bg = '#4C566A',
		}),

		right = lib.mkHlStr(lib.gui('', ' '), lib.hlName(module, 'Right'), {
			fg = '#88C0D0',
			bg = '#2E3440',
		}, {
			fg = '#4C566A',
			bg = '#2E3440',
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

	lib.updateCfg(cfg, args or {})

	return function()
		local left = lib.colorStr(cfg.left.str, cfg.left)
		local right = lib.colorStr(cfg.right.str, cfg.right)
		local modeCode = vim.api.nvim_get_mode().mode
		local mode = cfg.modes[modeCode] or modeCode

		return string.format('%s %s %s', left, lib.colorStr(mode, cfg.hl), right)
	end
end
