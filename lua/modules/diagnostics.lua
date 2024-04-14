return function(args)
	local lib = require('modules.lib')
	local module = 'Diagnostic'
	local severity = vim.diagnostic.severity
	local reverse = {}

	local cfg = {
		[severity.ERROR] = lib.mkHl(lib.hlName(module, 'Error'), {
			fg = '#2E3440',
			bg = '#BF616A',
			bold = true,
		}, {
			fg = '#2E3440',
			bg = '#BF616A',
			bold = true,
		}),

		[severity.WARN] = lib.mkHl(lib.hlName(module, 'Warn'), {
			fg = '#2E3440',
			bg = '#EBCB8B',
			bold = true,
		}, {
			fg = '#2E3440',
			bg = '#EBCB8B',
			bold = true,
		}),

		[severity.INFO] = lib.mkHl(lib.hlName(module, 'Info'), {
			fg = '#2E3440',
			bg = '#88C0D0',
			bold = true,
		}, {
			fg = '#2E3440',
			bg = '#88C0D0',
			bold = true,
		}),

		[severity.HINT] = lib.mkHl(lib.hlName(module, 'Hint'), {
			fg = '#2E3440',
			bg = '#B48EAD',
			bold = true,
		}, {
			fg = '#2E3440',
			bg = '#B48EAD',
			bold = true,
		}),
	}

	lib.updateCfg(cfg, args or {})

	for i, v in ipairs(cfg) do
		reverse[i] = {
			hl = lib.mkHl(string.format('%s%s', v.hl, 'Reverse'), {
				link = v.hl,
				reverse = true,
			}, {
				link = v.hl,
				reverse = true,
			}),

			alt = lib.mkHl(string.format('%s%s', v.alt, 'Reverse'), {
				link = v.alt,
				reverse = true,
			}, {
				link = v.alt,
				reverse = true,
			}),
		}
	end

	return function()
		local count = {
			[severity.ERROR] = 0,
			[severity.WARN] = 0,
			[severity.INFO] = 0,
			[severity.HINT] = 0,
		}

		local results = {}
		local first = true

		for _, v in pairs(vim.diagnostic.get(0)) do
			count[v.severity] = count[v.severity] + 1
		end

		for i, v in ipairs(count) do
			if first then
				table.insert(results, string.format('%s', lib.colorStr(lib.gui('', ' '), cfg[i])))
				first = false
			end

			table.insert(results, string.format('%s', lib.colorStr(tostring(v), cfg[i])))
			table.insert(results, string.format('%s', lib.colorStr(lib.gui('', ' '), reverse[i])))
		end

		return table.concat(results)
	end
end
