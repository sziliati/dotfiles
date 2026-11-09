return {
  "saghen/blink.cmp",
  version = "1.*",
  dependencies = { "rafamadriz/friendly-snippets" },
  event = { "InsertEnter", "CmdlineEnter" },
  opts = {
    keymap = { preset = "default" }, -- <C-y> elfogad, <C-n>/<C-p>, <C-space>, <C-e>
    appearance = { nerd_font_variant = "mono" },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 300 },
      ghost_text = { enabled = true },
    },
    signature = { enabled = true },
    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      providers = {
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
      },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
}
