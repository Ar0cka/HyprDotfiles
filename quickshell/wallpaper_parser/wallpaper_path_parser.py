#!/usr/bin/env python3

from pathlib import Path
from dataclasses import dataclass, field, asdict
import json
import sys

OUTPUT_PATH = Path("/home/arocka/.config/quickshell/wallpaper_parser/wallpapers.json")

PATH_TO_WALLPAPERS = "~/Wallpapers"
PREVIEW_FIELNAME = "preview"

@dataclass
class Wallpaper_info:
    wallpaper_preview: str
    wallpaper_dir_path: str


def main() -> None:
    wallpaper_dir = Path(PATH_TO_WALLPAPERS).expanduser()

    if not wallpaper_dir.is_dir():
        print("Const PATH_TO_WALLPAPERS is not dir")
        sys.exit(1)

    wallpapers = []

    for directory in wallpaper_dir.iterdir():
        wallpapers.append(directory)
        print(f"Dirictory: {directory}")

    wallpapers_info = []

    for wallpaper_path in wallpapers:
        for item in wallpaper_path.rglob("*"):
            if (item.is_file() and item.stem == PREVIEW_FIELNAME):
                print(f"Add new info. Path:{item}, folder path {wallpaper_path}")
                info = Wallpaper_info(str(item), str(wallpaper_path))
                wallpapers_info.append(info)
                break

    data = [asdict(item) for item in wallpapers_info]

    with open(OUTPUT_PATH, "w", encoding="utf-8") as f:
       json.dump(data, f, ensure_ascii=False, indent=2)


if __name__ == "__main__":
    main()
