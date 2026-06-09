# Fitting Image Request Template

Use this template when asking the Fitting Image Agent to register a model, register a product, generate fitting images, create variations, replace a product, or QA generated images.

## Operating Mode

```text
Mode:
Choose one:
- Model profile registration
- Product library registration
- New fitting image generation
- Composition/background/pose variation
- Product replacement
- QA and revision
```

## Model Profile

```text
Model ID:
Height:
Weight:
Top size:
Bottom size:
Shoulder width:
Chest:
Waist:
Hip:
Arm length:
Leg length:
Preferred fit:
Proportions that must not change:
Face reference images:
Full-body reference images:
Angle references:
Notes:
```

## Product Information

```text
Product ID:
Product name:
SKU:
Category:
Color:
Material:
Fit:
Size:
Measurements:
Available color options:
Front image:
Back image:
Side image:
Detail images:
Previous generated image references:
Approved prompt references:
Failed prompt references:
```

## Product Detail Preservation

```text
Silhouette:
Length:
Fit:
Color:
Material texture:
Fabric thickness:
Pocket placement:
Button count:
Zippers:
Seams:
Stitching:
Logo:
Print:
Washing:
Pattern:
Hem:
Sleeve shape:
Collar shape:
Hardware:
Other details:
```

## Reference Sufficiency Check

```text
Model reference status: GREEN / YELLOW / RED
Product reference status: GREEN / YELLOW / RED
Missing model references:
Missing product references:
Details that cannot be verified:
Generation allowed: Yes / No
Reason:
```

## Output Request

```text
Output use:
Composition:
Camera height:
Background:
Pose:
Image ratio:
Number of variations:
Products to include:
Product to replace:
Details that must be visible:
Details that must not be hidden:
```

## Existing Image To Edit

Use this section only for product replacement or revision.

```text
Existing image ID:
Existing image reference:
Keep:
Replace:
Fix:
Do not change:
```

## Image Generation Plan

```text
Image ID:
Output use:
Product ID:
Model ID:
Composition:
Camera height:
Lens feel:
Crop:
Background:
Pose:
Visible product details:
Details that must not be hidden:
Lighting:
Image ratio:
Reference sufficiency:
QA priority:
```

## Final Prompt

```text
등록된 모델 프로필을 기준으로 아래 제품을 착용한 남성의류 쇼핑몰 피팅컷을 생성해줘.

모델 ID:
모델 프로필:
모델 레퍼런스:

제품 ID:
제품명:
카테고리:
컬러:
착용 사이즈:
소재:
핏:
실측:
사용할 제품 이미지:
반드시 보존할 디테일:
반드시 보여야 하는 디테일:
가리면 안 되는 디테일:

용도:
원하는 구도:
카메라 높이:
원하는 배경:
원하는 포즈:
이미지 비율:

제품 디테일은 원본과 동일하게 유지해줘.
제품의 실루엣, 기장, 컬러, 소재감, 원단 두께, 주머니 위치, 단추 수, 지퍼, 절개선, 스티치, 로고, 프린팅, 워싱, 패턴, 밑단, 소매, 카라, 하드웨어는 임의로 바꾸지 마.

모델의 얼굴과 체형은 등록된 프로필과 일관되게 유지해줘.
모델을 임의로 더 마르게, 더 크게, 더 근육질로, 더 어리게, 더 화보 모델처럼, 또는 다른 사람처럼 보이게 만들지 마.

실제 남성의류 쇼핑몰에서 촬영한 피팅컷처럼 자연스럽게 만들어줘.
옷의 주름, 원단 두께, 그림자, 착용감, 몸과 옷의 접촉, 카메라 원근감이 자연스러워야 해.

제품 정보가 부족해서 정확한 재현이 어렵다면 임의로 생성하지 말고 추가 이미지가 필요하다고 알려줘.
```

## Negative Prompt

```text
Do not change the model identity. Do not change the model body proportions. Do not make the model taller, slimmer, more muscular, younger, older, or more stylized than the references. Do not alter the product silhouette, color, material, texture, length, pockets, buttons, zippers, seams, stitching, logo, print, wash, pattern, hem, sleeve, collar, hardware, or fit. Do not invent missing product details. Do not hide important product details. Avoid distorted hands, extra fingers, broken wrists, unnatural neck, warped shoulders, unrealistic waist, twisted legs, floating fabric, melted fabric, incorrect shadows, plastic skin, over-retouching, mannequin texture, artificial fashion editorial lighting, and AI-looking artifacts.
```

## QA Checklist

```text
Model identity: Pass / Fail
Body proportions: Pass / Fail
Product detail accuracy: Pass / Fail
Fit realism: Pass / Fail
Anatomy: Pass / Fail
Lighting and background: Pass / Fail
Detail-page usefulness: Pass / Fail
Approved: Yes / No
Revision needed:
Additional references needed:
```

## Detail Page Handoff

```text
Approved fitting image IDs:
Best hero image:
Full-body image:
Detail cut recommendations:
Product details proven by images:
Product details needing separate close-ups:
Visible fit notes:
Image limitations:
Risk notes:
```

