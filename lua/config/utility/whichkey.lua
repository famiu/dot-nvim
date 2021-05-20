local g = vim.g

require("which-key").setup {
    plugins = {
        -- shows a list of your marks on ' and `
        marks = true,
        -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        registers = true,

        spelling = {
            -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            enabled = true,
            -- how many suggestions should be shown in the list?
            suggestions = 20,
        },

        presets = {
            -- adds help for operators like d, y, ... and registers them for motion / text object completion
            operators = true,
            -- adds help for motions
            motions = true,
            -- help for text objects triggered after entering an operator
            text_objects = true,
            -- default bindings on <c-w>
            windows = true,
            -- misc bindings to work with windows
            nav = true,
            -- bindings for folds, spelling and others prefixed with z
            z = true,
            -- bindings for prefixed with g
            g = true,
        },
    },

    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    operators = { gc = "Comments" },

    key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        ["<space>"] = "SPC",
        ["<cr>"] = "RET",
        ["<tab>"] = "TAB",
    },

    icons = {
        -- symbol used in the command line area that shows your active key combo
        breadcrumb = "»",
        -- symbol used between a key and it's label
        separator = "➜",
        -- symbol prepended to a group
        group = "+",
    },
    window = {
        -- none, single, double, shadow
        border = "single",
        -- bottom, top
        position = "bottom",
        -- extra window margin [top, right, bottom, left]
        margin = { 1, 0, 1, 0 },
        -- extra window padding [top, right, bottom, left]
        padding = { 2, 2, 2, 2 },
    },

    layout = {
        -- min and max height of the columns
        height = { min = 4, max = 25 },

        -- min and max width of the columns
        width = { min = 20, max = 50 },

        -- spacing between columns
        spacing = 5,
    },

    -- enable this to hide mappings for which you didn't specify a label
    ignore_missing = true,

    -- hide mapping boilerplate
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "},

    -- show help message on the command line when the popup is visible
    show_help = true,

    -- automatically setup triggers
    triggers = "auto",

    -- or specify a list manually
    -- triggers = {"<leader>"}

    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
    },
}
