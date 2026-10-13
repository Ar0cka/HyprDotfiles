#!/bin/bash

echo "Скачивание зависимостей"
sudo pacman -S --needed --asdeps \
    rustup gcc cmake pkgconf git \
    wayland wayland-protocols libxkbcommon \
    gtk4 gtk4-layer-shell \
    vulkan-headers vulkan-icd-loader libglvnd \
    ffmpeg libva pipewire \
    qt6-base qt6-declarative qt6-wayland

rustup default stable

echo "Начало установки waywallen и open-wallpaper-engine"
yay -S open-wallpaper-engine waywallen 

echo "начало установки waywallen-display"
git clone https://github.com/waywallen/waywallen-display.git
cd waywallen-display  

echo "сборка waywallen-display"
cargo build --package waywallen-display --bin waywallen-layer-shell --release

echo "перенос бинарника в /usr/bin"
sudo cp target/release/waywallen-layer-shell /usr/bin/   

echo "Установка прошла успешно. \n Перед запуском, убедитесь что у вас скачена официальная приложение Wallpaper Engine из стим"
echo "Чтобы скачивать новые обои, запускайте Wallpaper Engine и подписывайтесь на обои, после в Waywallen ставьте их к себе на рабочий стол"