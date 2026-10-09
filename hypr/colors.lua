-- Цветовая схема для Hyprland
-- Можно использовать в других файлах

local M = {}

-- Основные цвета
M.colors = {
    primary   = "rgba(33ccffee)",
    secondary = "rgba(00ff99ee)",
    inactive  = "rgba(595959aa)",
    shadow    = 0xee1a1a1a,
}

-- Цвета для бордеров
M.border = {
    active   = { colors = { M.colors.primary, M.colors.secondary }, angle = 45 },
    inactive = M.colors.inactive,
}

return M