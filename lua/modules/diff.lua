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
	vim.api.nvim_set_hl(0, 'OishilineDiffFmt', cfg.fmt.highlight)

	local data = {
		cfg = cfg,
		leftSep = lib.colorStr(cfg.sep.left.str, 'OishilineDiffLeftSep', cfg.sep.left.highlight),
		rightSep = lib.colorStr(cfg.sep.right.str, 'OishilineDiffRightSep', cfg.sep.right.highlight),

		run = function(data)
			local cmd = string.format('git diff --numstat -- \'%s\' 2> /dev/null', vim.api.nvim_buf_get_name(0))
			local stdout = io.popen(cmd)

			if stdout == nil then
				return
			end

			local numstat = stdout.read(stdout, 'a')
			local added = string.match(numstat, '^%d+')
			local modified = string.match(numstat, '^%d+%s+(%d+)')

			return string.format('%s%%#%s#%s%s', data.leftSep, 'OishilineDiffFmt', string.format('%s %s', added, modified), data.rightSep)
		end,
	}

	return type(cfg.init) == 'function' and cfg.init(data) or data
end
