local wk = require('whichkey_setup')

local keymap = {
    ['1'] = 'Window 1',
    ['2'] = 'Window 2',
    ['3'] = 'Window 3',
    ['4'] = 'Window 4',
    ['5'] = 'Window 5',
    ['6'] = 'Window 6',
    ['7'] = 'Window 7',
    ['8'] = 'Window 8',
    ['9'] = 'Window 9',
    w = {
        name = '+windows',
        h = 'Go to window left',
        j = 'Go to window below',
        k = 'Go to window above',
        l = 'Go to window right',
        r = {
            name = '+resize',
            ['='] = 'Make all windowse equal',
            ['+'] = 'Increase window height',
            ['-'] = 'Decrease window height',
            ['>'] = 'Increase window width',
            ['<'] = 'Decrease window width',
        },
        R = {
            name = '+rotate',
            b = 'Rotate down/right',
            u = 'Rotate up/left',
        },
        m = {
            name = '+move',
            x = 'Exchange windows',
            h = 'Move window left',
            j = 'Move window below',
            k = 'Move window above',
            l = 'Move window right'
        }
    },
    b = {
        name = '+buffer',
        ['1'] = 'Goto 1',
        ['2'] = 'Goto 2',
        ['3'] = 'Goto 3',
        ['4'] = 'Goto 4',
        ['5'] = 'Goto 5',
        ['6'] = 'Goto 6',
        ['7'] = 'Goto 7',
        ['8'] = 'Goto 8',
        ['9'] = 'Goto Last',
        c = 'Choose',
        n = 'Next',
        p = 'Previous',
        x = 'Close',
        m = {
            name = '+move',
            n = 'Next',
            p = 'Previous'
        },
        o = {
            name = '+order',
            d = 'By Directory',
            l = 'By Language'
        }
    },
    f = {
        name = '+telescope',
        b = 'Buffers',
        f = 'Find files',
        g = 'Live grep',
        h = 'Help tags',
        t = 'Treesitter'
    },
    g = {
        name = '+git',
        a = 'Add',
        b = 'Blame',
        c = 'Commit',
        d = 'Diff',
        m = 'Amend',
        p = 'Push',
        s = 'Status',
        v = {
            name = '+commit-browser',
            o = 'Open commit browser',
            c = 'List commits that affected current file',
            l = 'Fill location list with revisions of current file'
        },
        w = 'Write'
    },
    t = {
        name = '+ui-toggle',
        n = 'NvimTree',
        u = 'UndoTree'
    },
    l = {
        name = '+lsp',
        s = {
            name = '+symbols',
            d = 'Document Symbols',
            w = 'Workspace Symbols'
        },
        d = {
            name = '+diagnostics',
            d = 'Document Diagnostics',
            w = 'Workspace Diagnostics'
        },
        c = 'Code Actions'
    },
    d = {
        name = '+dap',
        c = 'Commands',
        s = 'Configurations',
        l = 'List breakpoints',
        v = 'Variables',
        f = 'Frames',
        t = 'Toggle breakpoint',
        b = {
            name = '+set-breakpoint',
            c = 'Conditional breakpoint',
            l = 'Log point'
        },
        r = 'Open REPL',
        R = 'Run last'
    }
}

wk.register_keymap('leader', keymap)
