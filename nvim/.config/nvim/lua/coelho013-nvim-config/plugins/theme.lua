return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
	    flavour = "mocha",
			transparent_background = true,
      styles = {
        comments = { "italic" },
        strings = { "italic" },
        types = { "bold" }
      }
    })
    vim.cmd.colorscheme("catppuccin")
  end
}
