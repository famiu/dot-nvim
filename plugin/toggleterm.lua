--- Toggleable terminal. Re-uses existing terminal buffer if it wasn't closed.
local term_buffer = nil

local function toggle_term_buffer()
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
        local term_wins = vim.tbl_filter(function(win)
            return vim.api.nvim_win_get_buf(win) == term_buffer
        end, vim.api.nvim_tabpage_list_wins(0))

        if next(term_wins) ~= nil then
            for _, win in ipairs(term_wins) do
                vim.api.nvim_win_close(win, true)
            end

            return
        end
    end

    -- Use the minimum of 30% of Neovim screen height or 32 lines
    local winheight = math.min(math.floor(vim.o.lines * 0.3 + 0.5), 32)

    local win = vim.api.nvim_open_win(term_buffer, true, {
        win = -1,
        split = 'below',
        height = winheight,
    })

    vim.cmd.startinsert()
end

vim.keymap.set({ 'n', 't' }, '<C-t>', toggle_term_buffer)
