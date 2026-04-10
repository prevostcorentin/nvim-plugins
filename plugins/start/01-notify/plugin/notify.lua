if not vim.fn.has("gui_running") then
    vim.o.termguicolors = true
end

vim.cmd("packadd nvim-notify")

local nvim_notify_present, notify = pcall(require, "notify")

if not nvim_notify_present then
    vim.notify("Can not initialize notify: nvim-notify is not installed", vim.log.levels.ERROR)
    return
end

notify.setup({
    background_colour = "NotifyBackground",
    fps = 30,
    icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = ""
    },
    level = 2,
    minimum_width = 50,
    render = "default",
    stages = "fade_in_slide_out",
    time_formats = {
        notification = "%T",
        notification_history = "%FT%T"
    },
    timeout = 5000,
    top_down = true
})

vim.notify = notify
