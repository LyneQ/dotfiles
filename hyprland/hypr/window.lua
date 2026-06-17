-- =============================================================
-- window.lua — Règles de fenêtres
-- Converted from hyprlang to Lua (Hyprland >= 0.55)
-- =============================================================
-- Voir : https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- Ignorer les requêtes de maximize de toutes les applis
hl.window_rule({
    name           = "windowrule-1",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

-- Corriger les problèmes de drag XWayland
hl.window_rule({
    name       = "windowrule-2",
    match      = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus   = true,
})

-- Désactiver le blur pour Thunar
hl.window_rule({
    name    = "windowrule-3",
    match   = { class = "^(thunar)$", title = "^()$" },
    no_blur = true,
})

-- Picture-in-Picture → floating
hl.window_rule({
    name  = "windowrule-4",
    match = { title = ".*Picture-in-Picture.*" },
    float = true,
})
hl.window_rule({
    name  = "windowrule-5",
    match = { title = ".*PIP.*" },
    float = true,
})
hl.window_rule({
    name  = "windowrule-6",
    match = { title = ".*Picture in picture.*" },
    float = true,
})

-- Fenêtres en floating par défaut
hl.window_rule({ name = "windowrule-7",  match = { class = "^(MuPDF)$" },              float = true })
hl.window_rule({ name = "windowrule-8",  match = { class = "^(org.kde.ark)$" },         float = true })
hl.window_rule({ name = "windowrule-9",  match = { class = "^(org.kde.kcalc)$" },       float = true })
hl.window_rule({ name = "windowrule-10", match = { class = "^(HyprSettings)$" },        float = true })
hl.window_rule({ name = "windowrule-11", match = { class = "^(org.twosheds.iwgtk)$" },  float = true })
hl.window_rule({ name = "windowrule-12", match = { class = "^(imv)$" },                 float = true })

-- IntelliJ IDEA — Welcome screen en floating, taille fixe
-- MIGRATION_NOTE : Vérifie le format de `size` sur le wiki si besoin (peut être { w, h }).
hl.window_rule({
    name  = "windowrule-13",
    match = {
        class = "^(jetbrains-idea)$",
        title = "^(Welcome to IntelliJ IDEA)$",
    },
    float = true,
    size  = "800 400",
})

-- Render
hl.config({
    render = {
        direct_scanout = true,
    },
})

-- set discord to workspace 2 when opened
hl.window_rule({
  name      = "discord-workspace",
  match     = { class = "^(discord)$" },
  workspace = "2 silent"
})
