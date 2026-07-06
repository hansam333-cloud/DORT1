---
name: product-fitting-image-editor
description: Create and edit photorealistic e-commerce fitting images by replacing exactly one product category—tops, bottoms, shoes, or bags—while preserving the model, non-target products, pose, camera, lighting, and background. Use when the user asks to swap apparel or accessories, make color variants, prepare product-detail-page fitting photos, validate product fidelity and anatomy, or remove AI-related metadata from the final PNG/JPEG deliverables.
---

# Product Fitting Image Editor

Produce product-accurate fitting-image variants for online product detail pages.

## Required workflow

1. Read `references/common-rules.md` for every task.
2. Classify the single target category and read exactly one prompt reference:
   - top: `references/tops.md`
   - bottom: `references/bottoms.md`
   - shoes: `references/shoes.md`
   - bag: `references/bags.md`
3. Read `references/checklist.md` before generation so required invariants are explicit.
4. Label each input by role: Image 1 as the edit target; Images 2..N as product references with their view and color.
5. Inspect every local input image before editing. When the user supplies a folder, inspect its image files and select the clearest authorized views for each requested color.
6. Load and use the built-in `imagegen` skill. Treat the task as `identity-preserve` plus `precise-object-edit`.
7. Generate only one product category and one color per call. Start every variant from the original fitting photo, never from a generated variant.
8. Preserve invariants aggressively. Allow changes only to the target product, the smallest necessary body-product boundary, occlusion, pressure, wrinkles, and contact shadow.
9. Inspect each result against the original and product references. Apply `references/checklist.md`. If an item fails, iterate with one targeted correction and repeat the critical invariants.
10. Keep the image generator's raw PNG under the workspace `work` folder. For opaque detail-page images, do not create an enlarged PNG intermediate; convert the raw image directly to a quality-95 JPEG at the requested dimensions. Use PNG as the final format only when transparency is required.
11. Save final user deliverables under `outputs` using Korean Standard Time and `YY.MM.DD_설명적이름.확장자`. Never overwrite; append `_v02`, `_v03`, and so on.
12. After visual approval, detect the operating system. For an opaque final, create one JPEG in `work` with `scripts/prepare_final_jpg.ps1` on Windows or `scripts/prepare_final_jpg.py` with `python3` on macOS, then clean it with the matching `clean_metadata` script into `outputs`. For a transparent final, skip JPEG conversion and clean the raw PNG directly. Never overwrite or delete the raw generated file.
13. Run the matching cleanup script in verification mode on the final file. Do not report it as final unless visual checks and metadata verification pass.
14. If the required runtime, conversion script, or cleanup script cannot run, keep the generated image under `work` as a recoverable draft. Clearly report that processing is pending; do not delete the draft and do not present it as an approved final deliverable.
15. Report the generated colors, approved final file paths, validation result, any pending draft path, and any product-reference limitation. Do not claim that metadata cleanup removes platform detection or disclosure duties.

## Decision rules

- Ask only when missing information materially changes the result: target category, intended color, or which file is the edit target.
- Use conservative inference when a hidden product detail is not visible. Never invent decoration, pockets, hardware, logos, or text.
- Prefer front, side, back, 45-degree, and detail references. Clearly disclose when references are insufficient for exact reconstruction.
- Reject results with changed identity, anatomy, body proportions, non-target garments, product structure, color/material, or composition.
- Reject any final file that still contains C2PA/`caBX`/JUMBF or AI/tool-identifying metadata.
- Keep ICC color profiles because color accuracy matters. Normalize orientation before removing unnecessary EXIF orientation data.

## Final output and metadata cleanup

Opaque output on Windows PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/prepare_final_jpg.ps1 -InputPath <raw.png> -OutputPath <work-final.jpg> -Quality 95 [-Width <pixels> -Height <pixels>]
powershell -ExecutionPolicy Bypass -File scripts/clean_metadata.ps1 -InputPath <work-final.jpg> -OutputPath <final.jpg>
powershell -ExecutionPolicy Bypass -File scripts/clean_metadata.ps1 -InputPath <final.jpg> -VerifyOnly
```

Opaque output on macOS with Python 3 and the built-in `sips` utility:

```bash
python3 scripts/prepare_final_jpg.py --input <raw.png> --output <work-final.jpg> --quality 95 [--width <pixels> --height <pixels>]
python3 scripts/clean_metadata.py --input <work-final.jpg> --output <final.jpg>
python3 scripts/clean_metadata.py --input <final.jpg> --verify-only
```

Transparent PNG output on Windows PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/clean_metadata.ps1 -InputPath <raw.png> -OutputPath <final.png>
powershell -ExecutionPolicy Bypass -File scripts/clean_metadata.ps1 -InputPath <final.png> -VerifyOnly
```

Transparent PNG output on macOS with Python 3:

```bash
python3 scripts/clean_metadata.py --input <raw.png> --output <final.png>
python3 scripts/clean_metadata.py --input <final.png> --verify-only
```

The conversion scripts perform one JPEG encode only. The cleanup scripts support PNG and JPEG and preserve encoded pixel/image data while removing supported metadata containers. If Python 3 or `sips` is unavailable on macOS, keep the raw image in `work`, report the missing runtime, and wait for installation or another approved processing environment. For other image formats, stop rather than pretending verification succeeded.
