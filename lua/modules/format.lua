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
	vim.api.nvim_set_hl(0, 'OishilineFormatFmt', cfg.fmt.highlight)

	local data = {
		cfg = cfg,
		leftSep = lib.colorStr(cfg.sep.left.str, 'OishilineFormatLeftSep', cfg.sep.left.highlight),
		rightSep = lib.colorStr(cfg.sep.right.str, 'OishilineFormatRightSep', cfg.sep.right.highlight),

		icons = {
			unix = vim.opt.termguicolors and '' or 'unix',
			dos = vim.opt.termguicolors and '' or 'dos',
			mac = vim.opt.termguicolors and '' or 'mac',
		},

		run = function(data)
			local icon = data.icons[vim.bo.fileformat]
			return string.format('%s%%#%s#%s%s', data.leftSep, 'OishilineFormatFmt', icon, data.rightSep)
		end,
	}

	return type(cfg.init) == 'function' and cfg.init(data) or data
end
