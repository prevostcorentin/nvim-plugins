-- If Neovide is attaching to an existing Neovim instance,
-- init_neovide() will be invoked via the RPC channel *before* Neovide fully launches.
function _G.init_neovide()
    -- Only applies if neovide is started as a standalone executable
    if not vim.fn.has("neovide") then
        vim.notify("Can not initialize NeoVide: NeoVide is not launched",
            vim.log.levels.WARN)
        return
    end

    if vim.o.background == 'dark' then
        vim.g.neovide_text_gamma = 1
        vim.g.neovide_text_contrast = 1
    else
        vim.g.neovide_text_gamma = 0.8
        vim.g.neovide_text_contrast = 0.1
    end

    if vim.g.neovide_initialized then
        vim.notify("Can not initialize NeoVide: NeoVide is already initialized",
            vim.log.levels.WARN)
        return
    end

    vim.g.neovide_initialized = true
    vim.g.neovide_floating_shadow = true
    vim.g.neovide_floating_z_height = 10
    vim.g.neovide_light_angle_degrees = 45
    vim.g.neovide_light_radius = 5
    vim.g.neovide_floating_corner_radius = 0.3
    vim.g.neovide_scroll_animation_length = 0.3
    -- Hide mouse only when not using Windows
    vim.g.neovide_hide_mouse_when_typing = not vim.fn.has("win32")
    vim.g.neovide_confirm_quit = true
    vim.g.neovide_detach_on_quit = "always_detach"
    vim.g.neovide_fullscreen = false
    vim.g.neovide_cursor_hack = true
    vim.g.neovide_cursor_animation_length = 0.34
    vim.g.neovide_cursor_short_animation_length = 0.03
    vim.g.neovide_cursor_trail_size = 0.7
    vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_cursor_animate_in_insert_mode = true
    vim.g.neovide_cursor_animate_command_line = false
    vim.g.neovide_cursor_unfocused_outline_width = 0.125
    vim.g.neovide_cursor_smooth_blink = false
    vim.g.neovide_cursor_vfx_mode = { "railgun", "sonicboom" }
    vim.g.neovide_cursor_vfx_opacity = 50.0
    vim.g.neovide_cursor_vfx_particle_highlight_lifetime = 0.5
    vim.g.neovide_cursor_vfx_particle_lifetime = 1
    vim.g.neovide_cursor_vfx_particle_density = 0.7
    vim.g.neovide_cursor_vfx_particle_speed = 5.0

    vim.notify("Neovide plugin initialized ...")
end

_G.init_neovide()

function _G.switch_background_color()
    if vim.o.background == "light" then
        vim.o.background = "dark"
        vim.g.neovide_theme = "dark"
        vim.notify("Dark color scheme", vim.log.levels.INFO)
    elseif vim.o.background == "dark" then
        vim.o.background = "light"
        vim.g.neovide_theme = "light"
        vim.notify("Light color scheme", vim.log.levels.INFO)
    end
    vim.api.nvim_command("set bg=" .. vim.o.background)
    init_neovide()
end

local neovide_leader = "<leader>n"
vim.api.nvim_create_user_command("SwitchBackgroundColor", _G.switch_background_color, {})
vim.api.nvim_set_keymap('n', neovide_leader .. 'bc', ':SwitchBackgroundColor<lf>', {})
vim.api.nvim_set_keymap('n', neovide_leader .. 'd', ':detach<lf>', {})
