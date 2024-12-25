local M = {}

local function initArgs(args)
	args = args or {}

	args = {
		globalArgs = args.globalArgs or {},
		statusline = args.statusline or {},
		tabline = args.tabline or {},
	}

	args.statusline.enable = (args.statusline.enable == nil) and true or args.statusline.enable
	args.tabline.enable = (args.tabline.enable == nil) and true or args.tabline.enable

	local colors = args.globalArgs.colors or {}

	args.globalArgs.colors = {
		black = colors.black or "#2e3440",
		red = colors.red or "#bf616a",
		green = colors.green or "#a3be8c",
		yellow = colors.yellow or "#ebcb8b",
		blue = colors.blue or "#81a1c1",
		magenta = colors.magenta or "#b48ead",
		cyan = colors.cyan or "#88c0d0",
		white = colors.white or "#e5e9f0",
		brightblack = colors.brightblack or "#4c566a",
		brightred = colors.brightred or "#bf616a",
		brightgreen = colors.brightgreen or "#a3be8c",
		brightyellow = colors.brightyellow or "#ebcb8b",
		brightblue = colors.brightblue or "#81a1c1",
		brightmagenta = colors.brightmagenta or "#b48ead",
		brightcyan = colors.brightcyan or "#88c0d0",
		brightwhite = colors.brightwhite or "#8fbcbb",
	}

	args.statusline.leftModules = args.statusline.leftModules
		or {
			{ name = "branch" },
			--[=["mode",
		"branch",
		"filename",
		"diagnostics",
		]=]
		}

	args.statusline.rightModules = args.statusline.rightModules
		or {
			--[=[
		"encoding",
		"format",
		"type",
		"progress",
		"location",
		]=]
		}

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

local function initTabline(args)
	vim.opt_global.tabline = "wip"
end

function M.statusline()
	local results = {}
	local i = 1

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

function M.setup(args)
	args = initArgs(args)

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
