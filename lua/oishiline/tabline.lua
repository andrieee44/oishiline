local lib = require("oishiline.modules.lib")
local M = {}

function M.init(globalArgs, moduleArgs) end

function M.run()
	local currentTab = vim.fn.tabpagenr()
	local results = {}
	local j = 1

	for i = 1, vim.fn.tabpagenr("$") do
		local basename =
			string.gsub(vim.api.nvim_buf_get_name(vim.fn.tabpagebuflist(i)[vim.fn.tabpagewinnr(i)]), ".*/", "")

		results[j] = basename == "" and "[No Name]" or basename
		j = j + 1
	end

	return table.concat(results)
end

return M
