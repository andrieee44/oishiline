return function(args)
	local lib = require('modules.lib')

	local cfg = {
		fmt = {
			added = {
				highlight = {
					fg = 'cyan',
					bg = 'black',
				},
			},

			deleted = {
				highlight = {
					fg = 'red',
					bg = 'black',
				},
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
	vim.api.nvim_set_hl(0, 'OishilineDiffFmtAdded', cfg.fmt.added.highlight)
	vim.api.nvim_set_hl(0, 'OishilineDiffFmtDeleted', cfg.fmt.deleted.highlight)

	local data = {
		cfg = cfg,
		leftSep = lib.colorStr(cfg.sep.left.str, 'OishilineDiffLeftSep', cfg.sep.left.highlight),
		rightSep = lib.colorStr(cfg.sep.right.str, 'OishilineDiffRightSep', cfg.sep.right.highlight),

		run = function(data)
			local path = string.match(vim.api.nvim_buf_get_name(0), '.*/')
			local filename = vim.api.nvim_buf_get_name(0)
			local cmd = string.format('git -C \'%s\' diff --numstat -- \'%s\' 2> /dev/null', path, filename)
			local stdout = io.popen(cmd)

			if stdout == nil then
				return ''
			end

			local numstat = stdout.read(stdout)

			if numstat == nil then
				return ''
			end

			local added = string.match(numstat, '^%d+')
			local deleted = string.match(numstat, '^%d+%s+(%d+)')
			local addedColor = string.format('%%#%s#%s', 'OishilineDiffFmtAdded', added ~= '0' and added or '')
			local deletedColor = string.format('%%#%s#%s', 'OishilineDiffFmtDeleted', deleted ~= '0' and deleted or '')

			return string.format('%s%s%s%s', data.leftSep, addedColor, deletedColor, data.rightSep)
		end,
	}

	return type(cfg.init) == 'function' and cfg.init(data) or data
end
