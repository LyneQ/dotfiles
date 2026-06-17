-- =============================================================
-- input.lua — Clavier, souris, touchpad
-- Converted from hyprlang to Lua (Hyprland >= 0.55)
-- =============================================================
-- Voir : https://wiki.hypr.land/Configuring/Basics/Variables/

hl.config({
    input = {
        kb_layout  = "myus,us",
        kb_variant = "intl_notilde,",  -- layout custom + US standard
        kb_model   = "",
        kb_rules   = "",
        kb_options = "",

        follow_mouse   = 1,
        force_no_accel = 0,
        sensitivity    = -0.75,        -- -1.0 à 1.0, 0 = pas de modification

        touchpad = {
            natural_scroll = false,
        },
    },

    gestures = {
        -- workspace_swipe = false,
    },

    -- Exemple de config par appareil (décommente et adapte si besoin) :
    -- device = {
    --     name        = "epic-mouse-v1",
    --     sensitivity = -0.5,
    -- },
})
