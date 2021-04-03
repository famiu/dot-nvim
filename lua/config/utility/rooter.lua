local g = vim.g

-- File patterns that will trigger rooter, use / to include directories
g.rooter_targets = '/,*'

-- Patterns that rooter will look for to find project root.
-- To specify the root is a certain directory, prefix it with =
-- To specify the root has a certain directory or file (which may be a glob),
--  just give the name
-- To specify the root has a certain directory as an ancestor, prefix it with ^:
-- To specify the root has a certain directory as its direct ancestor / parent,
--  prefix it with >
-- To exclude a pattern, prefix it with !
-- NOTE: Always list exclusions before patterns
g.rooter_patterns = {'.git', 'Makefile', '>Workspace'}

-- Change to opened file's directory for non-project files
g.rooter_change_directory_for_non_project_files = 'current'

-- Use LCD to change directory
g.rooter_cd_cmd = 'lcd'
