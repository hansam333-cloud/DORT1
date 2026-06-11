# Fitting Image Product Replacement Example

## Request Summary

```text
Mode: Product replacement
Existing image ID: DORT-TEE-001-BK_MODEL-SAEM_MAIN-FIT_FRONT_4x5_v01
Replace: DORT-TEE-001-BK
With: DORT-SHIRT-003-WH
Goal: Keep the same model, pose, background, lighting, and camera while replacing only the top.
```

## Product To Insert

```text
Product ID: DORT-SHIRT-003-WH
Product name: Clean Semi-Over Short Sleeve Shirt
Category: Short sleeve shirt
Color: White
Material: cotton nylon blend
Product intended fit: Semi-over
Default DORT summer fit recommendation: Product-intended
Requested fit: Product-intended
Requested length: Product-intended
Size: L
Available color options: White, Light Blue
References: front, back, side, collar, button placket, chest pocket, sleeve, hem, fabric close-up
```

## Reference Sufficiency Decision

```text
Model reference status: GREEN
Product registration status: GREEN
Generation allowed: Yes
Reason: Replacement product has enough references for front full-body pose. Button placket, collar, chest pocket, sleeve, and hem are visible and verified.
```

## Product Replacement Prompt

```text
Edit the existing fitting image.

Keep:
- MODEL-SAEM identity
- Model body proportions
- Full-body front pose
- Neutral gray studio background
- Eye-level camera
- Soft studio lighting
- 4:5 crop

Replace only:
- Remove DORT-TEE-001-BK
- Add DORT-SHIRT-003-WH

Requested fit:
- Product-intended

Requested length:
- Product-intended

Fit conflict handling:
- Product intention wins by default

Preserve the new product exactly:
- White cotton nylon blend texture
- Semi-over shirt silhouette
- Collar shape
- Button placket
- Chest pocket placement
- Sleeve length and opening
- Hem shape and length

Do not transfer any tee details into the shirt. Do not add extra pockets, buttons, logos, prints, or seams. Make the shirt naturally fit the same model body with believable fabric thickness, wrinkles, shadows, and layering.
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
