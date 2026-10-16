# zapret-openwrt Setup Guide

This README describes how to set up `zapret-openwrt` by [remittor](https://github.com/remittor/zapret-openwrt) with a custom config (`zapret-youtube-discord.conf`) and a DoH proxy (Quad9) for more stable operation.

---

## 1. Install zapret-openwrt

1. Download the latest release from the official repository:  
   https://github.com/remittor/zapret-openwrt/releases

2. Install the `.ipk` packages on your OpenWrt router.  
   You can do this via **LuCI → System → Software → Upload Package**, or via SSH:

   ```bash
   opkg update
   opkg install /tmp/zapret_*.ipk
   ```

    After installation, the zapret service will appear in LuCI under Services → Zapret.

    Full installation instructions: https://github.com/remittor/zapret-openwrt

2. Apply the Custom Config

    Open zapret-youtube-discord.conf (provided separately).

    Copy its contents.

    In LuCI, go to Services → Zapret → Configuration.

    Find the field NFQWS_OPT.

    Paste the config contents into this field.

    Click Save & Apply.

    Restart the zapret service:

    ```bash
    /etc/init.d/zapret restart
    ```

The config is tuned for bypassing DPI on YouTube and Discord.

3. Set Up DoH (DNS over HTTPS) with Quad9

For more stable zapret operation, it is strongly recommended to encrypt DNS queries.
This prevents your ISP from spoofing or blocking DNS responses, which would otherwise break zapret.

    Install the DoH proxy:

    ```bash
    opkg update
    opkg install https-dns-proxy luci-app-https-dns-proxy
    ```

    Or use Software catalog in openwrt and install https-dns-proxy luci-app-https-dns-proxy.

    Open LuCI → Services → HTTPS DNS Proxy → Global Instance Options.

    Remove any existing instances (Cloudflare, Google, etc.).

    Click Add and set:

        Provider: Quad 9

        Variant: Standard

        Bootstrap DNS: 9.9.9.9,149.112.112.112,2620:fe::fe

        Listen Address: 127.0.0.1

        Listen Port: 5053

    Click Save & Apply.

    Make sure the service status is Running.

https-dns-proxy automatically configures dnsmasq to use 127.0.0.1#5053 as its upstream resolver.
Verify it works
bash

nslookup openwrt.org 127.0.0.1:5053
curl -SL http://edns.ip-api.com/json

If the edns field shows a Quad9 IP — DoH is working.
4. If the Config Doesn't Work

If zapret-youtube-discord.conf doesn't help with your ISP, try other configurations from the community thread:

👉 https://github.com/remittor/zapret-openwrt/discussions/168?sort=new

There you can find working NFQWS_OPT variants for different ISPs and regions.

Notes

    zapret operates at the packet level and does not encrypt DNS. Without DoH, your ISP can still spoof DNS responses and break bypasses.

    Quad9 may itself be blocked in some regions. If so, try another DoH provider (Cloudflare, AdGuard DNS, etc.).

    Always restart both services after changing configs:
    bash

    /etc/init.d/zapret restart
    /etc/init.d/https-dns-proxy restart
    /etc/init.d/dnsmasq restart

