#!/bin/bash

# ==============================================================================
# Arch Linux Hyprland Setup Script
# Ориентирован на чистую систему Arch Linux
# ==============================================================================

set -e # Прерывать выполнение при любой ошибке

# --- Цвета для вывода ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# --- Переменные ---
REPO_DIR="$HOME/repositor"
DOTFILES_DIR="$REPO_DIR/HyprDotfiles"
USER_HOME="$HOME"

echo -e "${BLUE}=== Начало установки компонентов ===${NC}"

# ==============================================================================
# === Опциональная настройка Reflector (выбор лучших зеркал) ===
# ==============================================================================
echo -e "${YELLOW}=== Настройка Reflector (зеркала pacman) ===${NC}"
read -p "Хотите установить reflector и выбрать лучшие зеркала? (y/n): " setup_reflector

if [[ "$setup_reflector" =~ ^[Yy]$ ]]; then
    echo -e "${BLUE}Установка reflector...${NC}"
    sudo pacman -S --needed --noconfirm reflector

    # Делаем резервную копию текущего списка зеркал (рекомендуется Arch Wiki)
    if [ ! -f /etc/pacman.d/mirrorlist.backup ]; then
        echo -e "Создание резервной копии mirrorlist..."
        sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
    else
        echo -e "Резервная копия уже существует, пропускаем."
    fi

    # Выбираем лучшие зеркала:
    # --latest 20       - 20 самых свежих зеркал
    # --protocol https  - только HTTPS (безопаснее)
    # --age 12          - только зеркала, синхронизированные за последние 12 часов
    # --sort rate       - сортировка по скорости загрузки
    # --save            - сохранить результат в mirrorlist
    echo -e "${BLUE}Поиск и сортировка зеркал (может занять время)...${NC}"
    sudo reflector --latest 20 --protocol https --age 12 --sort rate --save /etc/pacman.d/mirrorlist

    echo -e "${GREEN}Зеркала обновлены и отсортированы по скорости.${NC}"

    # Принудительное обновление баз данных pacman после смены зеркал
    echo -e "Обновление баз данных pacman..."
    sudo pacman -Syy

    echo -e "${GREEN}Reflector настроен.${NC}"
else
    echo -e "${YELLOW}Настройка зеркал пропущена. Используются зеркала по умолчанию.${NC}"
fi

# 1. Установка компонентов
# ------------------------------------------------------------------------------
# Флаг --needed предотвращает переустановку уже имеющихся пакетов.
# - base-devel и git нужны для сборки пакетов из AUR (для yay).
# - Hyprland и компоненты Wayland.
# - Шрифты: noto-fonts (базовые), noto-fonts-emoji (смайлики).
# - pipewire и сопутствующие для звука.
# - xdg-desktop-portal-hyprland нужен для трансляций экрана (Discord).
sudo pacman -S --needed --noconfirm \
    git base-devel \
    sddm \
    hyprland \
    kitty \
    rofi \
    waybar \
    dolphin \
    hyprpaper \
    pipewire pipewire-alsa pipewire-pulse pipewire-jack wireplumber \
    xdg-desktop-portal-hyprland \
    discord \
    noto-fonts noto-fonts-emoji \
    qt6-declarative qt6-5compat qt6-svg qt6-multimedia qt6-multimedia-ffmpeg \
    gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly \
    fzf

echo -e "${GREEN}Компоненты установлены.${NC}"

# 2. Выбор драйвера видеокарты
# ------------------------------------------------------------------------------
echo -e "${YELLOW}=== Выбор драйвера видеокарты ===${NC}"
echo "1) NVIDIA"
echo "2) AMD (Radeon RX 6600)"
read -p "Укажите производителя вашей видеокарты (1 или 2): " gpu_choice

if [ "$gpu_choice" == "1" ]; then
    echo -e "${BLUE}Установка драйверов NVIDIA...${NC}"
    # Установка последнего проприетарного драйвера и утилит для 32-битных приложений
    sudo pacman -S --needed --noconfirm nvidia nvidia-utils lib32-nvidia-utils
    # Включение DRM KMS, что необходимо для корректной работы Wayland
    # Согласно ArchWiki, начиная с версии nvidia-utils 560.35.03-5, DRM включен по умолчанию [citation:11]
    # Но для надежности можно проверить или добавить параметр ядра в будущем.
    echo -e "${GREEN}Драйверы NVIDIA установлены.${NC}"
