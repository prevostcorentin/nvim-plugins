function _G.LoadDAP()
    vim.cmd("packadd nvim-dap")

    local is_dap_present, dap = pcall(require, "dap")
    if not is_dap_present then
        vim.notify("Failed to load nvim-dap", vim.log.levels.ERROR)
        return
    end

    for _, language in ipairs({ "golang" }) do
        local config_present, configure_dap = pcall(require, "debugger." .. language)
        if config_present and type(configure_dap) == "function" then
            configure_dap(dap)
        else
            vim.notify("Failed to load '" .. language .. "' DAP configuration")
        end
    end

    vim.notify("nvim-dap is lit 🔥", vim.log.levels.INFO)
end

function _G.ShowScopesSidebar()
    local widgets = require('dap.ui.widgets')
    local my_sidebar = widgets.sidebar(widgets.scopes)
    my_sidebar.open()
end

function _G.ShowFramesFloatingWindow()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
end

vim.api.nvim_create_user_command("LoadDAP", LoadDAP, {})
vim.api.nvim_create_user_command("DapShowScopesFloatingWindow", ShowFramesFloatingWindow, {})
vim.api.nvim_create_user_command("DapShowFramesSidebar", ShowScopesSidebar, {})
