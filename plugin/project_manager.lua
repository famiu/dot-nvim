local config = {
    storage_file = vim.fn.stdpath('data') .. '/projects.json',
}

local M = {
    projects = {},
}

-- Get the current time in seconds since some point in time.
-- Do not rely on the exact epoch time, only on the relative values.
local function get_time()
    return math.floor(vim.uv.now() / 1000)
end

-- Load projects from storage.
local function load_projects()
    local file = io.open(config.storage_file, 'r')
    if file then
        local content = file:read('*all')
        file:close()
        if content and content ~= '' then
            M.projects = vim.json.decode(content) or {}
        end
    end
end

-- Save projects to storage.
local function save_projects()
    local file = io.open(config.storage_file, 'w')
    if file then
        file:write(vim.json.encode(M.projects))
        file:close()
    else
        vim.notify('Failed to save projects', vim.log.levels.ERROR)
    end
end

-- Calculate frecency score for a single path entry.
local function calculate_frecency(path_entry, current_time)
    local lambda = 0.01 -- Decay factor
    local delta_t = current_time - path_entry.last_access
    local recency_factor = 1 / (1 + lambda * delta_t)
    return recency_factor * path_entry.frequency
end

-- Sort projects table by frecency.
local function sort_by_frecency()
    local current_time = os.time()

    table.sort(M.projects, function(a, b)
        return calculate_frecency(a, current_time) > calculate_frecency(b, current_time)
    end)
end

-- Add a project to the list.
local function add_project(path, manual)
    path = vim.fs.normalize(path or vim.fn.getcwd())

    -- Check if project already exists.
    for _, project in ipairs(M.projects) do
        if project.path == path then
            if manual then
                vim.notify('Project already exists: ' .. path, vim.log.levels.WARN)
            end
            return
        end
    end

    table.insert(M.projects, { path = path, frequency = 0, last_access = 0 })
    save_projects()

    if manual then
        vim.notify('Added project: ' .. path)
    end
end

-- Delete a project from the list.
local function delete_project(path, manual)
    path = vim.fs.normalize(path or vim.fn.getcwd())

    for i, project_path in ipairs(M.projects) do
        if project_path.path == path then
            table.remove(M.projects, i)
            save_projects()

            if manual then
                vim.notify('Removed project: ' .. path)
            end

            return
        end
    end

    vim.notify('Project not found: ' .. path, vim.log.levels.WARN)
end

-- Update project metadata when a project is accessed.
local function access_project(path)
    for _, project in ipairs(M.projects) do
        if project.path == path then
            project.frequency = project.frequency + 1
            project.last_access = get_time()
            save_projects()
            return
        end
    end
end

-- Show the list of projects, sorted by frecency.
local function show_projects()
    sort_by_frecency()

    local project_paths = vim.tbl_map(function(p)
        return p.path
    end, M.projects)

    local project_name_maxlen = math.max(unpack(vim.tbl_map(function(p)
        return #vim.fs.basename(p)
    end, project_paths)))

    vim.ui.select(project_paths, {
        prompt = 'Select a project:',
        format_item = function(item)
            return ('%%-%ds\t%%s'):format(project_name_maxlen):format(vim.fs.basename(item), item)
        end,
    }, function(selected_project)
        if selected_project then
            access_project(selected_project)
            vim.api.nvim_set_current_dir(selected_project)

            local ok, fzflua = pcall(require, 'fzf-lua')

            if ok then
                fzflua.files({ cwd = selected_project })
            end
        end
    end)
end

-- Initialize the plugin.
local function init()
    load_projects()

    vim.api.nvim_create_user_command('ProjectList', show_projects, {
        desc = 'List all projects',
    })

    vim.api.nvim_create_user_command('ProjectAdd', function(opts)
        add_project(opts.args ~= '' and opts.args or nil, true)
    end, {
        desc = 'Add a project (defaults to current directory)',
        nargs = '?',
        complete = 'dir',
    })

    vim.api.nvim_create_user_command('ProjectDelete', function(opts)
        delete_project(opts.args ~= '' and opts.args or nil, true)
    end, {
        desc = 'Delete a project',
        nargs = '?',
        complete = function(_, _, _)
            return vim.tbl_map(function(p)
                return p.path
            end, M.projects)
        end,
    })

    vim.api.nvim_create_user_command('ProjectClear', function()
        M.projects = {}
        save_projects()
        vim.notify('Cleared all projects')
    end, {
        desc = 'Clear all projects',
    })
end

init()

-- Default keybinding for listing projects.
vim.keymap.set('n', '<Leader>w', '<CMD>ProjectList<CR>', {
    desc = 'List all projects',
})

return M
