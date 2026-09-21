---
name: artifact-template-youibot-ppt
description: "Create or edit fully editable YOUIBOT corporate PowerPoint decks through a mandatory requirements-confirmation and HTML-review workflow. Use when the user selects YOUIBOT 公司 PPT, asks for a presentation that follows the company template, or invokes $artifact-template-youibot-ppt. Always confirm a page-level outline, create a commentable HTML review draft, and wait for explicit HTML approval before generating PPTX. Preserve native editable text, shapes, tables, charts, and notes; never flatten slides into screenshots."
---

# YOUIBOT 公司 PPT

Use the retained company deck as the visual and structural source of truth. Keep `assets/reference.pptx` unchanged and build every deliverable from a copy.

This skill has two mandatory approval gates. Never skip them, even when the user's source material appears complete.

## Start here

1. Read `artifact-template.json` and resolve paths relative to this skill directory.
2. Read [references/intake-and-approval.md](references/intake-and-approval.md) and complete Gate 1 before creating slides.
3. Read [references/template-catalog.md](references/template-catalog.md), [references/style-system.md](references/style-system.md), [references/standard-components.md](references/standard-components.md), and [references/content-modes.md](references/content-modes.md). If the deck contains quantitative evidence, also read [references/data-storytelling.md](references/data-storytelling.md).
4. For the HTML review draft, read [references/html-review-workflow.md](references/html-review-workflow.md) and use [assets/html-review-template.html](assets/html-review-template.html) as the required shell.
5. Only after Gate 2, read [references/editable-workflow.md](references/editable-workflow.md) and generate the PPTX.

## Mandatory workflow

### Phase 0 — Complete the brief

0. Accept an incomplete invocation. The user may provide only a topic and source path; never require them to complete the full intake checklist before using this skill. Treat the invocation template in `references/intake-and-approval.md` as recommended input, then discover and ask for missing information yourself.
1. Inspect every file and source the user supplied. Summarize what is usable, what is ambiguous, and what is missing.
2. Classify the request as `培训/SOP型`, `汇报/数据型`, or a declared hybrid, then ask one consolidated round of questions covering purpose, audience, use setting, presentation duration, reading versus speaking density, target slide count, due date, title, presenter, date, required sections, source-of-truth priority, current numbers and units, images, logos, confidentiality, language, and speaker notes.
3. Ask follow-up questions when answers expose material gaps. Maximize source completeness before drafting. Do not invent business facts, results, dates, owners, targets, or metrics.
4. Distinguish blocking gaps from optional enhancements. If a non-blocking item is unavailable, record an explicit assumption or placeholder for approval.
5. Present a confirmed brief and a page-level outline. Each proposed slide must list: stable slide ID, title, communication purpose, key content, evidence/source, intended company-template layout, and any missing material.

### Gate 1 — Outline approval

Stop and wait for explicit user approval of the requirements brief and page-level outline. Approval must be clear in the conversation, such as “大纲确认” or an equivalent statement. Do not generate the HTML deck or PPTX before this gate.

### Phase 1 — Commentable HTML review draft

1. Create a single self-contained HTML review deck based only on the approved outline.
2. Build the default cover and numbered chapter dividers from `assets/standard-slide-components.html`. These are fixed components, not visual inspiration. Change only the fields and right-side semantic visual allowed by `references/standard-components.md`. Do not redesign them unless Gate 1 explicitly approves another retained company layout family.
3. Use a fixed 1920×1080, 16:9 slide stage and the company visual system. Keep slide content fixed; scale the stage uniformly rather than reflowing it.
4. Give every slide a stable `data-slide-id` matching the approved outline. Do not renumber IDs when slides move.
5. Include the review panel from `assets/html-review-template.html`: per-slide comment, status (`待审阅`, `需修改`, `已确认`), autosave to `localStorage`, previous/next navigation, and JSON export.
6. Keep review controls outside the slide stage so they never appear in exported slide content.
7. Render and visually inspect all slides for overflow, overlap, contrast, and company-brand consistency.
8. Deliver the HTML draft only. Do not generate a PPTX in the same turn.

