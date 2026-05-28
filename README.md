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

First build order:

1. Brand guide and target customer docs
2. Product Planning Agent
3. Detail Page Agent
4. Content Planning Agent
5. Styling Agent
6. Customer Response Agent
7. Review Insight Agent
8. Test workflow with one product
