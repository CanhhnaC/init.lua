local M = {}

M.general = {
    i = {
        -- go to  beginning and end
        ["<C-b>"] = { "<ESC>^i", "beginning of line" },
        ["<C-e>"] = { "<End>", "end of line" },

        -- navigate within insert mode
        ["<C-h>"] = { "<Left>", "move left" },
        ["<C-l>"] = { "<Right>", "move right" },
        ["<C-j>"] = { "<Down>", "move down" },

        -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
        -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
        -- empty mode is same as using <cmd> :map
        ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "move up", opts = { expr = true } },
        ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "move down", opts = { expr = true } },
        ["<C-k>"] = { "<Up>", "move up" },
    },

    n = {
        ["<Esc>"] = { ":noh <CR>", "clear highlights" },
        -- switch between windows
        ["<C-h>"] = { "<C-w>h", "window left" },
        ["<C-l>"] = { "<C-w>l", "window right" },
        ["<C-j>"] = { "<C-w>j", "window down" },
        ["<C-k>"] = { "<C-w>k", "window up" },

        -- Copy all
        ["<C-c>"] = { "<cmd> %y+ <CR>", "copy whole file" },

        -- Navigation
        ["H"] = { "^", "beginning of line" },
        ["L"] = { "$", "end of line" },
    },

    v = {
        ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "move up", opts = { expr = true } },
        ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "move down", opts = { expr = true } },
    },

    x = {
        ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "move down", opts = { expr = true } },
        ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "move up", opts = { expr = true } },
        -- Don't copy the replaced text after pasting in visual mode
        -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
        ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "dont copy replaced text", opts = { silent = true } },
    },
}

M.nvimtree = {
    plugin = true,

    n = {
        -- toggle
        ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },

        -- focus
        ["<leader>e"] = { "<cmd> NvimTreeFocus <CR>", "focus nvimtree" },
    },
}

M.hop = {
    n = {
        ["<leader><leader>s"] = { "<cmd> HopChar1 <CR>", "   Search character" },
        ["<leader><leader>/"] = { "<cmd> HopPattern <CR>", "   Search n-character" },
    },
}

return M