elif [ "$gpu_choice" == "2" ]; then
    echo -e "${BLUE}Установка драйверов AMD...${NC}"
    # Для AMD Radeon RX 6600 (RDNA 2) используются открытые драйверы Mesa [citation:3]
    # lib32-* пакеты нужны для 32-битных приложений (Steam, Wine и т.д.)
    sudo pacman -S --needed --noconfirm mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon
    echo -e "${GREEN}Драйверы AMD установлены.${NC}"
else
    echo -e "${RED}Неверный выбор. Установка драйверов пропущена.${NC}"
fi

# 3. Включение SDDM без моментального запуска
# ------------------------------------------------------------------------------
# Команда 'systemctl enable' добавляет сервис в автозагрузку, но не запускает его сейчас.
# Это именно то, что требуется: SDDM запустится при следующей перезагрузке.
sudo systemctl enable sddm
echo -e "${GREEN}SDDM добавлен в автозагрузку (запустится после перезагрузки).${NC}"

# 4. Опциональная установка yay (AUR helper)
# ------------------------------------------------------------------------------
echo -e "${YELLOW}=== Установка yay (AUR helper) ===${NC}"
read -p "Хотите установить yay для работы с AUR? (y/n): " install_yay
if [[ "$install_yay" =~ ^[Yy]$ ]]; then
    echo -e "${BLUE}Установка yay...${NC}"
    # Официальная инструкция по установке yay: клонировать, собрать, установить [citation:23][citation:27]
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd /
    rm -rf /tmp/yay
    echo -e "${GREEN}yay установлен.${NC}"
else
    echo -e "Установка yay пропущена."
fi

