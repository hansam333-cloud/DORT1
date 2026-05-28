# DORT-OPS

DORT-OPS is the operating system for DORT, a men's fashion brand focused on physical-fit dailywear for men who want their body shape and proportions to look better in everyday outfits.

This project documents the agents, templates, workflows, and examples used to plan products, create detail pages, produce content, style outfits, respond to customers, and improve products from reviews.

## Agent System

```text
DORT-OPS
├── Product Planning Agent
├── Detail Page Agent
├── Content Planning Agent
├── Styling Agent
├── Customer Response Agent
└── Review Insight Agent
```

## Recommended Workflow

```text
Product Planning
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
    └── workflow.md
```

## Brand Direction

DORT is not a general men's clothing mall. It is built around clothes that make athletic or better-than-average body types look balanced in everyday life.

Core fit principle:

> Shoulders wider, arms naturally filled, waist cleaner, proportions sharper.

## Current Status

This repository is in the initial planning stage.

Build order:

1. Brand guide and target customer docs - Done
2. Product Planning Agent - Done
3. Detail Page Agent - Done
4. Content Planning Agent - Done
5. Styling Agent - Done
6. Customer Response Agent - Done
7. Review Insight Agent - Done
8. Test workflow with one product - Done

## Product Planning Agent

The first agent is now defined.

Files:

- `agents/product-planning-agent.md`
- `templates/product-input-template.md`
- `examples/product-planning-example.md`

This agent evaluates product candidates before they move into detail page writing, content planning, styling, and customer response.

## Detail Page Agent

The second agent is now defined.

Files:

- `agents/detail-page-agent.md`
- `templates/detail-page-template.md`
- `examples/detail-page-example.md`

This agent turns a product planning result into a purchase-ready ecommerce detail page structure with fit points, model fit check, size guide, shooting direction, styling section, and final copy draft.

## Content Planning Agent

The third agent is now defined.

Files:

- `agents/content-planning-agent.md`
- `templates/content-brief-template.md`
- `examples/content-planning-example.md`

This agent turns a product message into short-form videos, feed carousel posts, captions, hashtags, shooting checklists, and a 7-day content plan.

## Styling Agent

The fourth agent is now defined.

Files:

- `agents/styling-agent.md`
- `templates/styling-request-template.md`
- `examples/styling-example.md`

This agent creates outfit combinations, product set suggestions, detail page styling blocks, content styling ideas, and cross-sell copy.

## Customer Response Agent

The fifth agent is now defined.

Files:

- `agents/customer-response-agent.md`
- `templates/customer-inquiry-template.md`
- `examples/customer-response-example.md`

This agent creates DORT-tone replies for size questions, fit questions, styling questions, shipping questions, exchange/return guidance, review requests, and post-purchase care.

## Review Insight Agent

The sixth agent is now defined.

Files:

- `agents/review-insight-agent.md`
- `templates/review-analysis-template.md`
- `examples/review-insight-example.md`

This agent analyzes reviews, inquiries, exchange/return reasons, and customer feedback to improve products, detail pages, content, styling, and customer responses.

## First Product Test Workflow

The first full workflow document is now defined.

File:

- `docs/first-product-test-workflow.md`

This document shows how one product moves through the full DORT-OPS loop:

```text
Product Planning
→ Detail Page
→ Content Planning
→ Styling
→ Customer Response
→ Review Insight
→ Product Planning
```

## Current Version

```text
v0.1 - Initial DORT operating agent system
```

The first version is complete as a document-based operating system. Next improvements can focus on testing the agents with real products, adding more examples, and turning repeated workflows into automation.
