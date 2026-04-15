---@diagnostic disable: undefined-global
local M = {}

local state_dir = vim.fn.stdpath("state") .. "/sessions"

local function ensure_state_dir()
	if vim.fn.isdirectory(state_dir) == 0 then
		vim.fn.mkdir(state_dir, "p")
	end
end

local function get_session_file()
	local cwd = vim.fn.getcwd()
	-- sanitize path to a safe filename
	local cwd_session = cwd:gsub("[/:\\]", "_")
	return state_dir .. "/" .. cwd_session .. ".vim"
end

function M.store_session_and_exit()
	ensure_state_dir()
	vim.cmd("mksession! " .. get_session_file())
	vim.cmd("qa")
end

function M.store_session_and_restart()
	ensure_state_dir()
	vim.cmd("mksession! " .. get_session_file())
	vim.cmd("restart")
end

function M.store_session()
	ensure_state_dir()
	vim.cmd("mksession! " .. get_session_file())
	vim.notify("Session saved", vim.log.levels.INFO)
end

-- NOTE: never used it actually. and i think it can be replaced
-- by store_session_and_restart
-- 	local session_file = get_session_file()
--
-- 	if vim.loop.fs_stat(session_file) then
-- 		-- wipe all listed buffers to avoid layout conflicts
-- 		vim.cmd("silent! %bwipeout!")
--
-- 		vim.cmd("silent! source " .. vim.fn.fnameescape(session_file))
-- 		vim.notify("Session restored.", vim.log.levels.INFO)
-- 	else
-- 		vim.notify("No session found.", vim.log.levels.INFO)
-- 	end
-- end

function M.try_restore()
	local session_file = get_session_file()
	local stat = vim.loop.fs_stat(session_file)
	if stat then
		vim.cmd("source " .. session_file)
		vim.notify("Session restored.", vim.log.levels.INFO)
	end
end

vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("RestoreSession", { clear = true }),
	callback = function()
		if vim.fn.argc() == 0 then -- only restore if no files were opened
			vim.schedule(function()
				M.try_restore()
			end)
		end
	end,
})

function M.delete_session()
	local session_file = get_session_file()
	local stat = vim.loop.fs_stat(session_file)
	if stat then
		os.remove(session_file)
		vim.notify("Session deleted", vim.log.levels.WARN)
	else
		vim.notify("No session to delete", vim.log.levels.INFO)
	end
end

return M
