return function(args)
	local lib = require('modules.lib')

	local cfg = {
		fmt = {
			icon = {
				highlight = {
					fg = 'cyan',
					bg = 'black',
				},
			},

			text = {
				highlight = {
					fg = 'yellow',
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
	vim.api.nvim_set_hl(0, 'OishilineTypeFmtIcon', cfg.fmt.icon.highlight)
	vim.api.nvim_set_hl(0, 'OishilineTypeFmtText', cfg.fmt.text.highlight)

	local data = {
		cfg = cfg,
		leftSep = lib.colorStr(cfg.sep.left.str, 'OishilineTypeLeftSep', cfg.sep.left.highlight),
		rightSep = lib.colorStr(cfg.sep.right.str, 'OishilineTypeRightSep', cfg.sep.right.highlight),

		run = function(data)
			local type = vim.bo.filetype

			if package.loaded['nvim-web-devicons'] then
				local basename = string.gsub(vim.api.nvim_buf_get_name(0), '.*/', '')
				local icon = require('nvim-web-devicons').get_icon(basename, type)

				if icon ~= nil then
					type = string.format('%%#%s#%s %%#%s#%s', 'OishilineTypeFmtIcon', icon, 'OishilineTypeFmtText', type)
				end
			end

			return string.format('%s%%#%s#%s%s', data.leftSep, 'OishilineTypeFmt', type, data.rightSep)
		end,
	}

	return type(cfg.init) == 'function' and cfg.init(data) or data
end
