# DORT Current Context Summary

Last updated: 2026-06-14

Use this file as the handoff note when starting a new chat.

Suggested first message:

```text
/Users/saem/Documents/Practice/DORT1/docs/dort-current-context-summary.md 파일을 먼저 읽고 DORT 기준으로 이어서 진행해줘.
```

## 현재 상태 요약

DORT1 is the document-based operating system for DØRT, a men's fashion brand.

DØRT is not a general men's clothing mall. The brand direction is:

```text
절제된 남성미, 선명한 피지컬 실루엣, 노출보다 핏으로 드러나는 섹시함.
```

Core mood:

- restrained masculinity
- sharp physical silhouette
- sensuality through fit rather than exposure
- low-tone contemporary
- restrained sexy
- subtle tension
- strong but refined

Avoid using `minimal` or `clean` as core brand mood words. Functional uses such as clean margin, clean studio background, or clean crew neck can remain when they describe a visual or product feature rather than the brand mood.

## 현재 에이전트 흐름

Recommended workflow:

```text
Product Planning
→ Product Registration
→ Fitting Image
→ Detail Page
→ Content Planning
→ Styling
→ Customer Response
→ Review Insight
→ Product Planning
```

Current agent documents are complete as v0.1:

- Product Planning Agent
- Product Registration Agent
- Fitting Image Agent
- Detail Page Agent
- Content Planning Agent
- Styling Agent
- Customer Response Agent
- Review Insight Agent

## Product Registration Agent 기준

Product Registration Agent is separate from Fitting Image Agent.

Its role is to create product lock values before image generation:

- product ID
- category
- product intended fit
- silhouette
- length
- color
- material and texture
- neckline
- sleeve
- hem
- pockets
- buttons, zippers, and hardware
- details to preserve
- details that can be adjusted
- details that must not be invented
- safe and unsafe generation angles
- missing reference requests

Important rule:

Product intention wins by default. If a product is designed as oversized, relaxed, outerwear, or loose fit, do not force it into DORT's summer default fit.

DORT summer default fit direction:

- Athletic fit
- Muscle fit

These are defaults for suitable summer products, not rules that override every product.

## Fitting Image Agent 기준

Fitting Image Agent creates fitting-image prompts and QA from registered product records.

It should not create product lock values from scratch. If the product registration record is missing, unclear, or unsafe for the requested angle, send it back to Product Registration Agent.

Before image generation, ask or confirm:

- requested fit: Product-intended, Athletic, Muscle, or Other
- requested length: Short, Regular, Semi-long, or Long
- output use: Detail page, SNS, Lookbook, Mirror selfie, or Other
- background
- pose
- composition

Supported image directions include:

- detail-page main fitting cut
- SNS natural cut
- lookbook cut
- mirror selfie
- third-person view of the model taking a selfie
- product replacement in an existing fitting image

For indoor fitting cuts, natural daylight can be used when it looks realistic and does not hide product details.

## 테스트 샘플 주의

The oatmeal/ivory henley short sleeve tee used in early fitting image tests is not a DØRT product.

It must be treated only as:

```text
temporary test sample
not a DØRT product
do not use for product library
```

Do not use that henley tee as a real product registration record, detail page source, content source, styling source, or DØRT product-library reference.

## 파일 관리 기준

Safe to keep in GitHub:

- brand documents
- agent manuals
- templates
- examples
- workflow documents
- public operating rules

Keep private and local only:

- face references
- body references
- full-body studio references
- personal measurements if sensitive
- generated image test outputs
- private fitting-test packages
- local image paths for personal photos

Private fitting-test data should stay outside normal GitHub commits unless the user explicitly says otherwise.

## 다음 작업 후보

Recommended next steps:

1. 실제 첫 DØRT 제품 후보를 정한다.
2. Product Planning Agent로 제품 방향을 정리한다.
3. Product Registration Agent로 제품 lock values를 등록한다.
4. 스튜디오 기준 사진을 촬영해 얼굴/체형 기준 데이터를 개선한다.
5. Fitting Image Agent로 실제 제품 피팅컷 테스트를 진행한다.
6. 생성 결과를 QA하고, 통과한 이미지 기준으로 Detail Page Agent에 넘긴다.

When making repo changes, follow `docs/change-management-workflow.md`: check current state, propose the change, edit only confirmed scope, run checks, then commit and push only when requested.
