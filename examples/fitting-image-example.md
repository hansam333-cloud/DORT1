# Fitting Image Example

## Request Summary

```text
Mode: New fitting image generation
Output use: detail page main fitting cut
Product: DORT-TEE-001-BK
Model: MODEL-SAEM
Goal: Create a product-accurate full-body fitting image before building the detail page.
```

## Model Profile

```text
Model ID: MODEL-SAEM
Height: 178cm
Weight: 76kg
Top size: L
Bottom size: M-L
Shoulder width: broad
Chest: athletic
Waist: clean but not slim
Preferred fit: semi-over top with clean straight or wide pants
Face reference images: front, 45-degree, side, natural expression
Full-body reference images: front, side, back, natural standing
Angle references: front, side, 45-degree
Proportions that must not change: shoulder width, arm length, leg length, waist line
```

## Product Information

```text
Product ID: DORT-TEE-001-BK
Product name: Physical-Fit Cooling Muscle Tee
SKU: DORT-TEE-001
Category: Short sleeve tee
Color: Black
Material: cooling cotton blend
Fit: shoulder-enhancing semi-muscle fit
Size: L
Available color options: Black, White, Charcoal
Front image: available
Back image: available
Side image: available
Detail images: collar, sleeve opening, hem, fabric texture
```

## Reference Sufficiency Decision

```text
Model reference status: GREEN
Product reference status: GREEN
Generation allowed: Yes
Reason: Front, back, side, and key detail references are available. Requested front full-body composition does not require guessing hidden details.
```

## Product Preservation Notes

```text
Preserve:
- Black cooling cotton blend texture
- Clean crew neck shape
- Shoulder-enhancing sleeve angle
- Semi-muscle fit through chest and arms
- Relaxed but clean body line
- Original hem length
- No added logo or print

Must be visible:
- Shoulder line
- Sleeve opening
- Chest fit
- Waist drop
- Hem length
```

## Image Generation Plan

```text
Image ID: DORT-TEE-001-BK_MODEL-SAEM_MAIN-FIT_FRONT_4x5_v01
Output use: detail page main fitting cut
Product ID: DORT-TEE-001-BK
Model ID: MODEL-SAEM
Composition: full-body front
Camera height: eye-level
Lens feel: natural ecommerce lens, no wide distortion
Crop: full body with clean margin
Background: neutral gray studio background
Pose: natural standing pose
Visible product details: collar, shoulder line, sleeve opening, chest fit, hem
Details that must not be hidden: collar, sleeve opening, hem
Lighting: soft studio lighting
Image ratio: 4:5
Reference sufficiency: GREEN
QA priority: product detail accuracy
```

## Main Prompt

```text
Create a realistic men's fashion ecommerce fitting image for DORT.

Use MODEL-SAEM as the model identity. Preserve the model's face, body shape, shoulder width, arm length, leg length, waist line, and overall proportions from the registered references.

Product ID: DORT-TEE-001-BK
Product name: Physical-Fit Cooling Muscle Tee
Category: Short sleeve tee
Color: Black
Size: L
Material: cooling cotton blend
Fit: shoulder-enhancing semi-muscle fit

Create a full-body front fitting image in a neutral gray studio background, 4:5 ratio, eye-level camera, natural standing pose.

Preserve the product exactly. Keep the black color, clean crew neck, sleeve opening, shoulder-enhancing fit, chest fit, body line, hem length, and fabric texture. Do not add logos, prints, pockets, seams, or design elements that are not in the product references.

The image should look like a real men's clothing detail-page fitting photo. The garment fit, fabric wrinkles, shadows, lighting, body interaction, and perspective must look natural.
```

## Negative Prompt

```text
Do not change the model identity. Do not change the model body proportions. Do not make the model taller, slimmer, more muscular, younger, older, or more stylized than the references. Do not alter the product silhouette, color, material, texture, length, seams, stitching, neckline, sleeve, hem, or fit. Do not invent missing product details. Do not hide important product details. Avoid distorted hands, extra fingers, broken wrists, unnatural neck, warped shoulders, unrealistic waist, twisted legs, floating fabric, melted fabric, incorrect shadows, plastic skin, over-retouching, mannequin texture, artificial fashion editorial lighting, and AI-looking artifacts.
```

## QA Checklist

```text
Model identity: Pass
Body proportions: Pass
Product detail accuracy: Pass
Fit realism: Pass
Anatomy: Pass
Lighting and background: Pass
Detail-page usefulness: Pass
Approved: Yes
Revision needed: None
Additional references needed: None
```

## Detail Page Handoff

```text
Approved fitting image IDs:
- DORT-TEE-001-BK_MODEL-SAEM_MAIN-FIT_FRONT_4x5_v01

Best hero image:
- Use the full-body front image as the main hero fitting cut.

Detail cut recommendations:
- Collar close-up
- Sleeve opening close-up
- Fabric texture close-up
- Hem length crop

Visible fit notes:
- Shoulder line looks wider
- Sleeve opening fills the arm naturally
- Body line stays clean without tight compression
- Hem length works for daily styling
```

## Mirror Shot Variation Example

```text
Mode: Composition/background/pose variation
Output use: SNS feed image
Product ID: DORT-TEE-001-BK
Model ID: MODEL-SAEM
Composition: mirror selfie
Pose: mirror selfie pose
Background: clean fitting room mirror
Image ratio: 4:5

Must preserve:
- Model identity and body proportions
- Tee color, neckline, sleeve opening, chest fit, and hem length

Must not hide:
- Collar
- Shoulder line
- Sleeve opening
- Chest fit
- Hem

Rule:
The phone, hand, arm, and mirror frame must not block important product details. The mirror reflection must not distort the model's body proportions or product silhouette.
```

## Third-Person Selfie Capture Example

```text
Mode: Composition/background/pose variation
Output use: natural SNS snap
Product ID: DORT-TEE-001-BK
Model ID: MODEL-SAEM
Composition: third-person view of model taking a selfie
Pose: taking a selfie while being photographed by another camera
Background: simple indoor studio or showroom
Image ratio: 4:5

Must preserve:
- Model identity and body proportions
- Tee color, neckline, sleeve opening, chest fit, and hem length

Must not hide:
- Collar
- Shoulder line
- Sleeve opening
- Chest fit
- Hem

Rule:
This is not a mirror reflection shot. A separate camera photographs the model while the model is taking a phone selfie. The phone, hand, and arm must not block key product details or fit lines.
```
