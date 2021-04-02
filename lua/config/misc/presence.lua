require("presence"):setup({
    -- This config table shows all available config options with their default values
    auto_update       = true,                       -- Update activity based on autocmd events (if `false`, map or manually execute `:lua Presence:update()`)
    editing_text      = "Editing %s",               -- Editing format string (either string or function(filename: string|nil, buffer: string): string)
    workspace_text    = "Working on %s",            -- Workspace format string (either string or function(git_project_name: string|nil, buffer: string): string)
    neovim_image_text = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
    main_image        = "neovim",                   -- Main image display (either "neovim" or "file")
    client_id         = "793271441293967371",       -- Use your own Discord application client id (not recommended)
    log_level         = nil,                        -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
    debounce_timeout  = 15,                         -- Number of seconds to debounce TextChanged events (or calls to `:lua Presence:update(<buf>, true)`)
})
