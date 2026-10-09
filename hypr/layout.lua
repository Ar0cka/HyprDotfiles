-- Настройки компоновок (Dwindle, Master, Scrolling)
-- See https://wiki.hypr.land/Configuring/Layouts/

-- Dwindle Layout
hl.config({
    dwindle = {
        preserve_split = true, -- Сохранять разделение при переключении окон
    },
})

-- Master Layout
hl.config({
    master = {
        new_status = "master", -- Новые окна становятся мастером
    },
})

-- Scrolling Layout
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
        column_width = 0.5,
    },
})

hl.workspace_rule({
    workspace = "2",
    layout = "scrolling"
})

hl.workspace_rule({
    workspace = "3",
    layout = "scrolling"
})
