local wezterm = require 'wezterm'
local mux = wezterm.mux

local config = wezterm.config_builder()

config.color_scheme = 'Abernathy'
config.font = wezterm.font('JetBrains Mono', { weight = 'Regular', italic = false })
config.font_size = 13.0

config.pane_focus_follows_mouse = true

wezterm.on('gui-attached', function(domain)
  -- maximize all displayed windows on startup (Doesn't work for some reason)
  local workspace = mux.get_active_workspace()
  for _, window in ipairs(mux.all_windows()) do
    if window:get_workspace() == workspace then
      window:gui_window():maximize()
    end
  end
end)

config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
}

config.use_fancy_tab_bar = false

local tab_width = 25

config.tab_max_width = tab_width

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function tab_title(tab_info)
  local ret = ""
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    ret = title
  else
    -- Otherwise, use the title from the active pane
    -- in that tab
    ret = tab_info.active_pane.title
  end

  return ret
end

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local title = tab_title(tab)
    local title_len = string.len(title)
    return {
      { Text = ' ' .. title .. string.rep(' ', tab_width - title_len - 1) },
    }
  end
)

return config
