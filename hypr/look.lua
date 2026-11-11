-- Оформление: закругления, тени, размытие, прозрачность
-- See https://wiki.hypr.land/Configuring/Basics/Variables/

local colors = require("matugen-colors")

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 5,

        border_size = 2,

        col = {
            active_border   = colors.colors.primary,
            inactive_border = colors.colors.primary_container,
        },

        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        active_opacity   = 0.97,
        inactive_opacity = 0.90,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = colors.colors.background,
        },

        blur = {
            enabled   = true,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})