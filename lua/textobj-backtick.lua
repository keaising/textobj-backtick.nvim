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
        search_backticks_inside(false, true)
    end
end

local function arround()
    return function()
        search_backticks_inside(true, true)
    end
end

local opt = { silent = true, noremap = true }

vim.keymap.set("v", "i`", inner_trim(), opt)
vim.keymap.set("x", "i`", inner_trim(), opt)
vim.keymap.set("o", "i`", inner_trim(), opt)

vim.keymap.set("v", "ia`", inner_all(), opt)
vim.keymap.set("x", "ia`", inner_all(), opt)
vim.keymap.set("o", "ia`", inner_all(), opt)

vim.keymap.set("v", "a`", arround(), opt)
vim.keymap.set("x", "a`", arround(), opt)
vim.keymap.set("o", "a`", arround(), opt)

vim.keymap.set("v", "<Plug>(textobj-backtick-i)", inner_trim(), opt)
vim.keymap.set("x", "<Plug>(textobj-backtick-i)", inner_trim(), opt)
vim.keymap.set("o", "<Plug>(textobj-backtick-i)", inner_trim(), opt)
vim.keymap.set("n", "<Plug>(textobj-backtick-i)", inner_trim(), opt)

vim.keymap.set("v", "<Plug>(textobj-backtick-ia)", inner_all(), opt)
vim.keymap.set("x", "<Plug>(textobj-backtick-ia)", inner_all(), opt)
vim.keymap.set("o", "<Plug>(textobj-backtick-ia)", inner_all(), opt)
vim.keymap.set("n", "<Plug>(textobj-backtick-ia)", inner_all(), opt)

vim.keymap.set("v", "<Plug>(textobj-backtick-a)", arround(), opt)
vim.keymap.set("x", "<Plug>(textobj-backtick-a)", arround(), opt)
vim.keymap.set("o", "<Plug>(textobj-backtick-a)", arround(), opt)
vim.keymap.set("n", "<Plug>(textobj-backtick-a)", arround(), opt)

local M = {}
M.setup = function() end

return M

-- reference:
-- https://github.com/arsham/archer.nvim/blob/f85f9dff05345b4d23ab7cd935e108c3e1bb0003/lua/archer/textobj.lua#L34
-- https://github.com/fvictorio/vim-textobj-backticks/blob/88cad8a6ed64a7696c8888e71fc8c351e84b84a5/plugin/textobj/backticks.vim#L35
