#!/usr/bin/env python3
"""Create one quality-controlled JPEG from a raw PNG/JPEG on macOS."""

from __future__ import annotations

import argparse
import platform
import shutil
import subprocess
import sys
from pathlib import Path


def image_kind(data: bytes) -> str:
    if data.startswith(b"\x89PNG\r\n\x1a\n"):
        return "PNG"
    if data.startswith(b"\xff\xd8"):
        return "JPEG"
    raise ValueError("Input must be PNG or JPEG.")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--input", required=True, type=Path)
    parser.add_argument("--output", required=True, type=Path)
    parser.add_argument("--quality", type=int, default=95)
    parser.add_argument("--width", type=int)
    parser.add_argument("--height", type=int)
    args = parser.parse_args()

    if platform.system() != "Darwin":
        raise RuntimeError("This script uses the macOS built-in sips utility.")
    if shutil.which("sips") is None:
        raise RuntimeError("The macOS sips utility is unavailable.")
    if not 1 <= args.quality <= 100:
        raise ValueError("Quality must be between 1 and 100.")
    if (args.width is None) != (args.height is None):
        raise ValueError("Provide both --width and --height, or omit both.")
    if args.width is not None and (args.width < 1 or args.height < 1):
        raise ValueError("Width and height must be positive integers.")

    input_path = args.input.expanduser().resolve(strict=True)
    output_path = args.output.expanduser().resolve()
    if input_path == output_path:
        raise ValueError("Input and output paths must differ.")
    if output_path.exists():
        raise FileExistsError("Output already exists. Use a versioned filename.")
    if output_path.suffix.lower() not in {".jpg", ".jpeg"}:
        raise ValueError("Output must use a .jpg or .jpeg extension.")
    image_kind(input_path.read_bytes()[:8])

    output_path.parent.mkdir(parents=True, exist_ok=True)
    command = [
        "sips",
        "-s",
        "format",
        "jpeg",
        "-s",
        "formatOptions",
        str(args.quality),
    ]
    if args.width is not None:
        command.extend(["--resampleHeightWidth", str(args.height), str(args.width)])
    command.extend([str(input_path), "--out", str(output_path)])
    completed = subprocess.run(command, check=False, capture_output=True, text=True)
    if completed.returncode != 0:
        raise RuntimeError(completed.stderr.strip() or "sips conversion failed.")
    if not output_path.exists() or image_kind(output_path.read_bytes()[:8]) != "JPEG":
        raise RuntimeError("JPEG output verification failed.")

    print(f"JPEG: {output_path}")
    print(f"QUALITY: {args.quality}")
    if args.width is not None:
        print(f"SIZE: {args.width}x{args.height}")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except Exception as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        raise SystemExit(1)
