local opt = vim.opt
local g = vim.g

opt.laststatus = 3

opt.clipboard = "unnamedplus"
opt.cursorline = true

opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.fillchars = {
  eob = " ",
}
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.ruler = false
opt.foldlevel = 10
opt.cole = 1
opt.so = 5
opt.confirm = true

opt.updatetime = 300

opt.whichwrap = "b,s,<,>,[,],h,l"

g.mapleader = " "

-- disable some default providers

for _, provider in ipairs { "perl", "ruby" } do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end
