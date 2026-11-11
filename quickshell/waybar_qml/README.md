# QuickShell Waybar-style TopBar

QML components mirroring the supplied Waybar layout.

## Files
- `TopBar.qml` — top-anchored PanelWindow and left/center/right layout
- `Workspaces.qml` — Hyprland workspaces
- `Spotify.qml` — playerctl metadata, click play/pause, wheel next/previous
- `Clock.qml` — HH:mm clock
- `SoundVisual.qml` — CAVA pipeline
- `ControlSound.qml` — wpctl volume display, click opens pavucontrol
- `SwitchPaper.qml` — launches the existing wallpaper script
- `Tray.qml` — system tray icons

## Install
Copy these files into `~/.config/quickshell/waybar_qml/`.
In your main `shell.qml`, import the folder and instantiate the bar:

```qml
import "waybar_qml"

TopBar {}
```

Do not instantiate another TopBar elsewhere if one is already loaded.

## Dependencies
- `playerctl`
- `cava` and `~/.config/cava/config_waybar`
- `wireplumber` / `wpctl`
- `pavucontrol`
- The existing `/home/arocka/Scripts/waybar_button_script.sh`

## Notes
- The bar is 32px high and reserves a 32px exclusive zone.
- This is a first-pass port: Quickshell's QML APIs can differ between versions. Validate with `quickshell` and inspect the first QML error before tuning styling.
- Native tray activation APIs may vary by Quickshell version; if your installed version reports errors in `Tray.qml`, share the log and we can adjust that component to your exact version.
