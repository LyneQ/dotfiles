-- =============================================================
-- plugin.lua — Configuration des plugins
-- Converted from hyprlang to Lua (Hyprland >= 0.55)
-- =============================================================
-- MIGRATION_NOTE : La syntaxe de configuration des plugins en Lua dépend
-- de chaque plugin. Consulte la doc de hyprbars et hyprtrails pour leur
-- API Lua spécifique.
--
-- La syntaxe ci-dessous utilise hl.plugin.config() qui est la forme générique
-- attendue — à adapter si les plugins exposent leurs propres fonctions Lua.
-- Voir aussi : https://wiki.hypr.land/Plugins/Development/Getting-Started/

-- ##############
-- ### HYPRBARS ###
-- ##############
hl.plugin.config("hyprbars", {
    bar_height              = 20,
    bar_text_font           = "JetBrainsMono Nerd Font",
    bar_text_size           = 10,
    bar_button_padding      = 5,
    bar_buttons_alignment   = "left",
    bar_precedence_over_border = true,
    bar_part_of_window      = true,
    inactive_button_color   = "rgba(46, 49, 51, 0)",
    icon_on_hover           = true,
    on_double_click         = "hyprctl dispatch fullscreen 1",

    -- hyprbars-button = color, size, icon, on-click
    -- MIGRATION_NOTE : La syntaxe des boutons en Lua peut différer.
    -- Consulte la doc de hyprbars pour la forme exacte.
    buttons = {
        { color = "rgb(eeee11)", size = 12, icon = "",    action = "hyprctl dispatch fullscreen 1" },
        { color = "rgb(ff4040)", size = 12, icon = "󰖭",   action = "hyprctl dispatch killactive" },
    },
})

-- ################
-- ### HYPRTRAILS ###
-- ################
hl.plugin.config("hyprtrails", {
    color = "rgba(e0e0e0dd)",
})
