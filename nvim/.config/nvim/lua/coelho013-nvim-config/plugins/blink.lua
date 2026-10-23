return {
  'saghen/blink.cmp',
  -- versao com release usa o binario pre-compilado do fuzzy matcher (sem precisar de cargo)
  version = '1.*',
  event = 'InsertEnter',

  opts = {
    keymap = { preset = 'default' },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 300 },
    },
    signature = { enabled = true },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
  },
}
