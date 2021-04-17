local components = require('feline.presets').default.components

components.left.inactive = {}
components.mid.inactive = {}
components.right.inactive = {}

components.left.inactive[1] = {
    provider = '',
    hl = {
        fg = '#454545',
        bg = 'NONE',
        style = 'underline'
    }
}

require('feline').setup()
