return function(args)
	local lib = require('modules.lib')
	local module = 'Diagnostic'
	local severity = vim.diagnostic.severity

	local cfg = {
		[severity.ERROR] = lib.mkHl(lib.hlName(module, 'Error'), {
			fg = '#2E3440',
			bg = '#88C0D0',
			bold = true,
		}, {
			fg = '#E5E9F0',
			bg = '#4C566A',
		}),

		[severity.WARN] = lib.mkHl(lib.hlName(module, 'Error'), {
			fg = '#2E3440',
			bg = '#88C0D0',
			bold = true,
		}, {
			fg = '#E5E9F0',
			bg = '#4C566A',
		}),

		[severity.INFO] = lib.mkHl(lib.hlName(module, 'Error'), {
			fg = '#2E3440',
			bg = '#88C0D0',
			bold = true,
		}, {
			fg = '#E5E9F0',
			bg = '#4C566A',
		}),

		[severity.HINT] = lib.mkHl(lib.hlName(module, 'Error'), {
			fg = '#2E3440',
			bg = '#88C0D0',
			bold = true,
		}, {
			fg = '#E5E9F0',
			bg = '#4C566A',
		}),

		sep = lib.mkHlStr(lib.gui('', ' '), lib.hlName(module, 'Sep'), { fg = '#88C0D0' }, { fg = '#4C566A' }),
	}

	lib.updateCfg(cfg, args or {})

	return function()
		local sep = lib.colorStr(cfg.sep.str, cfg.sep)
		local count = {}

		for _, v in pairs(vim.diagnostic.get(0)) do
			count[v.severity] = count[v.severity] + 1
		end

		return sep
	end
end
