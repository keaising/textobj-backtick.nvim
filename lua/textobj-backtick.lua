local function search_backticks_inside(includeBacktick, trimSpace)
    -- search back for start `
    vim.fn.search("`", "b")
    if not includeBacktick then
        if trimSpace then
            -- search 1st non-empty char
            vim.fn.search("\\S")
        else
            vim.fn.search(".")
        end
    end
    vim.api.nvim_command("normal! m<")

    -- search forward for end `
    vim.fn.search("`")
    if not includeBacktick then
        -- search back for lastet non-empty char
        if trimSpace then
            -- search 1st non-empty char
            vim.fn.search("\\S", "b")
        else
            vim.fn.search(".", "b")
        end
    end

    vim.api.nvim_command("normal! m>")

    local mode = vim.fn.mode()
    if mode == "v" or mode == "V" or mode == "<C-V>" then
        vim.api.nvim_command("normal! gv")
    else
        vim.api.nvim_command("normal! `<v`>")
    end
end

local function inner_trim()
    return function()
        search_backticks_inside(false, true)
    end
end

local function inner_all()
    return function()
        search_backticks_inside(false, false)
    end
end

local function around()
    return function()
        search_backticks_inside(true, true)
    end
end

local function set_key(key, func)
    if key == "" then
        return
    end

    local opt = { silent = true, noremap = true }
    vim.keymap.set("v", key, func, opt)
    vim.keymap.set("x", key, func, opt)
    vim.keymap.set("o", key, func, opt)
end

local function set_complex_key(key, func)
    local opt = { silent = true, noremap = true }
    vim.keymap.set("v", key, func, opt)
    vim.keymap.set("x", key, func, opt)
    vim.keymap.set("o", key, func, opt)
    vim.keymap.set("n", key, func, opt)
end

-- default value
local C = {
    inner_trim_key = "i`",
    inner_all_key = "",
    around_key = "a`",
}

local function set_opts(opts)
    if opts == nil or type(opts) ~= "table" then
        return
    end

    if opts.inner_trim_key ~= nil and opts.inner_trim_key ~= "" then
        C.inner_trim_key = opts.inner_trim_key
    end

    if opts.inner_all_key ~= nil and opts.inner_all_key ~= "" then
        C.inner_all_key = opts.inner_all_key
    end

    if opts.around_key ~= nil and opts.around_key ~= "" then
        C.around_key = opts.around_key
    end
end

local M = {}

M.setup = function(opts)
    set_opts(opts)

    set_key(C.inner_trim_key, inner_trim())
    set_key(C.inner_all_key, inner_all())
    set_key(C.around_key, around())

    set_complex_key("<Plug>(textobj-backtick-i)", inner_trim())
    set_complex_key("<Plug>(textobj-backtick-ia)", inner_all())
    set_complex_key("<Plug>(textobj-backtick-a)", around())
end

return M

-- reference:
-- https://github.com/arsham/archer.nvim/blob/f85f9dff05345b4d23ab7cd935e108c3e1bb0003/lua/archer/textobj.lua#L34
-- https://github.com/fvictorio/vim-textobj-backticks/blob/88cad8a6ed64a7696c8888e71fc8c351e84b84a5/plugin/textobj/backticks.vim#L35
