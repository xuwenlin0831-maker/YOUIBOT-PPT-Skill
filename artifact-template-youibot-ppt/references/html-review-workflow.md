# HTML review workflow and Gate 2

## Purpose

The HTML deck is an interactive review artifact. It lets the user inspect the narrative and visuals, comment page by page, and iterate quickly before committing to an editable PPTX.

## Required structure

- Single self-contained HTML file with inline CSS and JavaScript.
- Copy the `COVER-01` and `DIVIDER-01` structure and CSS from `assets/standard-slide-components.html` for the default cover and numbered chapter dividers. Replace its tokens; do not redraw or loosely imitate the component.
- Resolve the component's background, logo, slogan, and subject-visual tokens to separate clean assets. Never resolve any token to `assets/preview.png` or another rendered full-slide image.
- Fixed 1920×1080 `.deck-stage`; scale the whole stage uniformly to the available review area.
- Each slide is a `<section class="slide">` with a unique stable `data-slide-id` and a concise `data-slide-title`.
- Only the active slide is interactive. Use `visibility`, `opacity`, and `pointer-events`; do not switch slides with `display: none`.
- Review UI stays outside `.deck-stage` and must not print.
- Company font and color system follows `style-system.md`; do not run unrelated style discovery.

## Required review controls

Use `assets/html-review-template.html` as the shell or copy its review implementation intact. It provides:

- Current slide number, stable ID, and title
- Status: `待审阅`, `需修改`, `已确认`
- Per-slide comment textarea
- Autosave on input/change to `localStorage`
- Previous/next navigation and keyboard navigation
- Export all review records as UTF-8 JSON
- Copy all non-empty comments as plain text
- Clear-current-page action with confirmation

The storage key must include a deck-specific ID so two decks do not overwrite each other's comments.

## Review JSON contract

```json
{
  "schemaVersion": 1,
  "deckId": "project-specific-id",
  "deckTitle": "Presentation title",
  "exportedAt": "ISO-8601 timestamp",
  "slides": [
    {
      "slideId": "S01",
      "slideNumber": 1,
      "title": "Title",
      "status": "needs_changes",
      "comment": "Replace the metric with the August approved value."
    }
  ]
}
```

Treat `needs_changes` as unresolved. `approved` is page-level confirmation only; final deck authorization still requires an explicit conversational Gate 2 approval.

## Revision loop

1. Read every exported/pasted comment.
2. Map it by stable slide ID, not only slide number.
3. Revise the HTML, data, imagery, and outline as needed.
4. Preserve earlier slide IDs and the deck-specific storage ID across revisions so browser comments survive version updates. Assign new slide IDs only to genuinely new slides.
5. Save each revision as a new numbered review artifact when the user is comparing versions; keep the previous review file unless the user asks to replace it.
6. Re-render the complete deck after every revision. Require zero browser console errors and zero unintended slide-boundary or container-overflow findings. Also inspect every changed slide at a phone viewport while preserving the fixed 16:9 stage.
7. Visually inspect all changed slides plus adjacent slides affected by sequence changes; automated overflow checks do not replace screenshot review.
8. For a new deck or any revision that changes a cover or divider, compare `COVER-01` and every `DIVIDER-01` instance with the canonical component at full size and a phone viewport. Treat changed logo placement, copy-zone geometry, ribbon geometry, slogan placement, or typography scale as a defect unless Gate 1 approved a different retained family.
9. Deliver the updated HTML and summarize resolved comments and any remaining decisions.

## Gate 2 rule

Do not generate PPTX until the user explicitly confirms that the HTML is final and authorizes PPT generation. Partial slide approvals and a review JSON containing all `approved` statuses do not replace conversational approval.

## PPT translation rule

The approved HTML is a layout/content specification. Recreate it with retained company-template slides and native PowerPoint objects. Never screenshot, print, or rasterize the HTML into the final deck.
