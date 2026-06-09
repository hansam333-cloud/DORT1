# DORT-OPS Workflow

## Overview

DORT-OPS is designed as a loop. Each agent creates information that the next agent can reuse.

```text
Product Planning
→ Fitting Image
→ Detail Page
→ Content Planning
→ Styling
→ Customer Response
→ Review Insight
→ Product Planning
```

## 1. Product Planning Agent

Purpose:

- Decide whether a product fits the DORT brand
- Define target body type
- Set product USP
- Suggest price range
- Create product name candidates
- Suggest shooting points

Main output:

```text
Product concept brief
```

## 2. Fitting Image Agent

Purpose:

- Generate product-accurate fitting images from product-only photos
- Preserve the registered model's face and body proportions
- Preserve product details across detail pages, SNS images, and lookbooks
- Support composition, background, pose, color-option, and product-replacement requests

Main output:

```text
Product-accurate fitting image prompt and generation request
```

## 3. Detail Page Agent

Purpose:

- Turn the product brief and fitting image direction into a purchase-ready detail page
- Write fit points
- Create size guide
- Plan image order and detail cuts
- Build page copy and structure

Main output:

```text
Detail page draft
```

## 4. Content Planning Agent

Purpose:

- Convert product value into short-form and feed content
- Create hooks, scripts, captions, card news structures, and hashtags

Main output:

```text
Content package
```

## 5. Styling Agent

Purpose:

- Recommend outfit combinations
- Increase average order value through set suggestions
- Create body-type and situation-based styling

Main output:

```text
Styling recommendation set
```

## 6. Customer Response Agent

Purpose:

- Reply to customer questions in DORT tone
- Recommend sizes based on height, weight, body type, and preferred fit
- Handle shipping, exchange, return, and review messages

Main output:

```text
Customer reply draft
```

## 7. Review Insight Agent

Purpose:

- Analyze customer reviews and return reasons
- Identify size confusion, fit issues, fabric issues, and missing detail-page information
- Feed improvement points back into product planning and detail pages

Main output:

```text
Improvement insight report
```

## Test Product

Initial test product:

```text
[피지컬핏] 쿨링 머슬 반팔티
```

This product should be used to test every agent once.
