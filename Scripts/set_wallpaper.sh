#!/usr/bin/env bash
#set -Eeuo pipefail
shopt -s nocasematch

# ============================================================
#                    НАСТРОЙКИ / ПЕРЕМЕННЫЕ
# ============================================================
# Пути к исполняемым файлам (проверены через `which`)
CMD_MPVPAPER="/usr/bin/mpvpaper"
CMD_MATUGEN="/usr/bin/matugen"
CMD_SPICETIFY="/home/arocka/.spicetify/spicetify"
CMD_SOCAT="/usr/bin/socat"
CMD_KILLALL="/usr/bin/killall"

# Переменные окружения для работы из Waybar
export PATH="/home/arocka/.spicetify:/usr/local/bin:/usr/bin:/bin:$PATH"
WAYLAND_DISPLAY_DEFAULT="wayland-1" # проверьте: echo $WAYLAND_DISPLAY

# Пути/имена файлов и сокетов
MPV_LOG="/tmp/mpvpaper.log"
SOCKET="/tmp/mpvpaper-socket"
ROFI_OUT="$HOME/.config/rofi/launchers/type-6/rofi-background.rasi"

# Имена файлов-кандидатов (без расширения)
WALLPAPER_NAME="wallpaper"
WALLPAPER_PREVIEW="preview"
ROFI_NAME="rofi"
# ============================================================

# ---------- окружение ----------
if [ -z "${WAYLAND_DISPLAY:-}" ]; then
    export WAYLAND_DISPLAY="$WAYLAND_DISPLAY_DEFAULT"
fi

# ---------- logging ----------
LOG_PREFIX="[set_wallpaper]"
log() { printf '%s %s\n' "$LOG_PREFIX" "$*" >&2; }
logv() { printf '%s DEBUG: %s\n' "$LOG_PREFIX" "$*" >&2; }
trap 'log "ERROR: command \"$BASH_COMMAND\" exited with code $?"' ERR

: >"$MPV_LOG"

log "start, args: $#"
logv "PWD=$PWD"
logv "USER=$USER"
logv "XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-<unset>}"
logv "WAYLAND_DISPLAY=${WAYLAND_DISPLAY:-<unset>}"
logv "DISPLAY=${DISPLAY:-<unset>}"
# ----------------------------------

if [ $# -lt 1 ]; then
    echo "Usage: $0 <image-folder-path>" >&2
    exit 1
fi

WALLPAPER_PATH="${1%/}"

logv "WALLPAPER_PATH=$WALLPAPER_PATH"
logv "SOCKET=$SOCKET"
logv "MPV_LOG=$MPV_LOG"

if [ ! -d "$WALLPAPER_PATH" ]; then
    log "no such directory: $WALLPAPER_PATH"
    echo "Please, pass a path to a folder with wallpaper." >&2
    exit 1
else
    log "directory found: $WALLPAPER_PATH"
fi

# ---------- find files ----------
wallpaper_file_path=""
for f in "$WALLPAPER_PATH/$WALLPAPER_NAME".*; do
    logv "checking candidate: $f"
    [ -f "$f" ] && {
        wallpaper_file_path="$f"
        log "found wallpaper: $f"
        break
    }
done

rofi_wallpaper_file_path=""
for f in "$WALLPAPER_PATH/$ROFI_NAME".*; do
    logv "checking candidate: $f"
    [ -f "$f" ] && {
        rofi_wallpaper_file_path="$f"
        log "found rofi: $f"
        break
    }
done

wallpaper_preview_file_path=""
for f in "$WALLPAPER_PATH/$WALLPAPER_PREVIEW".*; do
    logv "checking candidate: $f"
    [ -f "$f" ] && {
        wallpaper_preview_file_path="$f"
        log "found preview: $f"
        break
    }
done

if [ -z "$wallpaper_file_path" ] || [ -z "$rofi_wallpaper_file_path" ]; then
    log "wallpaper or rofi not found"
    echo "Not found. Wallpaper: '$wallpaper_file_path'. Rofi: '$rofi_wallpaper_file_path'" >&2
    exit 1
fi

log "wallpaper=[$wallpaper_file_path]"
log "rofi=[$rofi_wallpaper_file_path]"

# ---------- verify file ----------
if [ -f "$wallpaper_file_path" ]; then
    logv "file exists, size: $(stat -c %s "$wallpaper_file_path" 2>/dev/null || echo '?') bytes"
    logv "mime: $(file --mime-type -b "$wallpaper_file_path" 2>/dev/null || echo '?')"
else
    log "FILE DOES NOT EXIST: $wallpaper_file_path"
fi

# ---------- video or image ----------
is_video=false
use_preview=false
case "$wallpaper_file_path" in
*.mp4 | *.webm | *.mkv | *.mov) is_video=true ;;
esac
logv "is_video=$is_video"