# 5. Опциональная установка Zsh и Oh My Zsh
# ------------------------------------------------------------------------------
echo -e "${YELLOW}=== Установка Zsh и Oh My Zsh ===${NC}"
read -p "Хотите установить Zsh и Oh My Zsh? (y/n): " install_zsh
if [[ "$install_zsh" =~ ^[Yy]$ ]]; then
    echo -e "${BLUE}Установка Zsh...${NC}"
    sudo pacman -S --needed --noconfirm zsh
    
    echo -e "${BLUE}Установка Oh My Zsh...${NC}"
    # Официальный установщик Oh My Zsh [citation:6]
    # Флаг --unattended предотвращает запрос на смену оболочки по умолчанию во время установки.
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    
    echo -e "${GREEN}Zsh и Oh My Zsh установлены.${NC}"
    echo -e "${YELLOW}Не забудьте выполнить 'chsh -s $(which zsh)' и перелогиниться, чтобы Zsh стал оболочкой по умолчанию.${NC}"

        # --- Докачиваем кастомные плагины для Oh My Zsh ---
    echo -e "${BLUE}Установка кастомных плагинов для Zsh...${NC}"
    
    # Определяем путь к кастомным плагинам (по умолчанию ~/.oh-my-zsh/custom/plugins)
    ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
    PLUGINS_DIR="$ZSH_CUSTOM/plugins"
    
    mkdir -p "$PLUGINS_DIR"
    
    # 1. zsh-autosuggestions (подсказки команд)
    if [ ! -d "$PLUGINS_DIR/zsh-autosuggestions" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions.git "$PLUGINS_DIR/zsh-autosuggestions"
    else
        echo "zsh-autosuggestions уже установлен."
    fi
    
    # 2. zsh-syntax-highlighting (подсветка синтаксиса)
    if [ ! -d "$PLUGINS_DIR/zsh-syntax-highlighting" ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$PLUGINS_DIR/zsh-syntax-highlighting"
    else
        echo "zsh-syntax-highlighting уже установлен."
    fi
    
    echo -e "${GREEN}Плагины установлены.${NC}"
    
    # --- Записываем твой конфиг в ~/.zshrc ---
    echo -e "${BLUE}Настройка ~/.zshrc...${NC}"
    
    # Создаём или перезаписываем .zshrc с твоим конфигом
    cat > "$HOME/.zshrc" << 'EOF'
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="fishy"

plugins=(
  git
  z
  sudo
  fzf
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
EOF
    
    echo -e "${GREEN}~/.zshrc настроен.${NC}"

else
    echo -e "Установка Zsh пропущена."
fi

# 6. Клонирование и запуск репозитория qylock
# ------------------------------------------------------------------------------
echo -e "${BLUE}=== Настройка темы SDDM (qylock) ===${NC}"
mkdir -p "$REPO_DIR"
cd "$REPO_DIR"

if [ ! -d "qylock" ]; then
    echo -e "Клонирование qylock..."
    git clone https://github.com/Darkkal44/qylock.git
else
    echo -e "Репозиторий qylock уже существует. Пропускаем клонирование."
fi

cd "$REPO_DIR/qylock"
echo -e "Запуск скрипта установки темы SDDM..."
# Ваш скрипт sddm.sh должен находиться в корне репозитория qylock
chmod +x sddm.sh && ./sddm.sh

# 7. Клонирование HyprDotfiles и перенос конфигов
# ------------------------------------------------------------------------------
echo -e "${BLUE}=== Настройка конфигураций Hyprland ===${NC}"
cd "$REPO_DIR"

if [ ! -d "HyprDotfiles" ]; then
    echo -e "Клонирование HyprDotfiles..."
    git clone https://github.com/Ar0cka/HyprDotfiles.git
else
    echo -e "Репозиторий HyprDotfiles уже существует. Пропускаем клонирование."
fi

# 8. Перенос конфигурационных папок в ~/.config
# ------------------------------------------------------------------------------
# Использование 'rsync -a --delete' надежнее, чем cp, так как синхронизирует папки
# и удаляет файлы, которых нет в источнике (замена).
# Если rsync не установлен, используем cp -r
if ! command -v rsync &> /dev/null; then
    echo -e "${YELLOW}rsync не найден, используем cp...${NC}"
    # Убедимся, что целевая папка .config существует
    mkdir -p "$USER_HOME/.config"
    cp -r "$DOTFILES_DIR/hypr" "$USER_HOME/.config/"
    cp -r "$DOTFILES_DIR/kitty" "$USER_HOME/.config/"
    cp -r "$DOTFILES_DIR/rofi" "$USER_HOME/.config/"
    cp -r "$DOTFILES_DIR/waybar" "$USER_HOME/.config/"
else
    echo -e "Синхронизация конфигурационных папок в ~/.config..."
    mkdir -p "$USER_HOME/.config"
    rsync -a --delete "$DOTFILES_DIR/hypr/" "$USER_HOME/.config/hypr/"
    rsync -a --delete "$DOTFILES_DIR/kitty/" "$USER_HOME/.config/kitty/"
    rsync -a --delete "$DOTFILES_DIR/rofi/" "$USER_HOME/.config/rofi/"
    rsync -a --delete "$DOTFILES_DIR/waybar/" "$USER_HOME/.config/waybar/"
fi

# Перенос папки Images в домашнюю директорию пользователя
# Используем переменную окружения $HOME, как и требовалось.
echo -e "Копирование папки Images в $USER_HOME..."
if [ -d "$DOTFILES_DIR/Images" ]; then
    cp -r "$DOTFILES_DIR/Images" "$USER_HOME/"
    echo -e "${GREEN}Папка Images скопирована.${NC}"
else
    echo -e "${YELLOW}Папка Images не найдена в репозитории HyprDotfiles. Пропускаем.${NC}"
fi

# ==============================================================================
# === Опциональное включение multilib и установка Steam ===
# ==============================================================================
echo -e "${YELLOW}=== Steam и репозиторий multilib ===${NC}"

read -p "Хотите включить репозиторий multilib и установить Steam? (y/n): " install_steam

if [[ "$install_steam" =~ ^[Yy]$ ]]; then
    # --- Включение multilib ---
    echo -e "${BLUE}Включение репозитория multilib...${NC}"

    # Проверяем, включён ли multilib уже (нет ли # перед [multilib])
    if grep -q "^#\[multilib\]" /etc/pacman.conf; then
        # Раскомментируем секцию [multilib] и следующую за ней строку Include
        # Используем sed: ищем [multilib], убираем #, и следующую строку с Include
        sudo sed -i '/^#\[multilib\]/,/^#Include/ s/^#//' /etc/pacman.conf
        echo -e "${GREEN}multilib включён.${NC}"
    elif grep -q "^\[multilib\]" /etc/pacman.conf; then
        echo -e "multilib уже включён, пропускаем."
    else
        echo -e "${RED}Не удалось найти секцию [multilib] в /etc/pacman.conf${NC}"
        echo -e "${YELLOW}Проверьте файл вручную и раскомментируйте секцию multilib.${NC}"
    fi

    # Обновляем базы данных после включения multilib
    echo -e "Обновление баз данных pacman..."
    sudo pacman -Syy

    # --- Установка Steam ---
    echo -e "${BLUE}Установка Steam...${NC}"
    # pacman сам запросит выбор драйвера при установке, если нужно
    sudo pacman -S --needed --noconfirm steam

    echo -e "${GREEN}Steam установлен.${NC}"
    echo -e "${YELLOW}При первом запуске Steam может запросить установку дополнительных 32-битных драйверов.${NC}"
else
    echo -e "${YELLOW}Установка Steam пропущена.${NC}"
fi

# ==============================================================================
# === Опциональная установка Flatpak ===
# ==============================================================================
echo -e "${YELLOW}=== Flatpak ===${NC}"
read -p "Хотите установить Flatpak (для приложений из Flathub)? (y/n): " install_flatpak

if [[ "$install_flatpak" =~ ^[Yy]$ ]]; then
    echo -e "${BLUE}Установка Flatpak...${NC}"
    sudo pacman -S --needed --noconfirm flatpak

    echo -e "${BLUE}Добавление репозитория Flathub...${NC}"
    # Добавляем Flathub для всех пользователей системы.
    # --if-not-exists предотвращает ошибку, если репозиторий уже добавлен.
    sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

    echo -e "${GREEN}Flatpak установлен, Flathub подключён.${NC}"
    echo -e "${YELLOW}Для применения изменений может потребоваться перелогин или перезагрузка.${NC}"
else
    echo -e "${YELLOW}Установка Flatpak пропущена.${NC}"
fi

# ==============================================================================
# === Опциональная установка OBS Studio из Flathub ===
# ==============================================================================
echo -e "${YELLOW}=== OBS Studio ===${NC}"

# Проверяем, установлен ли вообще Flatpak (вдруг пользователь отказался от него)
if ! command -v flatpak &> /dev/null; then
    echo -e "${RED}Flatpak не установлен. Сначала выполните предыдущий шаг или установите Flatpak вручную.${NC}"
else
    read -p "Хотите установить OBS Studio из Flathub? (y/n): " install_obs

    if [[ "$install_obs" =~ ^[Yy]$ ]]; then
        echo -e "${BLUE}Установка OBS Studio...${NC}"
        # Установка из Flathub. Флаг -y автоматически подтверждает установку.
        flatpak install flathub com.obsproject.Studio -y

        echo -e "${GREEN}OBS Studio установлен.${NC}"
        echo -e "${YELLOW}Для запуска используйте: flatpak run com.obsproject.Studio${NC}"
        echo -e "${YELLOW}В Hyprland для захвата экрана используйте источник PipeWire.${NC}"
    else
        echo -e "${YELLOW}Установка OBS Studio пропущена.${NC}"
    fi
fi

echo -e "${GREEN}=====================================================${NC}"
echo -e "${GREEN}=== Установка успешно завершена! ===${NC}"
echo -e "${GREEN}=====================================================${NC}"
echo -e "SDDM будет запущен после перезагрузки."
echo -e "Вы сможете выбрать сессию Hyprland на экране входа."

# Запрос на перезагрузку
read -p "Перезагрузить систему сейчас? (y/n): " reboot_choice
if [[ "$reboot_choice" =~ ^[Yy]$ ]]; then
    echo -e "${BLUE}Перезагрузка через 3 секунды...${NC}"
    sleep 3
    sudo reboot
else
    echo -e "${YELLOW}Перезагрузка отменена. Выполните 'sudo reboot' вручную, когда будете готовы.${NC}"
fi