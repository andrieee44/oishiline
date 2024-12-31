local sep, default, severityBg
local M, oldCount = {}, {}
local oldOutput = ""
local lib = require("oishiline.modules.lib")
local severity = vim.diagnostic.severity

local signNames = {
	[severity.ERROR] = "Error",
	[severity.WARN] = "Warn",
	[severity.INFO] = "Info",
	[severity.HINT] = "Hint",
}

local signs = {
	[severity.ERROR] = {
		gui = "  ",
		tty = " ! ",
	},

	[severity.WARN] = {
		gui = "  ",
		tty = " ? ",
	},

	[severity.INFO] = {
		gui = "  ",
		tty = " * ",
	},

	[severity.HINT] = {
		gui = "  ",
		tty = " i ",
	},
}

local function eqTbl(a, b)
	if #a ~= #b then
		return false
	end

	for i in pairs(a) do
		if a[i] ~= b[i] then
			return false
		end
	end

	return true
end

local function shallowCopy(a)
	local b = {}

	for i in pairs(a) do
		b[i] = a[i]
	end

	return b
end

function M.init(globalArgs, moduleArgs)
	local colors = globalArgs.colors

	default = globalArgs.default

	severityBg = {
		[severity.ERROR] = {
			bg = colors.darkred,
			ctermbg = "darkred",
		},

		[severity.WARN] = {
			bg = colors.darkyellow,
			ctermbg = "darkyellow",
		},

		[severity.INFO] = {
			bg = colors.darkblue,
			ctermbg = "darkblue",
		},

		[severity.HINT] = {
			bg = colors.darkcyan,
			ctermbg = "darkcyan",
		},
	}

	sep = lib.gui(vim.tbl_deep_extend("keep", moduleArgs.sep or {}, {
		gui = "",
		tty = "",
	}))

	for k, v in pairs(signNames) do
		signs[k] = lib.gui(vim.tbl_deep_extend("keep", moduleArgs[v] or {}, signs[k]))
		severityBg[k] = vim.tbl_deep_extend("keep", moduleArgs[string.format("%sBg", v)] or {}, severityBg[k])
	end
end

function M.run()
	local hl
	local diagnostics = vim.diagnostic.get(0)
	local j, last = 1, 0
	local first = true

	local count = {
		[severity.ERROR] = 0,
		[severity.WARN] = 0,
		[severity.INFO] = 0,
		[severity.HINT] = 0,
	}

	for _, v in pairs(diagnostics) do
		count[v.severity] = count[v.severity] + 1
	end

	if eqTbl(count, oldCount) then
		return oldOutput
	end

	results = {}

	for i, v in ipairs(count) do
		if v == 0 then
			goto continue
		end

		hl = first
				and lib.mkHl("OishilineStatuslineDiagnosticsFirst", {
					fg = default.bg,
					bg = severityBg[i].bg,
					ctermfg = default.ctermbg,
					ctermbg = severityBg[i].ctermbg,
				})
			or lib.mkHl(string.format("OishilineStatuslineDiagnostic%sSep", signNames[i]), {
				fg = severityBg[last].bg,
				bg = severityBg[i].bg,
				ctermfg = severityBg[last].ctermbg,
				ctermbg = severityBg[i].ctermbg,
			})

		if first then
			first = false
		end

		results[j] = lib.colorStr(sep, hl)
		j = j + 1

		hl = lib.mkHl(string.format("OishilineStatuslineDiagnostic%s", signNames[i]), {
			fg = default.bg,
			bg = severityBg[i].bg,
			ctermfg = default.ctermbg,
			ctermbg = severityBg[i].ctermbg,
			bold = true,
		})

		results[j] = lib.colorStr(string.format("%s%d ", signs[i], v), hl)
		j = j + 1
		last = i

		::continue::
	end

	local lastHl = lib.mkHl("OishilineStatuslineDiagnosticLast", {
		fg = severityBg[last].bg,
		ctermfg = severityBg[last].ctermbg,
		bg = default.bg,
		ctermbg = default.ctermbg,
	})

	results[j] = lib.colorStr(sep, lastHl)
	oldCount = shallowCopy(count)
	oldOutput = table.concat(results)

	return oldOutput
end

return M
