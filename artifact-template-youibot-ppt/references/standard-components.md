# Standard cover and divider components

## Status and provenance

These components are the approved default visual contract for YOUIBOT HTML review decks. They were extracted from the accepted real-case HTML v3:

- `COVER-01`: S01, `隙锋四轮机器人系统架构入门`
- `DIVIDER-01-HARDWARE`: S07, `硬件架构`
- `DIVIDER-01-COMMUNICATION`: S14, `通讯架构`
- `DIVIDER-01-SOFTWARE`: S20, `软件架构认知模型`

Use the canonical markup and CSS in `assets/standard-slide-components.html`. Do not reconstruct the components from memory or from `assets/preview.png`.

## Component selection

- Use `COVER-01` for the first slide unless Gate 1 explicitly approves another retained company cover family.
- Use the matching `DIVIDER-01` variant for each numbered chapter.
- Hardware or physical-system chapters use the hardware variant with a verified product, assembly, or component image.
- Communications or data-flow chapters use the communications variant with editable topology geometry.
- Software, process, or layered-system chapters use the software variant with editable layers or flow geometry.
- For another chapter type, keep the `DIVIDER-01` shell and construct the simplest factual right-side visual from editable vector geometry.

## Replaceable fields

### COVER-01

- Stable slide ID and page title metadata
- Main title and optional line break
- Subtitle
- Department or team
- Presenter
- Date
- Version and confidentiality label
- Official right-side industry-scene visual and its alt text (default)
- Optional verified product/project visual and its alt text only when Gate 1 explicitly approves replacement
- Separate clean background, official logo, and official slogan assets

### DIVIDER-01

- Stable slide ID and page title metadata
- Part number
- English chapter label
- Chinese chapter title
- One-line chapter purpose
- Right-side semantic visual and its labels
- Optional factual disclaimer
- Separate clean background, official logo, and official slogan assets

## Locked geometry and styling

Unless Gate 1 explicitly approves another retained company family, do not change:

- Light-gray industrial background family
- Official logo at the upper left
- Slogan at the lower left
- Left-side copy zone and right-side visual zone
- Orange diagonal ribbon position and shape
- Dark-gray title treatment and company-orange emphasis
- Cover title scale and chapter-number scale
- The overall left/right balance and whitespace

Do not add an opaque panel to hide old text. Do not use a full-slide raster preview as a background. All text, ribbon geometry, topology nodes, layer blocks, and labels remain native HTML elements so they can later map to editable PowerPoint objects.

## Asset resolution

The component source contains tokens for the background, logo, slogan, and cover visual. Resolve them to separate clean assets from the retained company template. `{{official_industry_scene_src}}` must resolve to the retained half-year-report right-side industry-scene asset by default. For a self-contained review file, embed each resolved asset as its own data URI only after it has been separated; never embed a rendered full slide.

Only after Gate 1 explicitly approves a product/project cover may `{{official_industry_scene_src}}` be replaced by a verified user-supplied visual. If that approved visual is unavailable, keep the official industry-scene asset and record the fallback; do not invent a render.

## Acceptance checks

- Compare every new cover and divider with the canonical component at 1920×1080.
- Check again at a phone viewport while uniformly scaling the fixed stage.
- Require zero console errors and zero unintended overflow.
- Fail review if logo, slogan, ribbon, copy zone, or typography scale drifts without an approved alternate family.
- Preserve the deck storage ID and stable slide IDs across revisions.
