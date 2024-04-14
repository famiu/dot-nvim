-- Unmap ZZ and ZQ, they're redundant and useless
vim.keymap.set('n', 'ZQ', '<Nop>')
vim.keymap.set('n', 'ZZ', '<Nop>')

-- Insert new line above/below current line in inset mode
vim.keymap.set('i', '<C-j>', '<C-o>o')
vim.keymap.set('i', '<C-k>', '<C-o>O')

-- Delete whole words in insert mode with Ctrl + Backspace and Ctrl + Delete
-- If Shift is pressed, delete whole WORDs
vim.keymap.set('i', '<C-BS>', '<C-o>db')
vim.keymap.set('i', '<C-Del>', '<C-o>dw')

-- Map H and L to ^ and $
vim.keymap.set({ 'n', 'x' }, 'H', '^')
vim.keymap.set({ 'n', 'x' }, 'L', '$')

-- Don't move cursor when using J to join lines
vim.keymap.set('n', 'J', 'mzJ`z')

-- Make certain motions keep cursor in the middle
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')

-- Don't leave visual mode after indenting
vim.keymap.set('x', '>', '>gv^')
vim.keymap.set('x', '<', '<gv^')

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
