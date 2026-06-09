# Change Management Workflow

This document defines how DORT1 should be changed going forward.

The goal is simple:

```text
Plan first. Confirm scope. Then edit, check, commit, and push.
```

## When To Use This Workflow

Use this workflow for any DORT1 change that edits repository files, including:

- Agent definitions
- Templates
- Examples
- Workflow docs
- README updates
- GitHub commits or pushes

Read-only exploration does not require approval. File edits do.

## 1. Check Current State

Before proposing changes, inspect the current repository state.

Required checks:

```text
git status -sb
git log --oneline --decorate -5
```

Also read only the files directly related to the requested change.

## 2. Propose The Change

Before editing files, explain:

- Goal of the change
- Files expected to change
- Why each change is needed
- Expected impact on the existing DORT1 structure
- Whether the change should be committed and pushed to GitHub

Do not edit tracked files until the user confirms the plan.

User confirmations can be explicit phrases such as:

```text
진행해
이대로 해줘
실행해줘
implement this plan
```

## 3. Execute Only The Approved Scope

When the user confirms, edit only the approved files and scope.

Do not:

- Stage unrelated files
- Include `.DS_Store`
- Rewrite unrelated docs
- Reorder workflows unless requested
- Push unconfirmed changes

If a new issue appears during implementation, stop and explain the new decision needed.

## 4. Check Before Commit

After editing, run:

```text
git diff --check
git status -sb
git diff --stat
```

Then summarize:

- Files changed
- Size of the change
- Any check failures
- Suggested commit message

## 5. Commit And Push

Commit only after the intended scope is staged.

Suggested commit style:

```text
Add ...
Update ...
Move ...
Complete ...
```

After committing, push to GitHub when requested or when the user has already asked to keep GitHub updated.

If terminal GitHub authentication fails, open GitHub Desktop and ask the user to press `Push origin`.

## 6. Final Report

After completion, report:

- Changed files
- Commit hash
- GitHub push status
- Current repo status
- Suggested next step

## Default Assumptions

- DORT1 remains the main operating system for the men's clothing mall.
- The Fitting Image Agent remains inside DORT1.
- Product planning, fitting images, detail pages, content, styling, customer response, and review insight should stay connected in one workflow.
- Future repo edits should be planned and confirmed before implementation.
