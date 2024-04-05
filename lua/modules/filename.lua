local lib = require('modules.lib')

return function(args)
	local cfg = {
		fmt = {
			str = '%f%w%h%m%r',

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

		customInit = function(data)
			return data
		end,
	}

	lib.updateTable(cfg, args or {})

	local data = {
		leftSep = lib.colorStr(cfg.sep.left.str, 'OishilineFilenameLeftSep', cfg.sep.left.highlight),
		fmt = lib.colorStr(cfg.fmt.str, 'OishilineFilenameFmt', cfg.fmt.highlight),
		rightSep = lib.colorStr(cfg.sep.right.str, 'OishilineFilenameRightSep', cfg.sep.right.highlight),

		run = function(data)
			return string.format('%s%s%s', data.leftSep, data.fmt, data.rightSep)
		end
	}

	return cfg.customInit(data)
end
