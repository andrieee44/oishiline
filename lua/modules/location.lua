return function(args)
	local lib = require('modules.lib')

	local cfg = {
		fmt = {
			str = '%3l:%-2c',

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

	local data = {
		cfg = cfg,
		leftSep = lib.colorStr(cfg.sep.left.str, 'OishilineLocationLeftSep', cfg.sep.left.highlight),
		fmt = lib.colorStr(cfg.fmt.str, 'OishilineLocationFmt', cfg.fmt.highlight),
		rightSep = lib.colorStr(cfg.sep.right.str, 'OishilineLocationRightSep', cfg.sep.right.highlight),

		run = function(data)
			return string.format('%s%s%s', data.leftSep, data.fmt, data.rightSep)
		end,
	}

	return type(cfg.init) == 'function' and cfg.init(data) or data
end