# ---------- mpvpaper state ----------
if pgrep -x mpvpaper >/dev/null; then
    logv "mpvpaper is running: PID=$(pgrep -x mpvpaper | tr '\n' ' ')"
else
    logv "mpvpaper is NOT running"
fi
if [ -S "$SOCKET" ]; then
    logv "socket exists: $(ls -l "$SOCKET")"
else
    logv "no socket: $SOCKET"
fi

# ---------- video ----------
if [ "$is_video" == true ]; then
    log "video — killing old mpvpaper and starting without socket"

    "$CMD_KILLALL" mpvpaper 2>/dev/null && log "killall mpvpaper: success" || log "killall mpvpaper: nothing to kill"
    rm -f "$SOCKET" && log "socket removed" || log "socket not removed"

    log "launching: $CMD_MPVPAPER -v -o --log-file=$MPV_LOG ALL \"$wallpaper_file_path\""
    nohup "$CMD_MPVPAPER" -v -o "--log-file=$MPV_LOG" ALL "$wallpaper_file_path" \
        >>"$MPV_LOG" 2>&1 &
    MPVPAPER_PID=$!
    log "mpvpaper PID=$MPVPAPER_PID"
    use_preview=true
    disown

    sleep 1
    if kill -0 "$MPVPAPER_PID" 2>/dev/null; then
        log "mpvpaper is alive after 1s"
    else
        log "mpvpaper DIED after 1s — check $MPV_LOG"
    fi

# ---------- image ----------
else
    log "image — using socket"

    if pgrep -x mpvpaper >/dev/null && [ -S "$SOCKET" ]; then
        log "mpvpaper is alive and socket exists — sending loadfile"
        printf 'loadfile "%s"\n' "$wallpaper_file_path" | "$CMD_SOCAT" - "$SOCKET"
        log "loadfile sent (exit code $?)"
    else
        log "mpvpaper not running or no socket — restarting"
        "$CMD_KILLALL" mpvpaper 2>/dev/null && log "killall mpvpaper: success" || log "killall mpvpaper: nothing to kill"
        rm -f "$SOCKET" && log "socket removed"

        log "launching: $CMD_MPVPAPER -v -o input-ipc-server=$SOCKET -o --log-file=$MPV_LOG ALL \"$wallpaper_file_path\""
        setsid "$CMD_MPVPAPER" -v \
            -o "input-ipc-server=$SOCKET" \
            -o "--log-file=$MPV_LOG" \
            ALL "$wallpaper_file_path" \
            >>"$MPV_LOG" 2>&1 &
        MPVPAPER_PID=$!
        log "mpvpaper PID=$MPVPAPER_PID"
        disown
    fi
fi

# ---------- rofi ----------
log "writing rofi: $ROFI_OUT"
printf '* {\n wallpaper: url("%s", width);\n}\n' "$rofi_wallpaper_file_path" \
    >"$ROFI_OUT"
log "rofi written"

# ---------- matugen ----------
if [ "$use_preview" == true ]; then
    log "matugen from preview: $wallpaper_preview_file_path"
    "$CMD_MATUGEN" image "$wallpaper_preview_file_path" -m dark --source-color-index 0
else
    log "matugen from wallpaper: $wallpaper_file_path"
    "$CMD_MATUGEN" image "$wallpaper_file_path" -m dark --source-color-index 0
fi
log "matugen finished (exit code $?)"

# ---------- spicetify ----------
log "spicetify apply"
"$CMD_SPICETIFY" apply
log "spicetify finished (exit code $?)"

echo "Matugen configuration updated."
echo "Wallpaper setup completed."
shopt -u nocasematch
