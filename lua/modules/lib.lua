return {
	updateTable = function(orig, new)
		for k, v in pairs(new) do
			orig[k] = v
		end
	end,

	colorText = function(text, name, value)
		vim.api.nvim_set_hl(0, name, value)
		return string.format('%%#%s#%s', name, text)
	end,
}
