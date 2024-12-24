local M = {}

function initStatusline(args)
	local oishiline = vim.g.oishiline
	args.globalArgs = args.globalArgs or {}
	local colors = args.globalArgs.colors or {}

	oishiline.statusline = {
		leftModules = {},
		rightModules = {},
	}

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

	args.leftModules = args.leftModules
		or {
			{ name = "branch" },
			--[=["mode",
		"branch",
		"filename",
		"diagnostics",
		]=]
		}

	args.rightModules = args.rightModules
		or {
			--[=[
		"encoding",
		"format",
		"type",
		"progress",
		"location",
		]=]
		}

	for i, v in ipairs(args.leftModules) do
		oishiline.statusline.leftModules[i] = require(string.format("oishiline.modules.%s", v.name))
		oishiline.statusline.leftModules[i].init(args.globalArgs, v.args or {})
	end

	for i, v in ipairs(args.rightModules) do
		oishiline.statusline.rightModules[i] = require(string.format("oishiline.modules.%s", v.name))
		oishiline.statusline.rightModules[i].init(args.globalArgs, v.args or {})
	end

	vim.g.oishiline = oishiline
	vim.opt_global.statusline = "%{%v:lua.require('oishiline').statusline()%}"
end

function initTabline(args)
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
	args = args or {}
	args.statusline = args.statusline or {}
	args.tabline = args.tabline or {}

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
