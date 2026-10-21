-- setando jdk-17 para plugins, evitando mudar o path do java.
vim.env.JAVA_HOME = "C:/Program Files/Eclipse Adoptium/jdk-17.0.20.101-hotspot"
vim.env.PATH = vim.env.JAVA_HOME .. "/bin;" .. vim.env.PATH

vim.g.mapleader = " "

require("coelho013-nvim-config.plugins_init")
require("coelho013-nvim-config.set")
require("coelho013-nvim-config.remap")
