-- Правила для окон и рабочих столов
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Игнорировать запросы на максимизацию (часто полезно)
local suppressMaximizeRule = hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

-- Исправление проблем с перетаскиванием в XWayland
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- Правило для лаунчера (hyprland-run)
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})

-- Примеры других полезных правил:
-- hl.window_rule({
--     name  = "float-spotify",
--     match = { class = "Spotify" },
--     float = true,
--     size  = "80% 80%",
-- })
--
-- hl.workspace_rule({
--     workspace = "1",
--     monitor   = "DP-1",
-- })

hl.workspace_rule({ workspace = "2", layout_opts = { direction = "right" } })