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
10. Keep raw generated files under the workspace `work` folder. Save final user deliverables under `outputs` using Korean Standard Time and `YY.MM.DD_설명적이름.확장자`. Never overwrite; append `_v02`, `_v03`, and so on.
11. After visual approval, detect the operating system and create a separate cleaned PNG/JPEG: use `scripts/clean_metadata.ps1` on Windows or `scripts/clean_metadata.py` with `python3` on macOS. Never overwrite or delete the raw generated file.
12. Run the same platform script in verification mode on the cleaned file. Do not move it to `outputs` or report it as final unless visual checks and metadata verification pass.
13. If the required runtime or cleanup script cannot run, keep the generated image under `work` as a recoverable draft. Clearly report that cleanup is pending; do not delete the draft and do not present it as an approved final deliverable.
14. Report the generated colors, approved final file paths, validation result, any pending draft path, and any product-reference limitation. Do not claim that metadata cleanup removes platform detection or disclosure duties.

## Decision rules

- Ask only when missing information materially changes the result: target category, intended color, or which file is the edit target.
- Use conservative inference when a hidden product detail is not visible. Never invent decoration, pockets, hardware, logos, or text.
- Prefer front, side, back, 45-degree, and detail references. Clearly disclose when references are insufficient for exact reconstruction.
- Reject results with changed identity, anatomy, body proportions, non-target garments, product structure, color/material, or composition.
- Reject any final file that still contains C2PA/`caBX`/JUMBF or AI/tool-identifying metadata.
- Keep ICC color profiles because color accuracy matters. Normalize orientation before removing unnecessary EXIF orientation data.

## Metadata cleanup

Windows PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/clean_metadata.ps1 -InputPath <raw.png> -OutputPath <final.png>
powershell -ExecutionPolicy Bypass -File scripts/clean_metadata.ps1 -InputPath <final.png> -VerifyOnly
```

macOS with Python 3:

```bash
python3 scripts/clean_metadata.py --input <raw.png> --output <final.png>
python3 scripts/clean_metadata.py --input <final.png> --verify-only
```

Both scripts support PNG and JPEG and preserve encoded pixel/image data while removing supported metadata containers. If Python 3 is unavailable on macOS, keep the raw image in `work`, report the missing runtime, and wait for installation or another approved cleanup environment. For other image formats, stop and convert through an approved lossless workflow rather than pretending verification succeeded.