### Gate 2 — HTML final approval

1. Accept comments through exported review JSON, pasted comments, or ordinary conversation.
2. Revise the HTML and return an updated draft. Repeat until the user explicitly confirms the HTML is final and authorizes PPT generation, such as “HTML 已确认，可以生成 PPT”.
3. Treat “看起来可以”, silence, a downloaded HTML file, or approval of only some slides as insufficient authorization.

### Phase 2 — Editable PPTX

1. Map every approved HTML slide to a source slide in the company catalog. The approved HTML is the content/layout contract, not a raster source.
2. Write `deck-plan.json` using [references/deck-plan-schema.md](references/deck-plan-schema.md). Prefer explicit text matches over position-only replacement.
3. On Windows with Microsoft PowerPoint, run `scripts/generate_deck.ps1`; this is preferred because it retains masters, layouts, embedded fonts, native charts, native tables, groups, and editable shapes.
4. When chart data must be changed programmatically, generate the selected chart slide first, then load [@Presentations](plugin://presentations@openai-primary-runtime) and edit the retained native chart in that smaller working deck. The COM generator deliberately preserves charts without activating embedded Excel workbooks.
5. If PowerPoint COM is unavailable, use Presentations to import the retained reference, duplicate source slides, and edit objects in place. Stop and explain the limitation if required branding or editability is lost.
6. Run `scripts/validate_deck.py`, render every slide, and visually compare representative output slides with both the approved HTML and retained reference.

## Content and layout rules

- Use a clear narrative rhythm: cover, contents when useful, section dividers, content slides, conclusion. A short deck may omit contents and dividers.
- Use slides 1–14 as the formal report narrative template and slides 15–50 as the reusable component library.
- Follow the mode-specific structure and acceptance checks in `references/content-modes.md`. For a hybrid deck, state which slides belong to each mode in the approved outline.
- For quantitative slides, follow `references/data-storytelling.md`. Never invent values. Missing unit, time period, target, comparison baseline, or source is a blocking data gap that must be asked about before the affected HTML slide is drafted.
- Unless the confirmed outline explicitly selects another retained company layout family, use the cover and chapter-divider family defined in `references/style-system.md`; do not substitute an unrelated dark, neon, gradient, or generic keynote cover.
- `COVER-01` and `DIVIDER-01` are the default fixed HTML components. Do not approximate them from prose, use `assets/preview.png` as a slide background, or hide old template text with opaque panels.
- `COVER-01` keeps the retained half-year-report official industry-scene visual by default. Replace it only when the user explicitly approves a product- or project-specific cover visual during Gate 1.
- Match content shape to the catalog. Use native tables for rows and columns, native charts for quantitative comparisons, and template diagrams for processes or relationships.
- Keep slide titles direct and concise. Reduce copy or split a slide before shrinking type below the template's normal body sizes.
- Plan image slots before replacing images. Preserve image proportions, logo proportions, top-right logo, and footer.
- Add concise speaker notes when the user will present live. Notes add context rather than repeat visible text.

## Editability contract

- Text stays in native text boxes; tables, charts, and diagrams stay native and editable.
- Never use full-slide screenshots, rasterized HTML pages, rasterized SVG pages, or one background image to simulate a slide.
- Keep photos and logos as image objects. Never distort logos.
- Duplicate and edit template slides instead of rebuilding company chrome from scratch.
- Preserve the 16:9 canvas, theme, masters, layouts, grouping, and z-order unless the user explicitly asks for a structural change.

## Quality gate

- Both approval gates are documented in the conversation.
- No unresolved blocking gaps or unapproved assumptions remain.
- No template placeholder language remains, including `点击输入`, `您的内容`, `输入内容`, `添加标题`, `副标题`, or `内容范围`.
- Every slide has a clear purpose, readable hierarchy, and no unintended overlap, clipping, or footer collision.
- All requested numbers, units, chart categories, table rows, images, and citations are present and correct.
- The final `.pptx` reopens successfully and representative text boxes, tables, charts, and shapes remain editable.
