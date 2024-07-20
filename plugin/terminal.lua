--- Toggleable terminal. Re-uses existing terminal buffer if it wasn't closed.
local term_buffer = nil

local function toggle_term_buffer()
    local term_wins = {}

    if not term_buffer or not vim.api.nvim_buf_is_valid(term_buffer) then
        term_buffer = vim.api.nvim_create_buf(true, false)
        vim.api.nvim_buf_call(term_buffer, function()
            vim.fn.termopen(vim.o.shell, {
                on_exit = function()
                    vim.api.nvim_buf_delete(term_buffer, { force = true })
                end,
            })
        end)
    else
        term_wins = vim.tbl_filter(function(win)
            return vim.api.nvim_win_get_buf(win) == term_buffer
        end, vim.api.nvim_tabpage_list_wins(0))
    end

    -- If a terminal window exists and is current window, close the window.
    if vim.tbl_contains(term_wins, vim.api.nvim_get_current_win()) then
        for _, win in ipairs(term_wins) do
            vim.api.nvim_win_close(win, true)
        end

        return
        -- Switch to terminal window if a terminal window exists but isn't current window.
    elseif term_wins[1] ~= nil then
        vim.api.nvim_set_current_win(term_wins[1])
        -- If a terminal window doesn't exist, create a new one.
    else
        -- Use the minimum of 30% of Neovim screen height or 32 lines.
        local winheight = math.min(math.floor(vim.o.lines * 0.3 + 0.5), 32)

        local term_win = vim.api.nvim_open_win(term_buffer, true, {
            win = -1,
            split = 'below',
            height = winheight,
        })

        vim.wo[term_win].statuscolumn = ''
        vim.wo[term_win].number = false
        vim.wo[term_win].relativenumber = false
        vim.wo[term_win].signcolumn = 'no'
    end

    vim.cmd.startinsert()
end

vim.keymap.set({ 'n', 't' }, '<C-t>', toggle_term_buffer)
