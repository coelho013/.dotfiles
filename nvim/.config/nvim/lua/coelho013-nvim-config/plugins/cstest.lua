local dir = vim.env.CSTEST_DIR
if not dir or dir == "" then
  return {}
end
return {
  {
    "cstest.nvim",
    name = "cstest.nvim",
    dir = dir,
    ft = "groovy",
    cmd = {
      "Cstest",
      "CstestNearest",
      "CstestFile",
      "CstestAll",
      "CstestLast",
      "CstestFailed",
      "CstestPick",
      "CstestSummary",
      "CstestOutput",
      "CstestQuickfix",
      "CstestStop",
    },
    opts = {
      summary = {
        position = "right",
        width = 70,
      },
    },
    keys = {
      { "<leader>tc", "", desc = "+capacitor" },
      { "<leader>tcc", "<cmd>CstestNearest<cr>", desc = "Teste mais proximo" },
      { "<leader>tcf", "<cmd>CstestFile<cr>", desc = "Arquivo de teste atual" },
      { "<leader>tca", "<cmd>CstestAll<cr>", desc = "Todos os testes" },
      { "<leader>tcl", "<cmd>CstestLast<cr>", desc = "Repetir ultima execucao" },
      { "<leader>tce", "<cmd>CstestFailed<cr>", desc = "Rodar so as falhas" },
      { "<leader>tcp", "<cmd>CstestPick<cr>", desc = "Escolher teste" },
      { "<leader>tcs", "<cmd>CstestSummary<cr>", desc = "Painel de resultados" },
      { "<leader>tco", "<cmd>CstestOutput<cr>", desc = "Saida completa" },
      { "<leader>tcq", "<cmd>CstestQuickfix<cr>", desc = "Falhas no quickfix" },
      { "<leader>tcS", "<cmd>CstestStop<cr>", desc = "Cancelar execucao" },
    },
  },
}
