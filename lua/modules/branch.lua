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
			local path = string.match(vim.api.nvim_buf_get_name(0), '.*/')
			local cmd = string.format('git -C \'%s\' branch --show-current 2> /dev/null', path)
			local stdout = io.popen(cmd)

			if stdout == nil then
				return ''
			end

			local branch = stdout.read(stdout)

			if branch == nil then
				return ''
			end

			return string.format('%s%%#%s#%s%s', data.leftSep, 'OishilineBranchFmt', branch, data.rightSep)
		end,
	}

	return type(cfg.init) == 'function' and cfg.init(data) or data
end