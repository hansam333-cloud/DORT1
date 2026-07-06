#!/usr/bin/env python3
"""Remove supported AI/tool metadata from PNG or JPEG without re-encoding pixels."""

from __future__ import annotations

import argparse
import hashlib
import struct
import sys
from pathlib import Path
from typing import List, Optional, Tuple


BLOCKED_PNG_CHUNKS = {b"caBX", b"eXIf", b"tEXt", b"zTXt", b"iTXt"}
BLOCKED_JPEG_MARKERS = {
    0xE1: "APP1-EXIF-XMP",
    0xEB: "APP11-JUMBF-C2PA",
    0xED: "APP13-IPTC",
    0xFE: "COM",
}
PNG_SIGNATURE = b"\x89PNG\r\n\x1a\n"


def image_kind(data: bytes) -> str:
    if data.startswith(PNG_SIGNATURE):
        return "PNG"
    if data.startswith(b"\xff\xd8"):
        return "JPEG"
    raise ValueError("지원 형식은 PNG와 JPEG뿐입니다.")


def png_chunks(data: bytes):
    if not data.startswith(PNG_SIGNATURE):
        raise ValueError("PNG 서명이 올바르지 않습니다.")
    pos = len(PNG_SIGNATURE)
    while pos + 12 <= len(data):
        length = struct.unpack_from(">I", data, pos)[0]
        chunk_type = data[pos + 4 : pos + 8]
        end = pos + 12 + length
        if end > len(data):
            raise ValueError(f"손상된 PNG 청크: {chunk_type!r}")
        yield pos, end, chunk_type, data[pos + 8 : pos + 8 + length]
        pos = end
        if chunk_type == b"IEND":
            return
    raise ValueError("PNG IEND 청크를 찾지 못했습니다.")


def png_metadata(data: bytes) -> List[str]:
    return [chunk_type.decode("ascii") for _, _, chunk_type, _ in png_chunks(data) if chunk_type in BLOCKED_PNG_CHUNKS]


def clean_png(data: bytes) -> bytes:
    output = bytearray(PNG_SIGNATURE)
    for start, end, chunk_type, _ in png_chunks(data):
        if chunk_type not in BLOCKED_PNG_CHUNKS:
            output.extend(data[start:end])
    return bytes(output)


def jpeg_segments(data: bytes):
    if not data.startswith(b"\xff\xd8"):
        raise ValueError("JPEG 서명이 올바르지 않습니다.")
    pos = 2
    while pos < len(data):
        segment_start = pos
        if data[pos] != 0xFF:
            raise ValueError(f"손상된 JPEG 마커 위치: {pos}")
        while pos < len(data) and data[pos] == 0xFF:
            pos += 1
        if pos >= len(data):
            raise ValueError("손상된 JPEG 마커입니다.")
        marker = data[pos]
        pos += 1
        if marker in (0xDA, 0xD9):
            yield segment_start, len(data), marker, data[pos:]
            return
        if marker == 0x01 or 0xD0 <= marker <= 0xD7:
            yield segment_start, pos, marker, b""
            continue
        if pos + 2 > len(data):
            raise ValueError("손상된 JPEG 세그먼트 길이입니다.")
        length = struct.unpack_from(">H", data, pos)[0]
        end = pos + length
        if length < 2 or end > len(data):
            raise ValueError("손상된 JPEG 세그먼트입니다.")
        payload = data[pos + 2 : end]
        yield segment_start, end, marker, payload
        pos = end
    raise ValueError("JPEG SOS 또는 EOI 마커를 찾지 못했습니다.")


def jpeg_metadata(data: bytes) -> List[str]:
    found: List[str] = []
    for _, _, marker, _ in jpeg_segments(data):
        if marker in BLOCKED_JPEG_MARKERS:
            found.append(BLOCKED_JPEG_MARKERS[marker])
        if marker in (0xDA, 0xD9):
            break
    return found


