# HyprDotfiles

A set of configs and an installer script for **Hyprland** on a **clean Arch Linux** installation.

The script installs Hyprland, SDDM, base applications, GPU drivers, and optionally yay, Zsh, Steam, Flatpak, and OBS — then copies the configs from this repository into `~/.config`.

## Installation

```bash
curl -L -O https://raw.githubusercontent.com/Ar0cka/HyprDotfiles/master/install.sh
chmod +x install.sh
./install.sh
```

> ⚠️ **Run as a regular user, NOT as root.** The script calls `sudo` itself where needed. If you run it via `sudo`, the `yay` build from the AUR will fail.

> 💡 It's recommended to read the script before running:
> ```bash
> less install.sh
> ```

## Requirements

- A clean **Arch Linux** installation (fresh ISO).
- A user with `sudo` privileges.
- An internet connection.
- Free disk space (roughly ~10 GB including Steam and Flatpak).

## What the script does

The script is interactive — it asks `(y/n)` at each step. Full sequence below.

### 1. Configure pacman mirrors (optional)

Asks: **"Хотите установить reflector и выбрать лучшие зеркала? (y/n)"**

If `y`:
- installs `reflector`;
- backs up `/etc/pacman.d/mirrorlist` → `mirrorlist.backup`;
- picks the 20 freshest HTTPS mirrors synced within the last 12 hours, sorted by download rate;
- saves the result to `/etc/pacman.d/mirrorlist`;
- refreshes the pacman databases (`pacman -Syy`).

If `n` — default mirrors are used.

### 2. Install base components

Runs automatically via `pacman -S --needed`:

- `git`, `base-devel` — for building AUR packages;
- `sddm` — display manager;
- `hyprland`, `hyprpaper`, `waybar`, `rofi`, `kitty`, `dolphin` — desktop environment;
- `pipewire`, `pipewire-alsa`, `pipewire-pulse`, `pipewire-jack`, `wireplumber` — audio;
- `xdg-desktop-portal-hyprland` — portal for screen sharing in Discord;
- `discord`;
- `noto-fonts`, `noto-fonts-emoji` — base fonts and emoji;
- `qt6-declarative`, `qt6-5compat`, `qt6-svg`, `qt6-multimedia`, `qt6-multimedia-ffmpeg` — Qt6 for Hyprland components;
- `gst-plugins-base`, `gst-plugins-good`, `gst-plugins-bad`, `gst-plugins-ugly` — GStreamer;
- `fzf` — fuzzy finder.

### 3. GPU drivers (your choice)

Asks: **"Укажите производителя вашей видеокарты (1 или 2)"**

- **1 — NVIDIA:** installs `nvidia`, `nvidia-utils`, `lib32-nvidia-utils`.
- **2 — AMD (Radeon RX 6600):** installs `mesa`, `lib32-mesa`, `vulkan-radeon`, `lib32-vulkan-radeon`.

Any other input skips this step — you'll have to install drivers manually.

### 4. Enable SDDM in autostart

```bash
sudo systemctl enable sddm
```

The service is **not started immediately** — SDDM launches only after a reboot.

### 5. Install yay (optional)

Asks: **"Хотите установить yay для работы с AUR? (y/n)"**

If `y` — clones `https://aur.archlinux.org/yay.git` into `/tmp`, builds it with `makepkg -si --noconfirm`, and cleans up.

### 6. Install Zsh + Oh My Zsh + plugins (optional)

Asks: **"Хотите установить Zsh и Oh My Zsh? (y/n)"**

If `y`:
- installs `zsh`;
- installs Oh My Zsh with `--unattended` (does not change the default shell);
- downloads custom plugins into `~/.oh-my-zsh/custom/plugins`:
  - `zsh-autosuggestions` — command suggestions;
  - `zsh-syntax-highlighting` — syntax highlighting;
- **overwrites** `~/.zshrc` with the following config:

  ```zsh
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
  ```

> ⚠️ Your existing `~/.zshrc` will be overwritten. Save your aliases beforehand.

> 💡 After installation, run `chsh -s $(which zsh)` and re-login to make Zsh your default shell.

### 7. Install the SDDM theme (qylock)

Clones `https://github.com/Darkkal44/qylock.git` into `~/repositor/qylock` and runs `sddm.sh` from there:

```bash
chmod +x sddm.sh && ./sddm.sh
```

If the repo is already cloned, it won't be cloned again.

### 8. Clone configs and deploy to `~/.config`

Clones this repository into `~/repositor/HyprDotfiles` (if not already there) and copies:

| From repo | To |
|---|---|
| `hypr/` | `~/.config/hypr/` |
| `kitty/` | `~/.config/kitty/` |
| `rofi/` | `~/.config/rofi/` |
| `waybar/` | `~/.config/waybar/` |
| `Images/` | `~/Images/` |

Copy uses `rsync -a --delete` (full replace). If `rsync` isn't available, `cp -r` is used (old files are not removed).

### 9. Enable multilib and install Steam (optional)

Asks: **"Хотите включить репозиторий multilib и установить Steam? (y/n)"**

If `y`:
- uncomments the `[multilib]` section in `/etc/pacman.conf` (if still commented);
- refreshes databases (`pacman -Syy`);
- installs `steam`.

### 10. Install Flatpak (optional)

Asks: **"Хотите установить Flatpak (для приложений из Flathub)? (y/n)"**

If `y`:
- installs `flatpak`;
- adds the Flathub remote system-wide (`--if-not-exists`).

### 11. Install OBS Studio from Flathub (optional)

If Flatpak is installed, asks: **"Хотите установить OBS Studio из Flathub? (y/n)"**

If `y` — installs `com.obsproject.Studio` from Flathub.

> 💡 On Hyprland, use the **Screen Capture (PipeWire)** source in OBS for screen capture.

### 12. Reboot

Asks: **"Перезагрузить систему сейчас? (y/n)"**

- `y` — reboots after 3 seconds (`sudo reboot`).
- `n` — script exits; reboot manually with `sudo reboot`.

After the reboot, SDDM shows the login screen where you select the **Hyprland** session.

## Repository structure

```
HyprDotfiles/
├── install.sh       # installer script
├── hypr/            # Hyprland configs → ~/.config/hypr/
├── kitty/           # Kitty configs → ~/.config/kitty/
├── rofi/            # Rofi configs → ~/.config/rofi/
├── waybar/          # Waybar configs → ~/.config/waybar/
├── Images/          # wallpapers and images → ~/Images/
└── README.md
```

> ℹ️ If any of these folders is missing from the repository, the corresponding copy step is simply skipped.

## Known limitations

- The script assumes a **clean** Arch install. On an already configured system it may overwrite existing configs and `~/.zshrc`.
- The NVIDIA driver is installed as `nvidia` — that package targets the **default `linux` kernel**. If you use `linux-lts` or `linux-zen`, install `nvidia-dkms` manually.
- `rsync` is not in the list of packages installed by the script. If it's missing, config deployment falls back to `cp -r` (no removal of extra files).
- Folder deployment uses `--delete` (when `rsync` is present) — old files in target folders will be removed.

## License

Configs and script are provided as-is. Use at your own risk.
