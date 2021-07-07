local function filter_buffer(b)
    return vim.fn.buflisted(b) == 1 and vim.api.nvim_buf_is_loaded(b)
end

local function get_mru_list()
    -- get a list of buffers
    local buffer_list = {}
    for i, b in ipairs(vim.api.nvim_list_bufs()) do
        if filter_buffer(b) then
            local info = vim.fn.getbufinfo(b)[1]
            table.insert(buffer_list, info)
        end
    end

    -- sort by last used (desc)
    table.sort(buffer_list, function (a, b) 
        return a.lastused > b.lastused
    end)

    return buffer_list
end

local function init_state()
    return {
        buffers = get_mru_list(),
        idx = 1,
        target_window = vim.api.nvim_get_current_win(),
    }
end

local function pretty_print_state(state)
    local line = {}
    for i, v in ipairs(state.buffers) do
        local hl = nil
        if i == state.idx then
            hl = 'TermCursor'
        end
        table.insert(line, {vim.fn.fnamemodify(v.name, ':~:.'), hl})
        table.insert(line, {" "})
    end

    vim.api.nvim_echo(line, false, {})
end

local FORWARD = 1
local BACKWARD = -1

local function change_buffer(state, direction, wrap)
    -- update index and temporarily use zero-based indices...
    local idx = state.idx + direction - 1
    if wrap then
        idx = idx % #state.buffers
    else 
        idx = math.max(0, math.min(#state.buffers - 1, idx))
    end
    state.idx = idx + 1

    -- switch buffer
    vim.api.nvim_win_set_buf(state.target_window, state.buffers[state.idx].bufnr)
end

local function buffer_switch(initial, wrap)
    local state = init_state()
    if #state.buffers == 0 then
        return 
    end

    if initial then
        change_buffer(state, FORWARD, wrap)
    end

    while true do
        vim.api.nvim_command('redraw')
        pretty_print_state(state)
        local char = vim.fn.nr2char(vim.fn.getchar())
        if char == '.' then
            change_buffer(state, FORWARD, wrap)
        elseif char == ',' then
            change_buffer(state, BACKWARD, wrap)
        else
            vim.api.nvim_feedkeys(char, 'mt', false)
            break
        end
    end
    vim.api.nvim_command('redraw | echo ""')
end

return {
    start_switch = function() 
        buffer_switch(true, false)
    end,
}
