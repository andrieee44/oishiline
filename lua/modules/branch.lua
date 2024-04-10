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
	vim.api.nvim_set_hl(0, 'OishilineBranchFmt', cfg.fmt.highlight)

	local data = {
		cfg = cfg,
		leftSep = lib.colorStr(cfg.sep.left.str, 'OishilineBranchLeftSep', cfg.sep.left.highlight),
		rightSep = lib.colorStr(cfg.sep.right.str, 'OishilineBranchRightSep', cfg.sep.right.highlight),

		run = function(data)
			local stdout = io.popen('git branch --show-current 2> /dev/null')

			if stdout == nil then
				return
			end

			return string.format('%s%%#%s#%s%s', data.leftSep, 'OishilineBranchFmt', stdout.read(stdout), data.rightSep)
		end,
	}

	return type(cfg.init) == 'function' and cfg.init(data) or data
end
