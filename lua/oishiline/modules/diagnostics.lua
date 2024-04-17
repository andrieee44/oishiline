return function(colors)
	local lib = require('oishiline.modules.lib')
	local module = 'Diagnostics'
	local severity = vim.diagnostic.severity
	local signs = {}

	local signNames = {
		[severity.ERROR] = 'Error',
		[severity.WARN] = 'Warn',
		[severity.INFO] = 'Info',
		[severity.HINT] = 'Hint',
	}

	for k, v in pairs(signNames) do
		local sign = vim.fn.sign_getdefined(string.format('DiagnosticSign%s', v))
		signs[k] = sign[1] and sign[1].text or ''
	end

	local severityBg = {
		[severity.ERROR] = {
			bg = colors.red,
			ctermbg = 'red',
		},

		[severity.WARN] = {
			bg = colors.yellow,
			ctermbg = 'yellow',
		},

		[severity.INFO] = {
			bg = colors.blue,
			ctermbg = 'blue',
		},

		[severity.HINT] = {
			bg = colors.cyan,
			ctermbg = 'cyan',
		},
	}

	return function()
		local diagnostics = vim.diagnostic.get(0)
		local results = {}
		local j, last = 1, 0
		local init = false

		local count = {
			[severity.ERROR] = 0,
			[severity.WARN] = 0,
			[severity.INFO] = 0,
			[severity.HINT] = 0,
		}

		if #diagnostics == 0 then
			return ''
		end

		for _, v in pairs(diagnostics) do
			count[v.severity] = count[v.severity] + 1
		end

		for i, v in ipairs(count) do
			if v == 0 then
				goto CONTINUE
			end

			if init then
				local sep = lib.mkHlStr(lib.gui('', ''), lib.hlName(module, string.format('%sSep', signNames[i])), {
					fg = severityBg[last].bg,
					ctermfg = severityBg[last].ctermbg,
					bg = severityBg[i].bg,
					ctermbg = severityBg[i].ctermbg,
				})

				results[j] = lib.colorStr(sep.str, sep)
				j = j + 1
			end

			if not init then
				local initHl = lib.mkHlStr(lib.gui('', ''), lib.hlName(module, 'Init'), {
					fg = colors.black,
					ctermfg = 'black',
					bg = severityBg[i].bg,
					ctermbg = severityBg[i].ctermbg,
				})

				results[j] = lib.colorStr(initHl.str, initHl)
				j = j + 1
				init = true
			end

			local sign = lib.mkHlStr(string.format(' %s%d ', signs[i], v), lib.hlName(module, signNames[i]), {
				fg = colors.black,
				ctermfg = 'black',
				bg = severityBg[i].bg,
				ctermbg = severityBg[i].ctermbg,
				bold = true,
			})

			results[j] = lib.colorStr(sign.str, sign)
			j = j + 1
			last = i

			::CONTINUE::
		end

		local lastHl = lib.mkHlStr(lib.gui('', ''), lib.hlName(module, 'Last'), {
			fg = severityBg[last].bg,
			ctermfg = severityBg[last].ctermbg,
			bg = colors.black,
			ctermbg = 'black',
		})

		results[j] = lib.colorStr(lastHl.str, lastHl)

		return table.concat(results)
	end
end
