-- Настройки мониторов
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.monitor({
    output   = "",              -- Оставьте пустым для автовыбора
    mode     = "preferred",     -- "preferred", "1920x1080@60" и т.д.
    position = "auto",          -- "auto" или "x,y"
    scale    = "auto",          -- "auto" или число (1, 1.5, 2)
})

-- Пример для нескольких мониторов:
-- hl.monitor({
--     output   = "DP-1",
--     mode     = "1920x1080@144",
--     position = "0,0",
--     scale    = 1,
-- })
--
-- hl.monitor({
--     output   = "HDMI-A-1",
--     mode     = "1920x1080@60",
--     position = "1920,0",
--     scale    = 1,
-- })