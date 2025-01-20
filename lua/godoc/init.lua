-- init.lua
local M = {}

-- Function to create a floating window
local function create_float()
    -- Window configuration
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local buf = vim.api.nvim_create_buf(false, true)
    
    -- Calculate center position
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)
    
    -- Window options
    local opts = {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
        border = 'rounded'
    }
    
    -- Create the window
    local win = vim.api.nvim_open_win(buf, true, opts)
    
    -- Set buffer options
    vim.api.nvim_buf_set_option(buf, 'modifiable', false)
    vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
    vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
    
    -- Set buffer keymap
    vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':close<CR>', { noremap = true, silent = true })
    
    return buf, win
end

-- Function to get godoc output
local function get_godoc(package)
    local command = string.format('go doc %s', package)
    local handle = io.popen(command)
    if handle then
        local result = handle:read("*a")
        handle:close()
        return result
    end
    return nil
end

-- Main function to show godoc
function M.show_godoc(package)
    if not package or package == "" then
        vim.notify('Please provide a package name', vim.log.levels.ERROR)
        return
    end
    
    -- Get documentation
    local doc = get_godoc(package)
    if doc then
        -- Create window and buffer
        local buf, _ = create_float()
        -- Split content into lines
        local lines = {}
        for line in doc:gmatch("[^\r\n]+") do
            table.insert(lines, line)
        end
        -- Set buffer content
        vim.api.nvim_buf_set_option(buf, 'modifiable', true)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        vim.api.nvim_buf_set_option(buf, 'modifiable', false)
    else
        vim.notify('No documentation found', vim.log.levels.ERROR)
    end
end

-- Setup function that will be called by the user
function M.setup(opts)
    opts = opts or {}
    
    -- Create the user command
    vim.api.nvim_create_user_command('Godoc', function(cmd_opts)
        M.show_godoc(cmd_opts.args)
    end, { nargs = '?' })
end

return M
