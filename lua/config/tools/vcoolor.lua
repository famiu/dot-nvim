local g = vim.g

-- Default map
g.vcoolor_map = '<A-c>c'
-- Insert rgb color.
g.vcool_ins_rgb_map = '<A-c>r'
-- Insert hsl color.
g.vcool_ins_hsl_map = '<A-c>h'
-- Insert rgba color.
g.vcool_ins_rgba_map = '<A-c>a'

require('which-key').register({
    ["<M-c>"] = {
        name = "+color-picker",
        c = "Default color picker",
        r = "RGB color picker",
        h = "HSL color picker",
        a = "RGBA color picker"
    }
})
