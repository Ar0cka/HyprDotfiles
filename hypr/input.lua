-- Настройки ввода: клавиатура, мышь, тачпад
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/

hl.config({
    input = {
        kb_layout  = "us,ru",              -- Раскладки
        kb_variant = "",
        kb_model   = "",
        kb_options = "grp:win_space_toggle", -- Переключение по Win+Space
        kb_rules   = "",

        follow_mouse = 1,                   -- Фокус на окно при наведении

        sensitivity = 0,                    -- -1.0 до 1.0

        touchpad = {
            natural_scroll = false,
        },
    },
})

-- Жесты на тачпаде (3 пальца = переключение рабочего стола)
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- Настройки конкретного устройства
-- hl.device({
--     name        = "epic-mouse-v1",
--     sensitivity = -0.5,
-- })
