pragma Singleton
import QtQuick

QtObject {
    readonly property string name: "matugen theme"

    // ============================================================
    //  LIGHT MODE
    // ============================================================
    // Главный акцент: FAB, заполненные кнопки, активные вкладки, выделение, ссылки
    readonly property color lightPrimary: "#3c6090"
    // Текст/иконки на primary
    readonly property color lightOnPrimary: "#ffffff"
    // Мягкая акцентная заливка: тонированные кнопки, чипы, выделенные строки, badges
    readonly property color lightPrimaryContainer: "#d4e3ff"
    // Текст/иконки на primaryContainer
    readonly property color lightOnPrimaryContainer: "#001c3a"

    // Менее акцентные элементы: второстепенные кнопки, фильтры, переключатели, слайдеры
    readonly property color lightSecondary: "#545f71"
    // Текст/иконки на secondary
    readonly property color lightOnSecondary: "#ffffff"
    // Мягкая вторичная заливка: второстепенные чипы, тонированные панели, сегменты
    readonly property color lightSecondaryContainer: "#d8e3f8"
    // Текст/иконки на secondaryContainer
    readonly property color lightOnSecondaryContainer: "#111c2b"

    // Контрастный акцент для баланса: декоративные бейджи, выделение, статусы
    readonly property color lightTertiary: "#6e5676"
    // Текст/иконки на tertiary
    readonly property color lightOnTertiary: "#ffffff"
    // Мягкая третичная заливка: декоративные панели, badges, бейджи
    readonly property color lightTertiaryContainer: "#f7d8ff"
    // Текст/иконки на tertiaryContainer
    readonly property color lightOnTertiaryContainer: "#271430"

    // Ошибки и деструктивные действия: удаление, предупреждения, валидация, danger-кнопки
    readonly property color lightError: "#ba1a1a"
    // Текст/иконки на error
    readonly property color lightOnError: "#ffffff"
    // Мягкий фон ошибки: баннеры, поля с ошибкой, алерты, тосты
    readonly property color lightErrorContainer: "#ffdad6"
    // Текст/иконки на errorContainer
    readonly property color lightOnErrorContainer: "#410002"

    // Фон окна/приложения (в M3 устаревает в пользу surface)
    readonly property color lightBackground: "#f9f9ff"
    // Основной текст/иконки на фоне окна
    readonly property color lightOnBackground: "#191c20"

    // Основная поверхность: карточки, диалоги, меню, панели, popup
    readonly property color lightSurface: "#f9f9ff"
    // Основной текст/иконки на поверхности
    readonly property color lightOnSurface: "#191c20"
    // Альтернативная поверхность: разделители, тонированные области, input-поля
    readonly property color lightSurfaceVariant: "#e0e2ec"
    // Средне-акцентный текст/иконки: подписи, placeholder, subtitle, hint
    readonly property color lightOnSurfaceVariant: "#43474e"
    // Затемнённая поверхность (устаревает, используйте surfaceContainer*)
    readonly property color lightSurfaceDim: "#d9dae0"
    // Осветлённая поверхность (устаревает, используйте surfaceContainer*)
    readonly property color lightSurfaceBright: "#f9f9ff"

    // Наименее акцентный контейнер: подложки, поля ввода, фоновые секции
    readonly property color lightSurfaceContainerLowest: "#ffffff"
    // Слабо акцентный контейнер: карточки, панели, sidebar
    readonly property color lightSurfaceContainerLow: "#f2f3fa"
    // Базовый контейнер: карточки, sheets, popup, группы настроек
    readonly property color lightSurfaceContainer: "#ededf4"
    // Акцентный контейнер: меню, навигационные панели, диалоги
    readonly property color lightSurfaceContainerHigh: "#e7e8ee"
    // Наивысший акцент: заполненные поля, tooltip, модалки, hover-состояния
    readonly property color lightSurfaceContainerHighest: "#e1e2e9"

    // Границы и разделители: обводки полей, границы карточек, рамки кнопок
    readonly property color lightOutline: "#74777f"
    // Декоративные разделители: тонкие линии, dividers, слабые рамки
    readonly property color lightOutlineVariant: "#c3c6cf"
    // Цвет теней: elevation, оверлеи, drop shadow
    readonly property color lightShadow: "#000000"
    // Затемнение под модалками: диалоги, bottom sheets, drawers
    readonly property color lightScrim: "#000000"

    // Инверсная поверхность: Snackbar, тосты, всплывающие уведомления
    readonly property color lightInverseSurface: "#2e3035"
    // Текст/иконки на inverseSurface
    readonly property color lightInverseOnSurface: "#f0f0f7"
    // Акцент на inverseSurface: кнопки в Snackbar, ссылки в тостах
    readonly property color lightInversePrimary: "#a5c8ff"

    // Фиксированный primary (не меняется в тёмной теме): брендовые элементы, оверлеи
    readonly property color lightPrimaryFixed: "#d4e3ff"
    // Приглушённый fixed primary: менее акцентные фиксированные элементы
    readonly property color lightPrimaryFixedDim: "#a5c8ff"
    // Текст/иконки на primaryFixed
    readonly property color lightOnPrimaryFixed: "#001c3a"
    // Слабо акцентный текст/иконки на primaryFixed
    readonly property color lightOnPrimaryFixedVariant: "#224876"

    // Фиксированный secondary (не меняется в тёмной теме)
    readonly property color lightSecondaryFixed: "#d8e3f8"
    // Приглушённый fixed secondary
    readonly property color lightSecondaryFixedDim: "#bcc7dc"
    // Текст/иконки на secondaryFixed
    readonly property color lightOnSecondaryFixed: "#111c2b"
    // Слабо акцентный текст/иконки на secondaryFixed
    readonly property color lightOnSecondaryFixedVariant: "#3d4758"

    // Фиксированный tertiary (не меняется в тёмной теме)
    readonly property color lightTertiaryFixed: "#f7d8ff"
    // Приглушённый fixed tertiary
    readonly property color lightTertiaryFixedDim: "#dabde2"
    // Текст/иконки на tertiaryFixed
    readonly property color lightOnTertiaryFixed: "#271430"
    // Слабо акцентный текст/иконки на tertiaryFixed
    readonly property color lightOnTertiaryFixedVariant: "#553f5d"

    // ============================================================
    //  DARK MODE
    // ============================================================
    // Главный акцент: FAB, заполненные кнопки, активные вкладки, выделение, ссылки
    readonly property color darkPrimary: "#a5c8ff"
    // Текст/иконки на primary
    readonly property color darkOnPrimary: "#00315e"
    // Мягкая акцентная заливка: тонированные кнопки, чипы, выделенные строки, badges
    readonly property color darkPrimaryContainer: "#224876"
    // Текст/иконки на primaryContainer
    readonly property color darkOnPrimaryContainer: "#d4e3ff"

    // Менее акцентные элементы: второстепенные кнопки, фильтры, переключатели, слайдеры
    readonly property color darkSecondary: "#bcc7dc"
    // Текст/иконки на secondary
    readonly property color darkOnSecondary: "#273141"
    // Мягкая вторичная заливка: второстепенные чипы, тонированные панели, сегменты
    readonly property color darkSecondaryContainer: "#3d4758"
    // Текст/иконки на secondaryContainer
    readonly property color darkOnSecondaryContainer: "#d8e3f8"

    // Контрастный акцент для баланса: декоративные бейджи, выделение, статусы
    readonly property color darkTertiary: "#dabde2"
    // Текст/иконки на tertiary
    readonly property color darkOnTertiary: "#3d2946"
    // Мягкая третичная заливка: декоративные панели, badges, бейджи
    readonly property color darkTertiaryContainer: "#553f5d"
    // Текст/иконки на tertiaryContainer
    readonly property color darkOnTertiaryContainer: "#f7d8ff"

    // Ошибки и деструктивные действия: удаление, предупреждения, валидация, danger-кнопки
    readonly property color darkError: "#ffb4ab"
    // Текст/иконки на error
    readonly property color darkOnError: "#690005"
    // Мягкий фон ошибки: баннеры, поля с ошибкой, алерты, тосты
    readonly property color darkErrorContainer: "#93000a"
    // Текст/иконки на errorContainer
    readonly property color darkOnErrorContainer: "#ffdad6"

    // Фон окна/приложения (в M3 устаревает в пользу surface)
    readonly property color darkBackground: "#111318"
    // Основной текст/иконки на фоне окна
    readonly property color darkOnBackground: "#e1e2e9"

    // Основная поверхность: карточки, диалоги, меню, панели, popup
    readonly property color darkSurface: "#111318"
    // Основной текст/иконки на поверхности
    readonly property color darkOnSurface: "#e1e2e9"
    // Альтернативная поверхность: разделители, тонированные области, input-поля
    readonly property color darkSurfaceVariant: "#43474e"
    // Средне-акцентный текст/иконки: подписи, placeholder, subtitle, hint
    readonly property color darkOnSurfaceVariant: "#c3c6cf"
    // Затемнённая поверхность (устаревает, используйте surfaceContainer*)
    readonly property color darkSurfaceDim: "#111318"
    // Осветлённая поверхность (устаревает, используйте surfaceContainer*)
    readonly property color darkSurfaceBright: "#37393e"

    // Наименее акцентный контейнер: подложки, поля ввода, фоновые секции
    readonly property color darkSurfaceContainerLowest: "#0c0e13"
    // Слабо акцентный контейнер: карточки, панели, sidebar
    readonly property color darkSurfaceContainerLow: "#191c20"
    // Базовый контейнер: карточки, sheets, popup, группы настроек
    readonly property color darkSurfaceContainer: "#1d2024"
    // Акцентный контейнер: меню, навигационные панели, диалоги
    readonly property color darkSurfaceContainerHigh: "#282a2f"
    // Наивысший акцент: заполненные поля, tooltip, модалки, hover-состояния
    readonly property color darkSurfaceContainerHighest: "#32353a"

    // Границы и разделители: обводки полей, границы карточек, рамки кнопок
    readonly property color darkOutline: "#8d9199"
    // Декоративные разделители: тонкие линии, dividers, слабые рамки
    readonly property color darkOutlineVariant: "#43474e"
    // Цвет теней: elevation, оверлеи, drop shadow
    readonly property color darkShadow: "#000000"
    // Затемнение под модалками: диалоги, bottom sheets, drawers
    readonly property color darkScrim: "#000000"

    // Инверсная поверхность: Snackbar, тосты, всплывающие уведомления
    readonly property color darkInverseSurface: "#e1e2e9"
    // Текст/иконки на inverseSurface
    readonly property color darkInverseOnSurface: "#2e3035"
    // Акцент на inverseSurface: кнопки в Snackbar, ссылки в тостах
    readonly property color darkInversePrimary: "#3c6090"

    // Фиксированный primary (не меняется в светлой теме): брендовые элементы, оверлеи
    readonly property color darkPrimaryFixed: "#d4e3ff"
    // Приглушённый fixed primary: менее акцентные фиксированные элементы
    readonly property color darkPrimaryFixedDim: "#a5c8ff"
    // Текст/иконки на primaryFixed
    readonly property color darkOnPrimaryFixed: "#001c3a"
    // Слабо акцентный текст/иконки на primaryFixed
    readonly property color darkOnPrimaryFixedVariant: "#224876"

    // Фиксированный secondary (не меняется в светлой теме)
    readonly property color darkSecondaryFixed: "#d8e3f8"
    // Приглушённый fixed secondary
    readonly property color darkSecondaryFixedDim: "#bcc7dc"
    // Текст/иконки на secondaryFixed
    readonly property color darkOnSecondaryFixed: "#111c2b"
    // Слабо акцентный текст/иконки на secondaryFixed
    readonly property color darkOnSecondaryFixedVariant: "#3d4758"

    // Фиксированный tertiary (не меняется в светлой теме)
    readonly property color darkTertiaryFixed: "#f7d8ff"
    // Приглушённый fixed tertiary
    readonly property color darkTertiaryFixedDim: "#dabde2"
    // Текст/иконки на tertiaryFixed
    readonly property color darkOnTertiaryFixed: "#271430"
    // Слабо акцентный текст/иконки на tertiaryFixed
    readonly property color darkOnTertiaryFixedVariant: "#553f5d"

    // ============================================================
    //  AMOLED (только фон меняем на чистый чёрный; остальное = dark)
    // ============================================================
    // Чистый чёрный фон окна для OLED-экономии
    readonly property color amoledBackground: "#000000"
    // Основной текст/иконки на чёрном фоне
    readonly property color amoledOnBackground: "#e1e2e9"
    // Чистая чёрная поверхность для OLED
    readonly property color amoledSurface: "#000000"
    // Основной текст/иконки на чёрной поверхности
    readonly property color amoledOnSurface: "#e1e2e9"
    // Наименее акцентный контейнер: чистый чёрный для подложек
    readonly property color amoledSurfaceContainerLowest: "#000000"
    // Слабо акцентный контейнер: карточки, панели, sidebar
    readonly property color amoledSurfaceContainerLow: "#191c20"
    // Базовый контейнер: карточки, sheets, popup, группы настроек
    readonly property color amoledSurfaceContainer: "#1d2024"
    // Акцентный контейнер: меню, навигационные панели, диалоги
    readonly property color amoledSurfaceContainerHigh: "#282a2f"
    // Наивысший акцент: заполненные поля, tooltip, модалки, hover-состояния
    readonly property color amoledSurfaceContainerHighest: "#32353a"
    // Границы и разделители: обводки полей, границы карточек, рамки кнопок
    readonly property color amoledOutline: "#8d9199"
    // Декоративные разделители: тонкие линии, dividers, слабые рамки
    readonly property color amoledOutlineVariant: "#43474e"
    // Главный акцент: FAB, заполненные кнопки, активные вкладки, выделение
    readonly property color amoledPrimary: "#a5c8ff"
    // Текст/иконки на primary
    readonly property color amoledOnPrimary: "#00315e"
    // Мягкая акцентная заливка: тонированные кнопки, чипы, badges
    readonly property color amoledPrimaryContainer: "#224876"
    // Текст/иконки на primaryContainer
    readonly property color amoledOnPrimaryContainer: "#d4e3ff"
    // Ошибки и деструктивные действия
    readonly property color amoledError: "#ffb4ab"
    // Текст/иконки на error
    readonly property color amoledOnError: "#690005"
}
