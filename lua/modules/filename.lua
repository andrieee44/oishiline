return function(args)
	local lib = require('modules.lib')
	local module = 'Filename'

	local cfg = {
		fmt = lib.mkHlStr('%f%( %w%h%m%r%)', lib.hlName(module, 'Fmt'), {
			fg = '#2E3440',
			bg = '#88C0D0',
			bold = true,
		}, {
			fg = '#E5E9F0',
			bg = '#4C566A',
		}),

		left = lib.mkHlStr('', lib.hlName(module, 'Left'), {
			fg = '#2E3440',
			bg = '#88C0D0',
		}, {
			fg = '#E5E9F0',
			bg = '#4C566A',
		}),

		right = lib.mkHlStr('', lib.hlName(module, 'Right'), {
			fg = '#88C0D0',
			bg = '#2E3440',
		}, {
			fg = '#4C566A',
			bg = '#2E3440',
		}),
	}

	lib.updateCfg(cfg, args or {})

	return function()
		local left = lib.colorStr(cfg.left.str, cfg.left)
		local fmt = lib.colorStr(cfg.fmt.str, cfg.fmt)
		local right = lib.colorStr(cfg.right.str, cfg.right)

		return string.format('%s %s %s', left, fmt, right)
	end
end
