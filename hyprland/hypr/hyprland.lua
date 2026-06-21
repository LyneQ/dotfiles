-- =============================================================
-- hyprland.lua — Entry point
-- Converted from hyprlang to Lua (Hyprland >= 0.55)
-- =============================================================

-- ###################
-- ### MY PROGRAMS ###
-- ###################
-- These are global so sub-configs (keybind.lua, etc.) can use them.
terminal        = "ghostty"
fileManager     = "dolphin"
menu            = "qs -c noctalia-shell ipc call launcher toggle"
emojiMenu       = "qs -c noctalia-shell ipc call launcher emoji"
clipboardMenu   = "qs -c noctalia-shell ipc call plugin:clipboard toggle"
browser         = "helium-browser"
notepad         = "leafpad"

-- #####################
-- ### IMPORT CONFIG ###
-- #####################

require("env")
require("auto-start")
require("style")
require("input")
require("keybind")
require("window")
require("monitor")
require("permission")
