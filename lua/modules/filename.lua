return function(colors)
	local lib = require('modules.lib')
	local module = 'Filename'

	local cfg = {
		fmt = lib.mkHlStr('%f%( %w%h%m%r%)', lib.hlName(module, 'Fmt'), {
			fg = colors.black,
			bg = colors.cyan,
			bold = true,
		}, {
			fg = colors.white,
			bg = colors.brightBlack,
		}),

		right = lib.mkHlStr(lib.gui('', ' '), lib.hlName(module, 'Right'), {
			fg = colors.cyan,
			bg = colors.black,
		}, {
			fg = colors.brightBlack,
			bg = colors.white,
		}),
	}

	return function()
		local fmt = lib.colorStr(cfg.fmt.str, cfg.fmt)
		local right = lib.colorStr(cfg.right.str, cfg.right)

		return string.format(' %s %s', fmt, right)
	end
end
