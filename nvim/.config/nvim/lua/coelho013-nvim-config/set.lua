vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.clipboard = "unnamedplus"

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
--vim.opt.expandtab = true 
vim.opt.softtabstop = 2

vim.o.timeoutlen = 10000

-- desde o 0.11 o virtual_text vem desligado, entao os erros so apareciam na coluna lateral
vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
})
