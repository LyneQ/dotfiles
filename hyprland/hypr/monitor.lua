-- =============================================================
-- monitor.lua — Configuration des moniteurs
-- Converted from hyprlang to Lua (Hyprland >= 0.55)
-- =============================================================

hl.monitor({
    output   = "DP-1",
    mode     = "1920x1080@120",
    position = "0x0",
    scale    = 1,
})

hl.monitor({
    output   = "DP-2",
    mode     = "1920x1080@60",
    position = "1920x0",
    scale    = 1,
})


-- bin a workspace to a specific monitor
hl.workspace_rule({
  workspace = "2",
  monitor   = "DP-2",
  default   = true
})

hl.workspace_rule({
  workspace = "3",
  monitor   = "DP-1",
  default   = true
})
