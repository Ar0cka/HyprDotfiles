pragma Singleton
import QtQuick

QtObject {
    readonly property string name: "matugen theme"

    // ============================================================
    //  LIGHT MODE
    // ============================================================
    // Главный акцент: FAB, заполненные кнопки, активные вкладки, выделение, ссылки
    readonly property color lightPrimary: "{{colors.primary.light.hex}}"
    // Текст/иконки на primary
    readonly property color lightOnPrimary: "{{colors.on_primary.light.hex}}"
    // Мягкая акцентная заливка: тонированные кнопки, чипы, выделенные строки, badges
    readonly property color lightPrimaryContainer: "{{colors.primary_container.light.hex}}"
    // Текст/иконки на primaryContainer
    readonly property color lightOnPrimaryContainer: "{{colors.on_primary_container.light.hex}}"

    // Менее акцентные элементы: второстепенные кнопки, фильтры, переключатели, слайдеры
    readonly property color lightSecondary: "{{colors.secondary.light.hex}}"
    // Текст/иконки на secondary
    readonly property color lightOnSecondary: "{{colors.on_secondary.light.hex}}"
    // Мягкая вторичная заливка: второстепенные чипы, тонированные панели, сегменты
    readonly property color lightSecondaryContainer: "{{colors.secondary_container.light.hex}}"
    // Текст/иконки на secondaryContainer
    readonly property color lightOnSecondaryContainer: "{{colors.on_secondary_container.light.hex}}"

    // Контрастный акцент для баланса: декоративные бейджи, выделение, статусы
    readonly property color lightTertiary: "{{colors.tertiary.light.hex}}"
    // Текст/иконки на tertiary
    readonly property color lightOnTertiary: "{{colors.on_tertiary.light.hex}}"
    // Мягкая третичная заливка: декоративные панели, badges, бейджи
    readonly property color lightTertiaryContainer: "{{colors.tertiary_container.light.hex}}"
    // Текст/иконки на tertiaryContainer
    readonly property color lightOnTertiaryContainer: "{{colors.on_tertiary_container.light.hex}}"

    // Ошибки и деструктивные действия: удаление, предупреждения, валидация, danger-кнопки
    readonly property color lightError: "{{colors.error.light.hex}}"
    // Текст/иконки на error
    readonly property color lightOnError: "{{colors.on_error.light.hex}}"
    // Мягкий фон ошибки: баннеры, поля с ошибкой, алерты, тосты
    readonly property color lightErrorContainer: "{{colors.error_container.light.hex}}"
    // Текст/иконки на errorContainer
    readonly property color lightOnErrorContainer: "{{colors.on_error_container.light.hex}}"

    // Фон окна/приложения (в M3 устаревает в пользу surface)
    readonly property color lightBackground: "{{colors.background.light.hex}}"
    // Основной текст/иконки на фоне окна
    readonly property color lightOnBackground: "{{colors.on_background.light.hex}}"

    // Основная поверхность: карточки, диалоги, меню, панели, popup
    readonly property color lightSurface: "{{colors.surface.light.hex}}"
    // Основной текст/иконки на поверхности
    readonly property color lightOnSurface: "{{colors.on_surface.light.hex}}"
    // Альтернативная поверхность: разделители, тонированные области, input-поля
    readonly property color lightSurfaceVariant: "{{colors.surface_variant.light.hex}}"
    // Средне-акцентный текст/иконки: подписи, placeholder, subtitle, hint
    readonly property color lightOnSurfaceVariant: "{{colors.on_surface_variant.light.hex}}"
    // Затемнённая поверхность (устаревает, используйте surfaceContainer*)
    readonly property color lightSurfaceDim: "{{colors.surface_dim.light.hex}}"
    // Осветлённая поверхность (устаревает, используйте surfaceContainer*)
    readonly property color lightSurfaceBright: "{{colors.surface_bright.light.hex}}"

    // Наименее акцентный контейнер: подложки, поля ввода, фоновые секции
    readonly property color lightSurfaceContainerLowest: "{{colors.surface_container_lowest.light.hex}}"
    // Слабо акцентный контейнер: карточки, панели, sidebar
    readonly property color lightSurfaceContainerLow: "{{colors.surface_container_low.light.hex}}"
    // Базовый контейнер: карточки, sheets, popup, группы настроек
    readonly property color lightSurfaceContainer: "{{colors.surface_container.light.hex}}"
    // Акцентный контейнер: меню, навигационные панели, диалоги
    readonly property color lightSurfaceContainerHigh: "{{colors.surface_container_high.light.hex}}"
    // Наивысший акцент: заполненные поля, tooltip, модалки, hover-состояния
    readonly property color lightSurfaceContainerHighest: "{{colors.surface_container_highest.light.hex}}"

    // Границы и разделители: обводки полей, границы карточек, рамки кнопок
    readonly property color lightOutline: "{{colors.outline.light.hex}}"
    // Декоративные разделители: тонкие линии, dividers, слабые рамки
    readonly property color lightOutlineVariant: "{{colors.outline_variant.light.hex}}"
    // Цвет теней: elevation, оверлеи, drop shadow
    readonly property color lightShadow: "{{colors.shadow.light.hex}}"
    // Затемнение под модалками: диалоги, bottom sheets, drawers
    readonly property color lightScrim: "{{colors.scrim.light.hex}}"

    // Инверсная поверхность: Snackbar, тосты, всплывающие уведомления
    readonly property color lightInverseSurface: "{{colors.inverse_surface.light.hex}}"
    // Текст/иконки на inverseSurface
    readonly property color lightInverseOnSurface: "{{colors.inverse_on_surface.light.hex}}"
    // Акцент на inverseSurface: кнопки в Snackbar, ссылки в тостах
    readonly property color lightInversePrimary: "{{colors.inverse_primary.light.hex}}"

    // Фиксированный primary (не меняется в тёмной теме): брендовые элементы, оверлеи
    readonly property color lightPrimaryFixed: "{{colors.primary_fixed.light.hex}}"
    // Приглушённый fixed primary: менее акцентные фиксированные элементы
    readonly property color lightPrimaryFixedDim: "{{colors.primary_fixed_dim.light.hex}}"
    // Текст/иконки на primaryFixed
    readonly property color lightOnPrimaryFixed: "{{colors.on_primary_fixed.light.hex}}"
    // Слабо акцентный текст/иконки на primaryFixed
    readonly property color lightOnPrimaryFixedVariant: "{{colors.on_primary_fixed_variant.light.hex}}"

    // Фиксированный secondary (не меняется в тёмной теме)
    readonly property color lightSecondaryFixed: "{{colors.secondary_fixed.light.hex}}"
    // Приглушённый fixed secondary
    readonly property color lightSecondaryFixedDim: "{{colors.secondary_fixed_dim.light.hex}}"
    // Текст/иконки на secondaryFixed
    readonly property color lightOnSecondaryFixed: "{{colors.on_secondary_fixed.light.hex}}"
    // Слабо акцентный текст/иконки на secondaryFixed
    readonly property color lightOnSecondaryFixedVariant: "{{colors.on_secondary_fixed_variant.light.hex}}"

    // Фиксированный tertiary (не меняется в тёмной теме)
    readonly property color lightTertiaryFixed: "{{colors.tertiary_fixed.light.hex}}"
    // Приглушённый fixed tertiary
    readonly property color lightTertiaryFixedDim: "{{colors.tertiary_fixed_dim.light.hex}}"
    // Текст/иконки на tertiaryFixed
    readonly property color lightOnTertiaryFixed: "{{colors.on_tertiary_fixed.light.hex}}"
    // Слабо акцентный текст/иконки на tertiaryFixed
    readonly property color lightOnTertiaryFixedVariant: "{{colors.on_tertiary_fixed_variant.light.hex}}"

    // ============================================================
    //  DARK MODE
    // ============================================================
    // Главный акцент: FAB, заполненные кнопки, активные вкладки, выделение, ссылки
    readonly property color darkPrimary: "{{colors.primary.dark.hex}}"
    // Текст/иконки на primary
    readonly property color darkOnPrimary: "{{colors.on_primary.dark.hex}}"
    // Мягкая акцентная заливка: тонированные кнопки, чипы, выделенные строки, badges
    readonly property color darkPrimaryContainer: "{{colors.primary_container.dark.hex}}"
    // Текст/иконки на primaryContainer
    readonly property color darkOnPrimaryContainer: "{{colors.on_primary_container.dark.hex}}"

    // Менее акцентные элементы: второстепенные кнопки, фильтры, переключатели, слайдеры
    readonly property color darkSecondary: "{{colors.secondary.dark.hex}}"
    // Текст/иконки на secondary
    readonly property color darkOnSecondary: "{{colors.on_secondary.dark.hex}}"
    // Мягкая вторичная заливка: второстепенные чипы, тонированные панели, сегменты
    readonly property color darkSecondaryContainer: "{{colors.secondary_container.dark.hex}}"
    // Текст/иконки на secondaryContainer
    readonly property color darkOnSecondaryContainer: "{{colors.on_secondary_container.dark.hex}}"

    // Контрастный акцент для баланса: декоративные бейджи, выделение, статусы
    readonly property color darkTertiary: "{{colors.tertiary.dark.hex}}"
    // Текст/иконки на tertiary
    readonly property color darkOnTertiary: "{{colors.on_tertiary.dark.hex}}"
    // Мягкая третичная заливка: декоративные панели, badges, бейджи
    readonly property color darkTertiaryContainer: "{{colors.tertiary_container.dark.hex}}"
    // Текст/иконки на tertiaryContainer
    readonly property color darkOnTertiaryContainer: "{{colors.on_tertiary_container.dark.hex}}"

    // Ошибки и деструктивные действия: удаление, предупреждения, валидация, danger-кнопки
    readonly property color darkError: "{{colors.error.dark.hex}}"
    // Текст/иконки на error
    readonly property color darkOnError: "{{colors.on_error.dark.hex}}"
    // Мягкий фон ошибки: баннеры, поля с ошибкой, алерты, тосты
    readonly property color darkErrorContainer: "{{colors.error_container.dark.hex}}"
    // Текст/иконки на errorContainer
    readonly property color darkOnErrorContainer: "{{colors.on_error_container.dark.hex}}"

    // Фон окна/приложения (в M3 устаревает в пользу surface)
    readonly property color darkBackground: "{{colors.background.dark.hex}}"
    // Основной текст/иконки на фоне окна
    readonly property color darkOnBackground: "{{colors.on_background.dark.hex}}"

    // Основная поверхность: карточки, диалоги, меню, панели, popup
    readonly property color darkSurface: "{{colors.surface.dark.hex}}"
    // Основной текст/иконки на поверхности
    readonly property color darkOnSurface: "{{colors.on_surface.dark.hex}}"
    // Альтернативная поверхность: разделители, тонированные области, input-поля
    readonly property color darkSurfaceVariant: "{{colors.surface_variant.dark.hex}}"
    // Средне-акцентный текст/иконки: подписи, placeholder, subtitle, hint
    readonly property color darkOnSurfaceVariant: "{{colors.on_surface_variant.dark.hex}}"
    // Затемнённая поверхность (устаревает, используйте surfaceContainer*)
    readonly property color darkSurfaceDim: "{{colors.surface_dim.dark.hex}}"
    // Осветлённая поверхность (устаревает, используйте surfaceContainer*)
    readonly property color darkSurfaceBright: "{{colors.surface_bright.dark.hex}}"

    // Наименее акцентный контейнер: подложки, поля ввода, фоновые секции
    readonly property color darkSurfaceContainerLowest: "{{colors.surface_container_lowest.dark.hex}}"
    // Слабо акцентный контейнер: карточки, панели, sidebar
    readonly property color darkSurfaceContainerLow: "{{colors.surface_container_low.dark.hex}}"
    // Базовый контейнер: карточки, sheets, popup, группы настроек
    readonly property color darkSurfaceContainer: "{{colors.surface_container.dark.hex}}"
    // Акцентный контейнер: меню, навигационные панели, диалоги
    readonly property color darkSurfaceContainerHigh: "{{colors.surface_container_high.dark.hex}}"
    // Наивысший акцент: заполненные поля, tooltip, модалки, hover-состояния
    readonly property color darkSurfaceContainerHighest: "{{colors.surface_container_highest.dark.hex}}"

    // Границы и разделители: обводки полей, границы карточек, рамки кнопок
    readonly property color darkOutline: "{{colors.outline.dark.hex}}"
    // Декоративные разделители: тонкие линии, dividers, слабые рамки
    readonly property color darkOutlineVariant: "{{colors.outline_variant.dark.hex}}"
    // Цвет теней: elevation, оверлеи, drop shadow
    readonly property color darkShadow: "{{colors.shadow.dark.hex}}"
    // Затемнение под модалками: диалоги, bottom sheets, drawers
    readonly property color darkScrim: "{{colors.scrim.dark.hex}}"

    // Инверсная поверхность: Snackbar, тосты, всплывающие уведомления
    readonly property color darkInverseSurface: "{{colors.inverse_surface.dark.hex}}"
    // Текст/иконки на inverseSurface
    readonly property color darkInverseOnSurface: "{{colors.inverse_on_surface.dark.hex}}"
    // Акцент на inverseSurface: кнопки в Snackbar, ссылки в тостах
    readonly property color darkInversePrimary: "{{colors.inverse_primary.dark.hex}}"

    // Фиксированный primary (не меняется в светлой теме): брендовые элементы, оверлеи
    readonly property color darkPrimaryFixed: "{{colors.primary_fixed.dark.hex}}"
    // Приглушённый fixed primary: менее акцентные фиксированные элементы
    readonly property color darkPrimaryFixedDim: "{{colors.primary_fixed_dim.dark.hex}}"
    // Текст/иконки на primaryFixed
    readonly property color darkOnPrimaryFixed: "{{colors.on_primary_fixed.dark.hex}}"
    // Слабо акцентный текст/иконки на primaryFixed
    readonly property color darkOnPrimaryFixedVariant: "{{colors.on_primary_fixed_variant.dark.hex}}"

    // Фиксированный secondary (не меняется в светлой теме)
    readonly property color darkSecondaryFixed: "{{colors.secondary_fixed.dark.hex}}"
    // Приглушённый fixed secondary
    readonly property color darkSecondaryFixedDim: "{{colors.secondary_fixed_dim.dark.hex}}"
    // Текст/иконки на secondaryFixed
    readonly property color darkOnSecondaryFixed: "{{colors.on_secondary_fixed.dark.hex}}"
    // Слабо акцентный текст/иконки на secondaryFixed
    readonly property color darkOnSecondaryFixedVariant: "{{colors.on_secondary_fixed_variant.dark.hex}}"

    // Фиксированный tertiary (не меняется в светлой теме)
    readonly property color darkTertiaryFixed: "{{colors.tertiary_fixed.dark.hex}}"
    // Приглушённый fixed tertiary
    readonly property color darkTertiaryFixedDim: "{{colors.tertiary_fixed_dim.dark.hex}}"
    // Текст/иконки на tertiaryFixed
    readonly property color darkOnTertiaryFixed: "{{colors.on_tertiary_fixed.dark.hex}}"
    // Слабо акцентный текст/иконки на tertiaryFixed
    readonly property color darkOnTertiaryFixedVariant: "{{colors.on_tertiary_fixed_variant.dark.hex}}"

    // ============================================================
    //  AMOLED (только фон меняем на чистый чёрный; остальное = dark)
    // ============================================================
    // Чистый чёрный фон окна для OLED-экономии
    readonly property color amoledBackground: "#000000"
    // Основной текст/иконки на чёрном фоне
    readonly property color amoledOnBackground: "{{colors.on_background.dark.hex}}"
    // Чистая чёрная поверхность для OLED
    readonly property color amoledSurface: "#000000"
    // Основной текст/иконки на чёрной поверхности
    readonly property color amoledOnSurface: "{{colors.on_surface.dark.hex}}"
    // Наименее акцентный контейнер: чистый чёрный для подложек
    readonly property color amoledSurfaceContainerLowest: "#000000"
    // Слабо акцентный контейнер: карточки, панели, sidebar
    readonly property color amoledSurfaceContainerLow: "{{colors.surface_container_low.dark.hex}}"
    // Базовый контейнер: карточки, sheets, popup, группы настроек
    readonly property color amoledSurfaceContainer: "{{colors.surface_container.dark.hex}}"
    // Акцентный контейнер: меню, навигационные панели, диалоги
    readonly property color amoledSurfaceContainerHigh: "{{colors.surface_container_high.dark.hex}}"
    // Наивысший акцент: заполненные поля, tooltip, модалки, hover-состояния
    readonly property color amoledSurfaceContainerHighest: "{{colors.surface_container_highest.dark.hex}}"
    // Границы и разделители: обводки полей, границы карточек, рамки кнопок
    readonly property color amoledOutline: "{{colors.outline.dark.hex}}"
    // Декоративные разделители: тонкие линии, dividers, слабые рамки
    readonly property color amoledOutlineVariant: "{{colors.outline_variant.dark.hex}}"
    // Главный акцент: FAB, заполненные кнопки, активные вкладки, выделение
    readonly property color amoledPrimary: "{{colors.primary.dark.hex}}"
    // Текст/иконки на primary
    readonly property color amoledOnPrimary: "{{colors.on_primary.dark.hex}}"
    // Мягкая акцентная заливка: тонированные кнопки, чипы, badges
    readonly property color amoledPrimaryContainer: "{{colors.primary_container.dark.hex}}"
    // Текст/иконки на primaryContainer
    readonly property color amoledOnPrimaryContainer: "{{colors.on_primary_container.dark.hex}}"
    // Ошибки и деструктивные действия
    readonly property color amoledError: "{{colors.error.dark.hex}}"
    // Текст/иконки на error
    readonly property color amoledOnError: "{{colors.on_error.dark.hex}}"
}
