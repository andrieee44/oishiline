local M = {}

M.default = "%#OishilineDefault#"

M.pad = {
	gui = " ",
	tty = " ",
}

M.empty = {
	gui = "",
	tty = "",
}

function M.run(cmd)
	local stdout = io.popen(cmd)

	if stdout == nil then
		return nil
	end

	return stdout.read(stdout)
end

function M.gui(icon)
	return vim.opt.termguicolors._value and icon.gui or icon.tty
end

function M.mkHl(name, args, altArgs)
	local alt = nil

	vim.api.nvim_set_hl(0, name, args)

	if altArgs then
		alt = string.format("%s%s", name, "Alt")
		vim.api.nvim_set_hl(0, alt, altArgs)
	end

	return {
		hl = name,
		alt = alt or name,
	}
end

function M.active(a, b)
	return tonumber(vim.g.actual_curwin) == vim.api.nvim_get_current_win() and a or b
end

function M.colorStr(str, hl)
	return string.format("%%#%s#%s", M.active(hl.hl, hl.alt), str)
end

function M.stdModule(moduleName, moduleArgs, defaultArgs)
	local args = vim.tbl_deep_extend("keep", moduleArgs, defaultArgs)

	return {
		leftSep = M.gui(args.leftSep),
		leftPad = M.gui(args.leftPad),
		icon = M.gui(args.icon),
		rightPad = M.gui(args.rightPad),
		rightSep = M.gui(args.rightSep),
		leftSepHl = M.mkHl(string.format("Oishiline%sLeftSep", moduleName), args.leftSepHl, args.leftSepHlAlt),
		iconHl = M.mkHl(string.format("Oishiline%sIcon", moduleName), args.iconHl, args.iconHlAlt),
		dataHl = M.mkHl(string.format("Oishiline%sData", moduleName), args.dataHl, args.dataHlAlt),
		rightSepHl = M.mkHl(string.format("Oishiline%sRightSep", moduleName), args.rightSepHl, args.rightSepHlAlt),
	}
end

function M.stdFormat(stdModule, data)
	return string.format(
		"%s%s%s%s%s",
		M.colorStr(stdModule.leftSep, stdModule.leftSepHl),
		M.colorStr(stdModule.icon, stdModule.iconHl),
		M.colorStr(string.format("%s%s%s", stdModule.leftPad, data, stdModule.rightPad), stdModule.dataHl),
		M.colorStr(stdModule.rightSep, stdModule.rightSepHl),
		M.default
	)
end

function M.insert(tbl, index, data)
	tbl[index] = data

	return index + 1
end

return M
