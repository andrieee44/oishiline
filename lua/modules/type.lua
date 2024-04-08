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
	vim.api.nvim_set_hl(0, 'OishilineTypeFmt', cfg.fmt.highlight)

	local data = {
		cfg = cfg,
		leftSep = lib.colorStr(cfg.sep.left.str, 'OishilineTypeLeftSep', cfg.sep.left.highlight),
		rightSep = lib.colorStr(cfg.sep.right.str, 'OishilineTypeRightSep', cfg.sep.right.highlight),

		run = function(data)
			local type = vim.bo.filetype
			local ok, devicons = pcall(require, 'nvim-web-devicons')

			if ok then
				local basename = string.gsub(vim.api.nvim_buf_get_name(0), '.*/', '')
				type = string.format('%s %s', devicons.get_icon(basename, type), type)
			end

			return string.format('%s%%#%s#%s%s', data.leftSep, 'OishilineTypeFmt', type, data.rightSep)
		end,
	}

	return type(cfg.init) == 'function' and cfg.init(data) or data
end
