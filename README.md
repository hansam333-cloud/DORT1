# DORT-OPS

DORT-OPS is the operating system for DØRT, a men's fashion brand focused on restrained masculinity, sharp physical silhouettes, and sensuality expressed through fit rather than exposure.

This project documents the agents, templates, workflows, and examples used to plan products, create detail pages, produce content, style outfits, respond to customers, and improve products from reviews.

## Agent System

```text
DORT-OPS
├── Product Planning Agent
├── Product Registration Agent
├── Fitting Image Agent
├── Detail Page Agent
├── Content Planning Agent
├── Styling Agent
├── Customer Response Agent
└── Review Insight Agent
```

## Recommended Workflow

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

## Folder Structure

```text
.
├── README.md
├── brand/
│   ├── brand-guide.md
│   └── target-customer.md
├── agents/
├── templates/
├── examples/
├── outputs/
│   ├── detail-pages/
│   ├── contents/
│   └── styling/
└── docs/
    ├── workflow.md
    ├── first-product-test-workflow.md
    ├── change-management-workflow.md
    └── dort-current-context-summary.md
```

## Brand Direction

DØRT is not a general men's clothing mall. It is built around clothes that make athletic or better-than-average body types look sharper, more balanced, and quietly magnetic in everyday life.

Core fit principle:

> Restrained masculinity, sharp physical silhouette, sensuality through fit rather than exposure.

## Current Status

This repository is in the initial planning stage.

Build order:

1. Brand guide and target customer docs - Done
2. Product Planning Agent - Done
3. Product Registration Agent - Done
4. Fitting Image Agent - Done
5. Detail Page Agent - Done
6. Content Planning Agent - Done
7. Styling Agent - Done
8. Customer Response Agent - Done
9. Review Insight Agent - Done
10. Test workflow with one product - Done

## Product Planning Agent

The first agent is now defined.

Files:

- `agents/product-planning-agent.md`
- `templates/product-input-template.md`
- `examples/product-planning-example.md`

This agent evaluates product candidates before they move into product registration, fitting image generation, detail page writing, content planning, styling, and customer response.

## Product Registration Agent

The second agent is now defined.

Files:

- `agents/product-registration-agent.md`
- `templates/product-library-record-template.md`

This agent registers product lock values before fitting image generation. It separates product intended fit from requested image fit, preserves product-specific details, checks reference sufficiency, and decides safe generation angles.

## Fitting Image Agent

The third agent is now defined.

Files:

- `agents/fitting-image-agent.md`
- `templates/fitting-image-request-template.md`
- `templates/model-profile-template.md`
- `templates/fitting-image-qa-template.md`
- `examples/fitting-image-example.md`
- `examples/fitting-image-product-replacement-example.md`

This agent creates product-accurate model fitting image prompts for detail pages, SNS, and lookbooks from registered product lock records. It registers reusable model profiles, asks for requested fit and length before generation, creates generation and replacement prompts, and QA-checks whether each result is accurate enough for ecommerce use.

## Detail Page Agent

The fourth agent is now defined.

Files:

- `agents/detail-page-agent.md`
- `templates/detail-page-template.md`
- `examples/detail-page-example.md`

This agent turns a product planning result, product registration record, and fitting image direction into a purchase-ready ecommerce detail page structure with fit points, model fit check, size guide, image order, styling section, and final copy draft.

## Content Planning Agent

The fifth agent is now defined.

Files:

- `agents/content-planning-agent.md`
- `templates/content-brief-template.md`
- `examples/content-planning-example.md`

This agent turns a product registration record and product message into short-form videos, feed carousel posts, captions, hashtags, shooting checklists, and a 7-day content plan.

## Styling Agent

The sixth agent is now defined.

Files:

- `agents/styling-agent.md`
- `templates/styling-request-template.md`
- `examples/styling-example.md`

This agent creates outfit combinations, product set suggestions, detail page styling blocks, content styling ideas, and cross-sell copy using the registered product fit and detail constraints.

## Customer Response Agent

The seventh agent is now defined.

Files:

- `agents/customer-response-agent.md`
- `templates/customer-inquiry-template.md`
- `examples/customer-response-example.md`

This agent creates DORT-tone replies for size questions, fit questions, styling questions, shipping questions, exchange/return guidance, review requests, and post-purchase care using the product registration record as the fit/detail source of truth.

## Review Insight Agent

The eighth agent is now defined.

Files:

- `agents/review-insight-agent.md`
- `templates/review-analysis-template.md`
- `examples/review-insight-example.md`

This agent analyzes reviews, inquiries, exchange/return reasons, and customer feedback against the product registration record to improve products, detail pages, content, styling, and customer responses.

## First Product Test Workflow

The first full workflow document is now defined.

File:

- `docs/first-product-test-workflow.md`

This document shows how one product moves through the full DORT-OPS loop:

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

## Change Management Workflow

The repository change workflow is now defined.

File:

- `docs/change-management-workflow.md`

This document explains how DORT1 changes should be planned, confirmed, edited, checked, committed, and pushed.

## Current Version

```text
v0.1 - Initial DORT operating agent system
```

The first version is complete as a document-based operating system. Next improvements can focus on testing the agents with real products, adding more examples, and turning repeated workflows into automation.
