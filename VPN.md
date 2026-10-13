## 🇷🇺 For users in Russia

If GitHub is blocked, download and activate the VPN script first:

```bash
curl -L -O https://raw.githubusercontent.com/Ar0cka/HyprDotfiles/master/vless.sh
chmod +x vless.sh
source vless.sh
```

> ⚠️ Use `source` instead of `./vless.sh` so that proxy environment variables (`HTTP_PROXY`, `HTTPS_PROXY`) persist in the current shell session.

> 💡 It's recommended to read the script before running:

```bash
less vless.sh
```

🛠️ For advanced users (manual setup)

If you're already an experienced user, you can install Hyprland, SDDM, and yay yourself (or run the installation script and stop at the zsh step), then install Throne via:
bash

yay -S throne

📥 Adding the test VPN (temporary use only)

Once Throne is installed, add the test subscription profile below. This VPN is intended for temporary testing only — do not rely on it long-term.

Subscription link:
text

vless://bc5d82bf-5141-460b-8a36-7648c20050ef@realarasaka.arocka.site:443?alpn=h2%2Chttp%2F1.1&extra=%7B%22mode%22%3A%22packet-up%22%2C%22xPaddingBytes%22%3A%22100-1000%22%7D&fp=firefox&host=realarasaka.arocka.site&mode=packet-up&path=%2Fx0YQob80yw&security=tls&type=xhttp&x_padding_bytes=100-1000#%F0%9F%87%AF%F0%9F%87%B5%20xhttp-test-tapka

How to import it into Throne:

    Copy the link above.

    Open Throne.

    Press Ctrl+V (or use the import/paste option) — Throne will automatically parse the link as a new profile.

    Select the imported profile and connect.

🔐 Running Throne with TUN mode

To enable TUN mode, Throne must be launched with elevated privileges and preserve your environment variables:
bash

sudo -E throne

    ⚠️ The -E flag is important — it preserves your user environment when running as root, which is required for TUN mode to work correctly.

🌐 About the vless.sh script

The vless.sh script activates the VPN as a system proxy by exporting HTTP_PROXY, HTTPS_PROXY, http_proxy, and https_proxy environment variables pointing to Throne's local mixed port (127.0.0.1:2080).

    ⚠️ Risks of ignoring this: Some applications ignore proxy environment variables entirely (e.g., apps that use their own network stack, certain Electron apps, or those that don't respect HTTP_PROXY/HTTPS_PROXY). In such cases, traffic will not be routed through the proxy, potentially leaking your real IP. For full traffic coverage, prefer TUN mode instead of relying solely on the proxy script.

> **P.S.** If you force-killed Throne (or it crashed) while System Proxy was active, the proxy setting may remain stuck in your system after a reboot — pointing to `127.0.0.1:2080` with nothing listening, which breaks internet access.
>
> On Arch Linux, the simplest fix is to let Throne clean up after itself:
>
> 1. Launch Throne again.
> 2. In the main window, **enable System Proxy** (if it's off).
> 3. Then **disable it** — Throne will reset your system proxy settings.
>
> If Throne is already running, just toggle **System Proxy** off in the main window or via the tray menu. On normal exit, Throne removes the proxy setting automatically[citation:4][citation:7].
