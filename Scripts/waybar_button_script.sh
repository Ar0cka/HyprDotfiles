#!/usr/bin/env bash
set -Eeuo pipefail

# ---------- logging ----------
LOG_PREFIX="[next_wallpaper]"
log() { printf '%s %s\n' "$LOG_PREFIX" "$*" >&2; }
logv() { printf '%s DEBUG: %s\n' "$LOG_PREFIX" "$*" >&2; }
trap 'log "ERROR: command \"$BASH_COMMAND\" exited with code $?"' ERR
# ----------------------------------

# ---------- настройки ----------
state_file="$HOME/.wallpapers_idx"
path="$HOME/Wallpapers"
set_wallpaper_script="$HOME/Scripts/set_wallpaper.sh"
# ----------------------------------

log "start, args: $#"
logv "PWD=$PWD"
logv "USER=$USER"
logv "HOME=$HOME"
logv "state_file=$state_file"
logv "path=$path"
logv "set_wallpaper_script=$set_wallpaper_script"
logv "WAYLAND_DISPLAY=${WAYLAND_DISPLAY:-<unset>}"
logv "DISPLAY=${DISPLAY:-<unset>}"

# ---------- поиск папок ----------
log "scanning wallpaper dirs in: $path"
if [ ! -d "$path" ]; then
    log "ERROR: directory does not exist: $path"
    echo "No such directory: $path" >&2
    exit 1
fi
logv "directory exists: $path"

shopt -s nullglob
wallpaper_dirs=("$path"/*/)
shopt -u nullglob

log "found ${#wallpaper_dirs[@]} wallpaper folder(s)"
for i in "${!wallpaper_dirs[@]}"; do
    logv "  [$i] ${wallpaper_dirs[$i]}"
done

if ((${#wallpaper_dirs[@]} == 0)); then
    log "ERROR: no wallpaper folders in $path"
    echo "Empty" >&2
    exit 1
fi

# ---------- state file ----------
log "checking state file: $state_file"
if [[ ! -f "$state_file" ]]; then
    log "state file missing — creating"
    touch "$state_file" || {
        log "ERROR: failed to create $state_file"
        exit 1
    }
    log "state file created"
else
    logv "state file exists, size: $(stat -c %s "$state_file" 2>/dev/null || echo '?') bytes"
    logv "state file content: '$(cat "$state_file" 2>/dev/null || echo '<read error>')'"
fi

# ---------- чтение индекса ----------
declare -i idx=0
raw_idx="$(<"$state_file")"
logv "raw state content: '$raw_idx'"

if [[ -z "$raw_idx" ]]; then
    log "state file is empty — using idx=0"
    idx=0
else
    # защита от нечислового содержимого
    if [[ "$raw_idx" =~ ^-?[0-9]+$ ]]; then
        idx=$raw_idx
        logv "parsed idx=$idx"
    else
        log "WARNING: non-numeric state content '$raw_idx' — resetting to 0"
        idx=0
    fi
fi

# ---------- валидация индекса ----------
if ((idx < 0 || idx >= ${#wallpaper_dirs[@]})); then
    log "WARNING: idx=$idx out of range [0..$((${#wallpaper_dirs[@]} - 1))] — resetting to 0"
    idx=0
fi

current_folder="${wallpaper_dirs[$idx]}"
next_idx=$(((idx + 1) % ${#wallpaper_dirs[@]}))

log "current idx=$idx"
log "current folder=$current_folder"
log "next idx will be $next_idx"

# ---------- проверка вызываемого скрипта ----------
if [ ! -f "$set_wallpaper_script" ]; then
    log "ERROR: set_wallpaper script not found: $set_wallpaper_script"
    exit 1
fi
if [ ! -x "$set_wallpaper_script" ]; then
    log "ERROR: set_wallpaper script is not executable: $set_wallpaper_script"
    exit 1
fi
logv "set_wallpaper script is present and executable"

# ---------- вызов ----------
log "calling: $set_wallpaper_script \"$current_folder\""
set +e
setsid "$set_wallpaper_script" "$current_folder" >>"$HOME/.cache/set_wallpaper.log" 2>&1 &
log "set_wallpaper launched detached (PID $!)"
rc=$?
set -e
log "set_wallpaper exited with code $rc"

if ((rc != 0)); then
    log "ERROR: set_wallpaper failed (code $rc) — state file NOT updated"
    exit "$rc"
fi

# ---------- обновление state ----------
log "updating state file: idx $idx -> $next_idx"
printf '%s\n' "$next_idx" >"$state_file"
logv "state file written: '$(cat "$state_file" 2>/dev/null || echo '<read error>')'"

log "done"