def exif_orientation(payload: bytes) -> Optional[int]:
    if not payload.startswith(b"Exif\x00\x00"):
        return None
    tiff = payload[6:]
    if len(tiff) < 8:
        raise ValueError("손상된 EXIF TIFF 헤더입니다.")
    byte_order = tiff[:2]
    if byte_order == b"II":
        endian = "<"
    elif byte_order == b"MM":
        endian = ">"
    else:
        raise ValueError("알 수 없는 EXIF 바이트 순서입니다.")
    if struct.unpack_from(endian + "H", tiff, 2)[0] != 42:
        raise ValueError("손상된 EXIF TIFF 식별자입니다.")
    ifd_offset = struct.unpack_from(endian + "I", tiff, 4)[0]
    if ifd_offset + 2 > len(tiff):
        raise ValueError("손상된 EXIF IFD 오프셋입니다.")
    count = struct.unpack_from(endian + "H", tiff, ifd_offset)[0]
    entry_pos = ifd_offset + 2
    for _ in range(count):
        if entry_pos + 12 > len(tiff):
            raise ValueError("손상된 EXIF IFD 항목입니다.")
        tag, value_type, value_count = struct.unpack_from(endian + "HHI", tiff, entry_pos)
        if tag == 0x0112 and value_type == 3 and value_count >= 1:
            return struct.unpack_from(endian + "H", tiff, entry_pos + 8)[0]
        entry_pos += 12
    return None


def assert_jpeg_orientation_safe(data: bytes) -> None:
    for _, _, marker, payload in jpeg_segments(data):
        if marker == 0xE1:
            orientation = exif_orientation(payload)
            if orientation not in (None, 1):
                raise ValueError(f"JPEG 방향값이 {orientation} 입니다. 픽셀 방향을 먼저 정상화한 뒤 다시 실행하세요.")
        if marker in (0xDA, 0xD9):
            break


def clean_jpeg(data: bytes) -> bytes:
    output = bytearray(data[:2])
    for start, end, marker, _ in jpeg_segments(data):
        if marker in (0xDA, 0xD9):
            output.extend(data[start:])
            break
        if marker not in BLOCKED_JPEG_MARKERS:
            output.extend(data[start:end])
    return bytes(output)


def metadata(data: bytes, kind: str) -> List[str]:
    return png_metadata(data) if kind == "PNG" else jpeg_metadata(data)


def payload_hash(data: bytes, kind: str) -> str:
    digest = hashlib.sha256()
    if kind == "PNG":
        for _, _, chunk_type, payload in png_chunks(data):
            if chunk_type == b"IDAT":
                digest.update(payload)
    else:
        for start, _, marker, _ in jpeg_segments(data):
            if marker == 0xDA:
                digest.update(data[start:])
                break
    return digest.hexdigest()


def verify(path: Path) -> Tuple[str, str]:
    data = path.read_bytes()
    kind = image_kind(data)
    found = metadata(data, kind)
    if found:
        raise ValueError(f"메타데이터 검사 실패: {', '.join(found)}")
    return kind, payload_hash(data, kind)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--input", required=True, type=Path, help="검사 또는 정리할 PNG/JPEG")
    parser.add_argument("--output", type=Path, help="정리된 새 파일 경로")
    parser.add_argument("--verify-only", action="store_true", help="파일을 변경하지 않고 검사만 수행")
    args = parser.parse_args()

    input_path = args.input.expanduser().resolve(strict=True)
    input_data = input_path.read_bytes()
    kind = image_kind(input_data)

    if args.verify_only:
        verified_kind, digest = verify(input_path)
        print(f"PASS: {input_path} ({verified_kind})")
        print(f"PAYLOAD_SHA256: {digest}")
        return 0

    if args.output is None:
        parser.error("--output is required unless --verify-only is used")
    output_path = args.output.expanduser().resolve()
    if input_path == output_path:
        raise ValueError("원본을 덮어쓸 수 없습니다. 다른 출력 경로를 사용하세요.")
    if output_path.exists():
        raise FileExistsError("출력 파일이 이미 존재합니다. 버전이 붙은 새 파일명을 사용하세요.")

    original_metadata = metadata(input_data, kind)
    original_hash = payload_hash(input_data, kind)
    if kind == "PNG":
        output_data = clean_png(input_data)
    else:
        assert_jpeg_orientation_safe(input_data)
        output_data = clean_jpeg(input_data)

    output_kind = image_kind(output_data)
    remaining = metadata(output_data, output_kind)
    if remaining:
        raise ValueError(f"메타데이터 제거 실패: {', '.join(remaining)}")
    cleaned_hash = payload_hash(output_data, output_kind)
    if original_hash != cleaned_hash:
        raise ValueError("이미지 페이로드가 변경되었습니다.")

    output_path.parent.mkdir(parents=True, exist_ok=True)
    output_path.write_bytes(output_data)
    print(f"CLEAN: {output_path}")
    print(f"REMOVED: {', '.join(original_metadata)}")
    print(f"PAYLOAD_SHA256: {cleaned_hash}")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except Exception as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        raise SystemExit(1)
