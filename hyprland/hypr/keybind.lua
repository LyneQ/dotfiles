-- =============================================================
-- keybind.lua — Raccourcis clavier
-- Converted from hyprlang to Lua (Hyprland >= 0.55)
-- =============================================================
-- Voir : https://wiki.hypr.land/Configuring/Basics/Binds/

local mainMod = "SUPER"

-- ############################
-- ### 1. BINDS DE BASE     ###
-- ############################
hl.bind(mainMod .. " + Q",      hl.dsp.window.close())                            -- Fermer la fenêtre active
hl.bind(mainMod .. " + M",      hl.dsp.exit())                                    -- Quitter Hyprland
hl.bind(mainMod .. " + V",      hl.dsp.window.float({ action = "toggle" }))       -- Toggle floating
hl.bind(mainMod .. " + P",      hl.dsp.window.pseudo())                           -- Dwindle pseudo
hl.bind(mainMod .. " + J",      hl.dsp.layout("togglesplit"))                     -- Toggle split
hl.bind(mainMod .. " + F",      hl.dsp.window.fullscreen("maximized", "toggle"))  -- Toggle fullscreen

-- ############################
-- ### 1. PROGRAMME DIRECT  ###
-- ############################
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(terminal))                        -- Ouvrir terminal
hl.bind(mainMod .. " + B",      hl.dsp.exec_cmd(browser))                         -- Ouvrir le navigateur
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(fileManager))                     -- Ouvrir le gestionnaire de fichiers
hl.bind(mainMod .. " + N",      hl.dsp.exec_cmd(notepad))                         -- Ouvrir notepad
hl.bind(mainMod .. " + R",      hl.dsp.exec_cmd(menu))                            -- Ouvrir le menu
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd(emojiMenu))                       -- Ouvrir le panneau de selection des emoji
hl.bind(mainMod .. " + C",      hl.dsp.exec_cmd(clipboardMenu))                   -- ouvrir l'historique du presse-papier

-- ############################
-- ### 2. UTILITAIRES ###
-- ############################
hl.bind(mainMod .. " + F1",     hl.dsp.exec_cmd("hyprctl switchxkblayout all next"))       -- Selection le layout de clavier suivant
hl.bind(mainMod .. " + F12",    hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))    -- Screenshot zone
hl.bind(mainMod .. " + F11",    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SOURCE@ toggle")) -- Toggle micro

-- ############################
-- ### 3. FOCUS FENÊTRE ###
-- ############################
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- ############################
-- ### 4. WORKSPACES (1-10) ###
-- ############################
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
  hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- ####################################
-- ### 4b. WORKSPACE SPÉCIAL (scratchpad) ###
-- ####################################
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- ####################################
-- ### 5. SCROLL ENTRE WORKSPACES ###
-- ####################################
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- ########################################
-- ### 6. DÉPLACER / REDIMENSIONNER ###
-- ########################################
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })   -- Déplacer fenêtre
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })   -- Redimensionner fenêtre

hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 30,  y = 0,  relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.resize({ x = -30, y = 0,  relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.resize({ x = 0,   y = -30, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.resize({ x = 0,   y = 30,  relative = true }), { repeating = true })
-- #####################################
-- ### 7. MULTIMÉDIA — VOLUME ###
-- #####################################
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true })

-- Luminosité
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),
    { locked = true, repeating = true })

-- ###########################################
-- ### 8. CONTRÔLES LECTURE MÉDIA ###
-- ###########################################
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),        { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),    { locked = true })
