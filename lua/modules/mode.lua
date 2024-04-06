return function(args)
	local lib = require('modules.lib')

	local cfg = {
		fmt = {
			highlight = {
				fg = 'yellow',
				bg = 'black',
			},
		},

		sep = {
			left = {
				str = '<',

				highlight = {
					fg = 'red',
					bg = 'black',
				},
			},

			right = {
				str = '>',

				highlight = {
					fg = 'cyan',
					bg = 'black',
				},
			},
		},
	}

	lib.updateCfg(cfg, args or {})
	vim.api.nvim_set_hl(0, 'OishilineModeFmt', cfg.fmt.highlight)

	local data = {
		cfg = cfg,
		leftSep = lib.colorStr(cfg.sep.left.str, 'OishilineModeLeftSep', cfg.sep.left.highlight),
		rightSep = lib.colorStr(cfg.sep.right.str, 'OishilineModeRightSep', cfg.sep.right.highlight),

		modes = {
			['n']     = 'NORMAL',
			['no']    = 'O-PENDING',
			['nov']   = 'O-PENDING',
			['noV']   = 'O-PENDING',
			['no\22'] = 'O-PENDING',
			['niI']   = 'NORMAL',
			['niR']   = 'NORMAL',
			['niV']   = 'NORMAL',
			['nt']    = 'NORMAL',
			['ntT']   = 'NORMAL',
			['v']     = 'VISUAL',
			['vs']    = 'VISUAL',
			['V']     = 'V-LINE',
			['Vs']    = 'V-LINE',
			['\22']   = 'V-BLOCK',
			['\22s']  = 'V-BLOCK',
			['s']     = 'SELECT',
			['S']     = 'S-LINE',
			['\19']   = 'S-BLOCK',
			['i']     = 'INSERT',
			['ic']    = 'INSERT',
			['ix']    = 'INSERT',
			['R']     = 'REPLACE',
			['Rc']    = 'REPLACE',
			['Rx']    = 'REPLACE',
			['Rv']    = 'V-REPLACE',
			['Rvc']   = 'V-REPLACE',
			['Rvx']   = 'V-REPLACE',
			['c']     = 'COMMAND',
			['cv']    = 'EX',
			['ce']    = 'EX',
			['r']     = 'REPLACE',
			['rm']    = 'MORE',
			['r?']    = 'CONFIRM',
			['!']     = 'SHELL',
			['t']     = 'TERMINAL',
		},

		run = function(data)
			local mode = data.modes[vim.api.nvim_get_mode().mode]
			return string.format('%s%%#%s#%s%s', data.leftSep, 'OishilineModeFmt', mode, data.rightSep)
		end,
	}

	return type(cfg.init) == 'function' and cfg.init(data) or data
end
