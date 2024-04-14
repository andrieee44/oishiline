return function(args)
	local lib = require('modules.lib')
	local module = 'Diff'

	local cfg = {
		added = {
			fmt = lib.mkHl(lib.hlName(module, 'Added'), {
				fg = '#2E3440',
				bg = '#A3BE8C',
				bold = true,
			}, {
				fg = '#2E3440',
				bg = '#A3BE8C',
			}),

			left = lib.mkHlStr(lib.gui('', ' '), lib.hlName(module, 'AddedLeft'), {
				fg = 'none',
				bg = '#A3BE8C',
			}, {
				fg = 'none',
				bg = '#A3BE8C',
			}),
		},
	}

	lib.updateCfg(cfg, args or {})

	return function()
		local left = lib.colorStr(cfg.added.left.str, cfg.added.left)
		local added = lib.colorStr('+1', cfg.added.fmt)

		return string.format('%s %s', left, added)
	end
end
