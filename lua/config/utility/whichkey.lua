local g = vim.g

require("whichkey_setup").config{
    hide_statusline = true,
    default_keymap_settings = {
        silent=true,
        noremap=true,
    },
}

g.which_key_position = 'botright'
g.which_key_sep = '→'
g.which_key_hspace = 5
g.which_key_max_size = 0
g.which_key_vertical = false
g.which_key_flatten = true
g.which_key_centered = true
g.which_key_use_floating_win = false
g.which_key_sort_horizontal = false
g.which_key_align_by_seperator = true
g.which_key_run_map_on_popup = true
g.which_key_ignore_invalid_key = false
g.which_key_fallback_to_native_key = true
