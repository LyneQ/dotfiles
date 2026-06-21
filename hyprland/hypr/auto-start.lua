-- =============================================================
-- auto-start.lua — Démarrage automatique
-- Converted from hyprlang to Lua (Hyprland >= 0.55)
-- =============================================================

local pluginDir = os.getenv("HYPR_PLUGIN_DIR") or ""

hl.on("hyprland.start", function()
    hl.dispatch(hl.dsp.exec_cmd("uwsm app -- nm-applet"))
    hl.dispatch(hl.dsp.exec_cmd("uwsm app -- wl-paste --watch cliphist store"))
    hl.dispatch(hl.dsp.exec_cmd("uwsm app -- hyprctl setcursor Polarnight-cursors 24"))
    -- hl.dispatch(hl.dsp.exec_cmd("uwsm app -- espanso start"))
    hl.dispatch(hl.dsp.exec_cmd("uwsm app -- qs -c noctalia-shell --no-duplicate"))
    hl.dispatch(hl.dsp.exec_cmd('uwsm app -- hyprctl plugin load "' .. pluginDir .. '/lib/libhyprexpo.so"'))
    hl.dispatch(hl.dsp.exec_cmd("uwsm app -- hyprpm reload"))
    -- Start VPN with P2P active and in the fastest country 
    hl.dispatch(hl.dsp.exec_cmd("uwsm app -- protonvpn connect --p2p"))
    -- Auto start app with specific desktop layout
    hl.dispatch(hl.dsp.exec_cmd("uwsm app -- discord"))
    hl.dispatch(hl.dsp.exec_cmd("uwsm app -- steam"))
end)