-- Insert new line above/below current line in inset mode
vim.keymap.set('i', '<C-j>', '<C-o>o')
vim.keymap.set('i', '<C-k>', '<C-o>O')

-- Delete whole words in insert mode with Ctrl + Backspace and Ctrl + Delete
-- If Shift is pressed, delete whole WORDs
vim.keymap.set('i', '<C-BS>', '<C-o>db')
vim.keymap.set('i', '<C-Del>', '<C-o>dw')

-- Map H and L to ^ and $
vim.keymap.set({ 'n', 'x', 'o' }, 'H', '^')
vim.keymap.set({ 'n', 'x', 'o' }, 'L', '$')

-- Don't move cursor when using J to join lines
vim.keymap.set({ 'n', 'x' }, 'J', 'mzJ`z')

-- Make scroll motions keep cursor in the middle
local scroll_motions = { '<C-u>', '<C-d>', '<C-f>', '<C-b>', 'n', 'N' }

for _, motion in ipairs(scroll_motions) do
    vim.keymap.set({ 'n', 'x' }, motion, motion .. 'zz', { silent = true })
end

-- Apply the . command to all selected lines in visual mode
vim.keymap.set('x', '.', ':normal .<CR>', { silent = true })

-- Cycle through windows
vim.keymap.set('n', '[w', '<CMD>wincmd W<CR>')
vim.keymap.set('n', ']w', '<CMD>wincmd w<CR>')

-- Previous/next buffer
vim.keymap.set('n', '[B', '<CMD>bprevious<CR>')
vim.keymap.set('n', ']B', '<CMD>bnext<CR>')

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

-- Previous/next quickfix item
vim.keymap.set('n', ']q', '<CMD>cnext<CR>')
vim.keymap.set('n', '[q', '<CMD>cprevious<CR>')

-- Quitall shortcut
vim.keymap.set('n', '<Leader>qq', '<CMD>quitall<CR>')
vim.keymap.set('n', '<Leader>QQ', '<CMD>quitall!<CR>')

-- Get out of Terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { silent = true, desc = 'Exit Terminal mode' })

-- Toggle spell checking
vim.keymap.set('n', '<C-s>', '<CMD>setlocal spell!<CR>', { silent = true })

-- Yank/paste to clipboard
vim.keymap.set({ 'n', 'x' }, '<Leader>y', '"+y')
vim.keymap.set({ 'n', 'x' }, '<Leader>p', '"+p')

local function toggle_quickfix(loclist)
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        local wininfo = vim.fn.getwininfo(win)[1]
        if (loclist and wininfo.loclist or wininfo.quickfix) == 1 then
            -- Quickfix/Loclist window already open, close it
            vim.cmd(loclist and 'lclose' or 'cclose')
            return
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
    return ":move '>+" .. vim.v.count1 .. '<CR>gv=gv'
end, { expr = true })
vim.keymap.set('x', '<C-k>', function()
    return ":move '<-" .. -vim.v.count1 .. '<CR>gv=gv'
end, { expr = true })
