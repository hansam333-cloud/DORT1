# First Product Test Workflow

This document shows how the first DORT product can move through the complete DORT-OPS agent system.

Test product:

```text
[피지컬핏] 쿨링 머슬 반팔티
```

## Step 1. Product Planning Agent

Input:

- Product specs
- Fit notes
- Model fit information
- Expected price
- Competitor references

Output:

- DORT fit score
- Positioning
- Product name candidates
- Key selling points
- Detail page direction
- Shooting direction

Next:

Pass the product planning result to the Fitting Image Agent.

## Step 2. Fitting Image Agent

Input:

- Product planning result
- Product-only photos
- Registered model face references
- Registered model full-body references
- Desired detail-page composition
- Desired background
- Desired pose

Output:

- Product-accurate fitting image prompt
- Required product reference checklist
- Main fitting cut direction
- Full-body, upper-body, side, back, and detail cut direction
- Product detail preservation notes
- Missing image requests if the product cannot be reproduced accurately

Next:

Pass the fitting image result and approved image direction to the Detail Page Agent.

## Step 3. Detail Page Agent

Input:

- Product planning result
- Fitting image result
- Product information
- Model fit information
- Approved fitting images or shooting plan

Output:

- Detail page title
- Top purchase hooks
- DORT FIT POINT
- Model fit check
- Size guide
- Detail cut plan
- Final copy draft

Next:

Pass hooks and fit points to the Content Planning Agent.

## Step 4. Content Planning Agent

Input:

- Product planning result
- Fitting image result
- Detail page result
- Main fit benefit
- Available photos and videos
- Launch goal

Output:

- Hook bank
- Short-form ideas
- Full short-form script
- Feed carousel copy
- Captions
- Hashtags
- 7-day content plan

Next:

Pass styling-related content to the Styling Agent.

## Step 5. Styling Agent

Input:

- Main product
- Fitting image result
- Detail page result
- Available products
- Styling target
- Situation

Output:

- Outfit combinations
- Product set suggestions
- Detail page styling block
- Cross-sell copy
- Content styling ideas

Next:

Use styling recommendations in detail pages, feed posts, and customer replies.

## Step 6. Customer Response Agent

Input:

- Customer message
- Product fit notes
- Size guide
- Styling result
- Store policy

Output:

- Recommended customer response
- Short version
- Detailed version
- Internal note
- Follow-up question
- Risk flag

Next:

Store repeated questions for the Review Insight Agent.

## Step 7. Review Insight Agent

Input:

- Reviews
- Customer inquiries
- Exchange/return reasons
- Detail page result
- Product size information

Output:

- Positive signals
- Negative signals
- Size and fit insights
- Detail page improvements
- Customer response improvements
- Content improvements
- Product improvements
- Priority action list

Next:

Feed insights back into Product Planning Agent and Detail Page Agent.

## Complete Loop

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

## Operating Rule

Every new DORT core product should pass through this workflow before launch or restock.
