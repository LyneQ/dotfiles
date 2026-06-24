-- =============================================================
-- hyprland.lua — Entry point
-- Converted from hyprlang to Lua (Hyprland >= 0.55)
-- =============================================================

-- ###################
-- ### MY PROGRAMS ###
-- ###################

-- Apps
terminal        = "ghostty"
fileManager     = "dolphin"
browser         = "helium-browser"
notepad         = "leafpad"
-- Menu
menu            = "qs -c noctalia-shell ipc call launcher toggle"
emojiMenu       = "qs -c noctalia-shell ipc call launcher emoji"
clipboardMenu   = "qs -c noctalia-shell ipc call plugin:clipboard toggle"
-- Command
colorPickerCmd  = "hyprpicker --autocopy --notify --scale=8"
screenShotCmd   = "hyprshot -m region --clipboard-only --freeze"
muteCmd         = "wpctl set-mute @DEFAULT_SOURCE@ toggle"


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
