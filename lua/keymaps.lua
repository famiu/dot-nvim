-- Map H and L to ^ and $
vim.keymap.set({ 'n', 'x', 'o' }, 'H', '^')
vim.keymap.set({ 'n', 'x', 'o' }, 'L', '$')

-- Search only visual area in Visual mode
vim.keymap.set('x', '/', '<Esc>/\\%V')

-- Apply the . command to all selected lines in visual mode
vim.keymap.set('x', '.', ':normal .<CR>', { silent = true })

-- Cycle through windows
vim.keymap.set('n', '[w', '<CMD>wincmd W<CR>')
vim.keymap.set('n', ']w', '<CMD>wincmd w<CR>')

-- Tab keybinds
-- Previous/next tab
vim.keymap.set('n', '[t', '<CMD>tabprevious<CR>')
vim.keymap.set('n', ']t', '<CMD>tabnext<CR>')

-- Move current tab
vim.keymap.set('n', '[T', '<CMD>tabmove -1<CR>')
vim.keymap.set('n', ']T', '<CMD>tabmove +1<CR>')

-- New tab
vim.keymap.set('n', '<Leader>tn', '<CMD>tabnew<CR>')

-- Close tab
vim.keymap.set('n', '<Leader>tx', '<CMD>tabclose<CR>')
vim.keymap.set('n', '<Leader>tX', '<CMD>tabclose!<CR>')

-- Get out of Terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { silent = true, desc = 'Exit Terminal mode' })

-- Yank/paste to clipboard
vim.keymap.set({ 'n', 'x' }, '<Leader>y', '"+y')
vim.keymap.set({ 'n', 'x' }, '<Leader>p', '"+p')

local function toggle_quickfix(loclist)
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        local wininfo = vim.fn.getwininfo(win)[1]
        if wininfo.quickfix == 1 then
            -- Quickfix/Loclist window already open, close it
            vim.cmd(wininfo.loclist == 1 and 'lclose' or 'cclose')

            -- If the closed window is the same type as requested, return
            if wininfo.loclist == (loclist and 1 or 0) then
                return
            end
        end
    end

    -- Quickfix/Loclist window not open, open it
    vim.cmd(loclist and 'lopen' or 'copen')
end

-- Open quickifx/loclist
vim.keymap.set('n', '<Leader>q', function()
    toggle_quickfix(false)
end)
vim.keymap.set('n', '<Leader>l', function()
    toggle_quickfix(true)
end)

-- Move selected lines up or down with fixed indent
vim.keymap.set('x', '<C-j>', function()
    return ":<C-u>silent! '<,'>move '>+" .. vim.v.count1 .. '<CR>:silent! normal gv=gv<CR>'
end, { expr = true, silent = true, desc = 'Move selected lines down and re-indent' })
vim.keymap.set('x', '<C-k>', function()
    return ":<C-u>silent! '<,'>move '<-" .. -vim.v.count1 .. '<CR>:silent normal! gv=gv<CR>'
end, { expr = true, silent = true, desc = 'Move selected lines up and re-indent' })
