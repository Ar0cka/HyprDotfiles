## Installation

The installation is performed in several stages:

1. **Installing build dependencies** — the Rust toolchain, C/C++ build tools, and the Wayland, GTK4, Vulkan, Qt6, and FFmpeg libraries required to compile Waywallen and its components.

2. **Setting the Rust toolchain** — ensures a stable Rust toolchain is active for the build.

3. **Installing Waywallen and the open-wallpaper-engine plugin** — Waywallen is installed **from source** (the git version), not the prebuilt binary. When the package manager asks which provider to use for the `waywallen` dependency, choose the source build, not `waywallen-bin`.

4. **Cloning the `waywallen-display` repository** — pulls the upstream sources containing the `waywallen-layer-shell` component.

5. **Building `waywallen-layer-shell`** — compiles the binary in release mode.

6. **Installing the binary system-wide** — copies the compiled `waywallen-layer-shell` into `/usr/bin` so Waywallen can locate it at runtime.

### Important notes

- **Use the source build, not the binary or Flatpak version.** The prebuilt AppImage and the Flatpak build have known stability and buffering issues, especially on **NVIDIA GPUs under Wayland**, where DMABUF/WebKitGTK rendering frequently breaks. Building Waywallen from source gives you the latest upstream fixes and avoids the Flatpak sandbox layer that conflicts with the proprietary NVIDIA driver.

- **`waywallen-layer-shell` must be installed manually.** On layer-shell compositors (niri, sway, Hyprland, etc.) Waywallen will start but report *"no active renderers"* unless this binary is present in `/usr/bin`. The AUR package does not place it there automatically — copying it manually is required for wallpapers to render.

- **`open-wallpaper-engine` is a third-party plugin.** Installing it via the package manager works, but new wallpapers are downloaded by launching the official **Wallpaper Engine from Steam**, subscribing to wallpapers, and then applying them inside Waywallen.

- **NVIDIA users**: install `nvidia-vaapi-driver` and disable `shared_texture_enabled` for web wallpapers to avoid rendering artifacts.

### After installation

Before launching, make sure the official **Wallpaper Engine** application from Steam is installed.

To download new wallpapers, launch Wallpaper Engine and subscribe to wallpapers, then apply them to your desktop inside Waywallen.