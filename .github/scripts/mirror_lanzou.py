#!/usr/bin/env python3
"""Upload ExPiliPlus release assets to a per-release Lanzou folder."""

from __future__ import annotations

import argparse
import json
import os
import sys
from http.cookies import SimpleCookie
from pathlib import Path

from lanzou.api import LanZouCloud


SUPPORTED_SUFFIXES = (
    ".apk",
    ".ipa",
    ".dmg",
    ".exe",
    ".zip",
    ".appimage",
    ".deb",
    ".rpm",
    ".tar.gz",
)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--tag", required=True)
    parser.add_argument("--assets-dir", required=True, type=Path)
    parser.add_argument("--output", required=True, type=Path)
    parser.add_argument("--root-folder", default="ExPiliPlus Releases")
    parser.add_argument("--max-file-mb", default=100, type=int)
    return parser.parse_args()


def parse_cookie(raw_cookie: str) -> dict[str, str]:
    raw_cookie = raw_cookie.strip()
    if not raw_cookie:
        raise ValueError("LANZOU_COOKIE is empty")

    if raw_cookie.startswith("{"):
        parsed = json.loads(raw_cookie)
    else:
        cookie = SimpleCookie()
        cookie.load(raw_cookie)
        parsed = {key: morsel.value for key, morsel in cookie.items()}

    required = ("ylogin", "phpdisk_info")
    missing = [key for key in required if not parsed.get(key)]
    if missing:
        raise ValueError(
            "LANZOU_COOKIE must contain: " + ", ".join(required)
        )
    return {key: str(parsed[key]) for key in required}


def collect_assets(assets_dir: Path, max_file_mb: int) -> list[Path]:
    if not assets_dir.is_dir():
        raise ValueError(f"Assets directory does not exist: {assets_dir}")

    assets = [
        path
        for path in sorted(assets_dir.iterdir())
        if path.is_file()
        and path.name.startswith("ExPiliplus_")
        and path.name.lower().endswith(SUPPORTED_SUFFIXES)
    ]
    if not assets:
        raise ValueError("No supported ExPiliPlus release assets were found")

    max_bytes = max_file_mb * 1024 * 1024
    oversized = [path.name for path in assets if path.stat().st_size > max_bytes]
    if oversized:
        raise ValueError(
            f"Lanzou official upload limit is {max_file_mb} MiB; oversized files: "
            + ", ".join(oversized)
        )
    return assets


def require_success(code: int, operation: str) -> None:
    if code != LanZouCloud.SUCCESS:
        raise RuntimeError(f"{operation} failed with Lanzou error code {code}")


def require_folder_id(folder_id: int, operation: str) -> int:
    if folder_id == LanZouCloud.MKDIR_ERROR or folder_id < 0:
        raise RuntimeError(f"{operation} failed with Lanzou error code {folder_id}")
    return folder_id


def main() -> int:
    args = parse_args()
    cookie = parse_cookie(os.environ.get("LANZOU_COOKIE", ""))
    folder_password = os.environ.get("LANZOU_FOLDER_PASSWORD", "").strip()
    assets = collect_assets(args.assets_dir, args.max_file_mb)

    lanzou = LanZouCloud()
    require_success(lanzou.login_by_cookie(cookie), "Cookie login")

    root_id = require_folder_id(
        lanzou.mkdir(-1, args.root_folder, "ExPiliPlus Release 下载镜像"),
        "Creating mirror root folder",
    )
    release_id = require_folder_id(
        lanzou.mkdir(
            root_id,
            args.tag,
            f"ExPiliPlus {args.tag} Release 下载镜像",
        ),
        "Creating release folder",
    )
    require_success(
        lanzou.set_desc(
            release_id,
            f"ExPiliPlus {args.tag} Release 下载镜像",
            is_file=False,
        ),
        "Updating release folder description",
    )

    uploaded: list[str] = []
    for asset in assets:
        print(
            f"Uploading {asset.name} "
            f"({asset.stat().st_size / 1024 / 1024:.1f} MiB)"
        )
        require_success(
            lanzou.upload_file(str(asset), release_id),
            f"Uploading {asset.name}",
        )
        uploaded.append(asset.name)

    if folder_password:
        require_success(
            lanzou.set_passwd(release_id, folder_password, is_file=False),
            "Setting release folder password",
        )

    share = lanzou.get_share_info(release_id, is_file=False)
    require_success(share.code, "Reading release folder share link")
    if not share.url:
        raise RuntimeError("Lanzou returned an empty release folder share link")

    result = {
        "tag": args.tag,
        "folder_id": release_id,
        "url": share.url,
        "password": share.pwd,
        "files": uploaded,
    }
    args.output.write_text(
        json.dumps(result, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    print(f"Mirror ready: {share.url}")
    print(f"Uploaded {len(uploaded)} release assets")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (ValueError, RuntimeError, json.JSONDecodeError) as error:
        print(f"error: {error}", file=sys.stderr)
        raise SystemExit(1)
