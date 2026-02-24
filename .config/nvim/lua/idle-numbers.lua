local M = {}

M.enabled = true
M.idle_ms = 1250
M.timer = vim.loop.new_timer()

local default_relativenumber = vim.opt.relativenumber
local default_number = vim.opt.number

local function show_relative()
	vim.opt.relativenumber = true
end
local function show_absolute()
	vim.opt.relativenumber = false
end

local function start_timer()
	M.timer:stop()
	M.timer:start(
		M.idle_ms,
		0,
		vim.schedule_wrap(function()
			if M.enabled then
				show_absolute()
			end
		end)
	)
end

local function reset_timer()
	if not M.enabled then
		return
	end
	show_relative()
	start_timer()
end

function M.toggle()
	M.enabled = not M.enabled
	if M.enabled then
		show_relative()
		start_timer()
		print("IdleNumbers enabled")
	else
		show_absolute()
		M.timer:stop()
		vim.opt.relativenumber = default_relativenumber
		vim.opt.number = default_number
		print("IdleNumbers disabled")
	end
end

function M.setup(opts)
	opts = opts or {}
	if opts.idle_ms then
		M.idle_ms = opts.idle_ms
	end

	vim.opt.number = true
	vim.opt.relativenumber = true

	vim.api.nvim_create_user_command("IdleNumbersToggle", M.toggle, {})

	-- Reset timer on normal activity
	vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "InsertEnter", "InsertLeave" }, {
		group = vim.api.nvim_create_augroup("IdleNumbersTimer", { clear = true }),
		callback = reset_timer,
	})

	start_timer()
end

-- vim.api.nvim_create_autocmd("InsertEnter", {
-- 	callback = function()
-- 		vim.opt.relativenumber = false
-- 	end,
-- })
--
-- vim.api.nvim_create_autocmd("InsertLeave", {
-- 	callback = function()
-- 		vim.opt.relativenumber = true
-- 	end,
-- })
return M
