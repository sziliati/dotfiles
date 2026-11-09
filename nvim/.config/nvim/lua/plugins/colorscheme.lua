-- Omarchy téma integráció: a ~/.local/state/omarchy/current/theme/neovim.lua
-- (LazyVim formátumú spec) alapján telepíti és alkalmazza a témát,
-- és témaváltáskor (omarchy-theme-set) újratölti.
local theme_file = vim.fn.expand("~/.local/state/omarchy/current/theme/neovim.lua")

local function read_theme()
  local ok, spec = pcall(dofile, theme_file)
  if not ok or type(spec) ~= "table" then return {}, nil end
  local plugins, colorscheme = {}, nil
  for _, s in ipairs(spec) do
    if s[1] == "LazyVim/LazyVim" then
      colorscheme = s.opts and s.opts.colorscheme
    elseif s[1] then
      table.insert(plugins, s)
    end
  end
  return plugins, colorscheme
end

local function apply()
  local _, cs = read_theme()
  vim.o.background = "dark"
  if not cs or not pcall(vim.cmd.colorscheme, cs) then
    vim.cmd.colorscheme("habamax")
  end
end

local theme_plugins = read_theme()
for _, s in ipairs(theme_plugins) do
  s.lazy = true
  s.priority = 1000
end

-- Az Omarchy témákhoz tartozó összes colorscheme (lusta betöltés), hogy a váltás azonnali legyen
local all = {
  { "ribru17/bamboo.nvim" }, { "bjarneo/aether.nvim" }, { "bjarneo/ethereal.nvim" },
  { "bjarneo/hackerman.nvim" }, { "bjarneo/vantablack.nvim" }, { "bjarneo/white.nvim" },
  { "catppuccin/nvim", name = "catppuccin" }, { "sainnhe/everforest" }, { "kepano/flexoki-neovim" },
  { "ellisonleao/gruvbox.nvim" }, { "rebelot/kanagawa.nvim" }, { "tahayvr/matteblack.nvim" },
  { "loctvl842/monokai-pro.nvim" }, { "shaunsingh/nord.nvim" }, { "rose-pine/neovim", name = "rose-pine" },
  { "folke/tokyonight.nvim" }, { "OldJobobo/miasma.nvim" }, { "OldJobobo/retro-82.nvim" },
  { "omacom-io/lumon.nvim" },
}
for _, s in ipairs(all) do
  s.lazy = true
  s.priority = 1000
end

local specs = vim.list_extend(all, theme_plugins)

table.insert(specs, {
  name = "omarchy-theme",
  dir = vim.fn.stdpath("config"),
  lazy = false,
  priority = 999,
  config = function()
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        dofile(vim.fn.stdpath("config") .. "/lua/config/transparency.lua")
      end,
    })
    apply()

    -- Témaváltás figyelése (omarchy-theme-set átírja a theme.name-et)
    local dir = vim.fn.expand("~/.local/state/omarchy/current")
    local w = vim.uv.new_fs_event()
    if w then
      local timer = vim.uv.new_timer()
      w:start(dir, { recursive = false }, function(_, fname)
        if fname ~= "theme.name" and fname ~= "theme.generation" then return end
        timer:stop()
        timer:start(300, 0, vim.schedule_wrap(function()
          vim.cmd("highlight clear")
          apply()
        end))
      end)
    end
    vim.api.nvim_create_user_command("ThemeReload", apply, { desc = "Omarchy téma újratöltése" })
  end,
})

return specs
