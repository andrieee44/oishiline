local M = {}

local function initArgs(userArgs)
	local args = vim.tbl_deep_extend("keep", userArgs or {}, {
		globalArgs = {
			default = {
				fg = "#e5e9f0",
				bg = "#2e3440",
				ctermfg = 7,
				ctermbg = 0,
			},

			colors = {
				black = "#2e3440",
				darkred = "#bf616a",
				darkgreen = "#a3be8c",
				darkyellow = "#ebcb8b",
				darkblue = "#81a1c1",
				darkmagenta = "#b48ead",
				darkcyan = "#88c0d0",
				lightgray = "#e5e9f0",
				darkgray = "#4c566a",
				red = "#bf616a",
				green = "#a3be8c",
				yellow = "#ebcb8b",
				blue = "#81a1c1",
				magenta = "#b48ead",
				cyan = "#88c0d0",
				white = "#8fbcbb",
			},
		},

		statusline = {
			enable = true,

			leftModules = {
				{ name = "mode" },
				{ name = "branch" },
				{ name = "filename" },
				{ name = "diagnostics" },
			},

			rightModules = {
				{ name = "encoding" },
				{ name = "format" },
				{ name = "type" },
				{ name = "progress" },
				{ name = "location" },
			},
		},

		tabline = {
			enable = true,
		},
	})

	vim.api.nvim_set_hl(0, "OishilineDefault", args.globalArgs.default)

	return args
end

local function initStatusline(args)
	local oishiline = vim.g.oishiline

	oishiline.statusline = {
		leftModules = {},
		rightModules = {},
	}

	for i, v in ipairs(args.statusline.leftModules) do
		oishiline.statusline.leftModules[i] = require(string.format("oishiline.modules.%s", v.name))
		oishiline.statusline.leftModules[i].init(args.globalArgs, v.args or {})
	end

	for i, v in ipairs(args.statusline.rightModules) do
		oishiline.statusline.rightModules[i] = require(string.format("oishiline.modules.%s", v.name))
		oishiline.statusline.rightModules[i].init(args.globalArgs, v.args or {})
	end

	vim.g.oishiline = oishiline
	vim.opt_global.statusline = "%{%v:lua.require('oishiline').statusline()%}"
end

local function initTabline(_)
	local oishiline = vim.g.oishiline

	vim.g.oishiline = oishiline
	vim.opt_global.tabline = "%!v:lua.require('oishiline').tabline()"
end

function M.statusline()
	local results = {}
	local i = 1

	results[i] = "%#OishilineDefault#"
	i = i + 1

	for _, v in ipairs(vim.g.oishiline.statusline.leftModules) do
		results[i] = v.run()
		i = i + 1
	end

	results[i] = "%=%("
	i = i + 1

	for _, v in ipairs(vim.g.oishiline.statusline.rightModules) do
		results[i] = v.run()
		i = i + 1
	end

	results[i] = "%)"

	return table.concat(results)
end

function M.tabline()
	return "wip"
end

function M.setup(userArgs)
	local args = initArgs(userArgs)

	vim.g.oishiline = {
		statusline = {},
		tabline = {},
	}

	if args.statusline.enable then
		initStatusline(args)
	end

	if args.tabline.enable then
		initTabline(args)
	end
end

return M
