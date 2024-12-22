local config = {
    root_dirs = {
        '~/Documents/Dev/',
    },
    max_depth = 3,
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
    path = path or vim.fn.getcwd()
    path = vim.fs.normalize(path)

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
    assert(path, 'No project path provided')
    path = vim.fs.normalize(path)

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

---  @brief Get unique names for project paths.
---
---  @details Generates a unique name for each project path by comparing it with other project paths.
---  It ensures that the generated name is unique by including parent directory names if necessary.
---
---  @note All paths must be normalized before calling this function.
---
---  @param project_paths string[]: A list of project paths to compare with.
---  @return string[]: A list of unique project names, corresponding to the input project paths.
local function get_unique_project_names(project_paths)
    local project_names = {}

    --- Parse a path into its parts.
    ---
    --- @param path string: The path to parse.
    --- @return string[]: The parts of the path.
    local function get_path_parts(path)
        local parents = vim.tbl_map(function(p)
            return vim.fs.basename(p)
        end, vim.iter(vim.fs.parents(path)):totable())

        -- The last parent is the root directory, the basename of the root directory is empty. So remove it.
        assert(parents[#parents] == '', 'The last parent should be the root directory')
        parents[#parents] = nil

        -- Reverse the parent list to ensure that the topmost directory comes first,
        -- this makes it easier to concatenate the list back into a path.
        parents = vim.iter(parents):rev():totable()
        -- Add the path itself to the list of parents, so that joining each element gives back the full path.
        parents[#parents + 1] = vim.fs.basename(path)

        return parents
    end

    for i, project_path in ipairs(project_paths) do
        local project_paths_excluding_current = vim.tbl_filter(function(p)
            return p ~= project_path
        end, project_paths)

        local project_path_parts = get_path_parts(project_path)

        -- Find the amount of parent directories to include for the name to be unique.
        local depth = math.max(unpack(vim.tbl_map(function(p)
            local p_parts = get_path_parts(p)

            -- Iterate parts in reverse when trying to find a differing directory
            for j = #p_parts, 1, -1 do
                if p_parts[j] ~= project_path_parts[j] then
                    return #p_parts - j
                end
            end
        end, project_paths_excluding_current)))

        if #project_path_parts - depth <= 1 then
            project_names[i] = project_path
        else
            project_names[i] = vim.fs.normalize(
                table.concat(project_path_parts, '/', #project_path_parts - depth, #project_path_parts)
            )
        end
    end

    return project_names
end

-- Show the list of projects, sorted by frecency.
local function show_projects()
    sort_by_frecency()

    local project_paths = vim.tbl_map(function(p)
        return p.path
    end, M.projects)

    local project_names = get_unique_project_names(project_paths)
    local project_name_path = {}

    for i, project_name in ipairs(project_names) do
        project_name_path[project_name] = project_paths[i]
    end

    vim.ui.select(project_names, {
        prompt = 'Select a project:',
    }, function(selected_project)
        if selected_project then
            local selected_project_path = project_name_path[selected_project]

            access_project(selected_project_path)
            vim.api.nvim_set_current_dir(selected_project_path)

            local ok, fzflua = pcall(require, 'fzf-lua')

            if ok then
                fzflua.files({ cwd = selected_project_path })
            end
        end
    end)
end

-- Recursively scan root directories for projects.
local function scan_for_projects_in_root(root, depth)
    if depth <= 0 then
        return
    end

    local normalized_root = vim.fs.normalize(root)
    local handle = vim.uv.fs_scandir(normalized_root)

    if not handle then
        vim.notify('Failed to scan directory: ' .. normalized_root, vim.log.levels.ERROR)
        return
    end

    while true do
        local name, t = vim.uv.fs_scandir_next(handle)
        if not name then
            break
        end

        if t == 'directory' then
            local path = normalized_root .. '/' .. name
            if vim.uv.fs_stat(path .. '/.git') then
                add_project(path, false)
            else
                scan_for_projects_in_root(path, depth - 1)
            end
        end
    end
end

-- Scan for projects in root directories.
local function scan_for_projects()
    for _, root in ipairs(config.root_dirs) do
        scan_for_projects_in_root(root, config.max_depth)
    end

    save_projects()
end

-- Initialize the plugin.
local function init()
    load_projects()
    scan_for_projects()

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
        delete_project(opts.args, true)
    end, {
        desc = 'Delete a project',
        nargs = 1,
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

    vim.api.nvim_create_user_command('ProjectScan', function()
        scan_for_projects()
        vim.notify('Projects rescanned')
    end, {
        desc = 'Rescan for projects',
    })
end

init()

-- Default keybinding for listing projects.
vim.keymap.set('n', '<Leader>w', '<CMD>ProjectList<CR>', {
    desc = 'List all projects',
})

return M
