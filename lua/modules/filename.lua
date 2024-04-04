local lib = require('modules.lib')

return {
	init = function(self, args)
		local cfg = {
			fmt = {
				text = '%f%w%h%m%r',

				highlight = {
					fg = 'yellow',
					bg = 'black',
				},
			},

			sep = {
				left = {
					text = '<',

					highlight = {
						fg = 'red',
						bg = 'black',
					},
				},

				right = {
					text = '>',

					highlight = {
						fg = 'cyan',
						bg = 'black',
					},
				},
			}
		}

		lib.updateTable(cfg, args or {})
		self.leftSep = lib.colorText(cfg.sep.left.text, 'OishilineFilenameLeftSep', cfg.sep.left.highlight)
		self.fmt = lib.colorText(cfg.fmt.text, 'OishilineFilenameFmt', cfg.fmt.highlight)
		self.rightSep = lib.colorText(cfg.sep.right.text, 'OishilineFilenameRightSep', cfg.sep.right.highlight)
	end,

	run = function(self)
		return string.format('%s%s%s', self.leftSep, self.fmt, self.rightSep)
	end,
}
