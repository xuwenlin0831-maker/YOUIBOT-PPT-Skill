# YOUIBOT visual system

## Canvas and typography

- Canvas: 13.333 × 7.5 in, 16:9.
- Primary family: HarmonyOS Sans SC.
- Available template weights: Light, regular, Medium, and Black.
- Typical hierarchy in the source: 40–66 pt hero text, 28–32 pt page titles, 14–20 pt body text, and 9–12 pt captions or footer text.
- Keep Chinese copy compact. Shorten or split content before shrinking text.

## Color system

- Company orange: `#EE742A`.
- Primary dark gray: `#4F4D50`.
- Secondary gray: `#686769`.
- Light neutral: `#F2F2F2` and white.
- Use orange as the single emphasis color. Preserve the source's restrained gray and white balance.

## Repeated chrome

- Most content slides use a small orange marker at top left, a section or slide title, the YOUIBOT logo at top right, and the company slogan in the footer.
- The background uses a subtle industrial-robot graphic with light gray diagonal geometry and low-opacity orange accents.
- Section dividers use a large orange numbered block with `PART` and a short section title.
- Cover and closing pages may use stronger product imagery and larger orange geometry.

## Default cover and chapter-divider family

These are required defaults unless the confirmed page-level outline explicitly approves another retained company cover or section-divider family.

The canonical HTML implementation is `assets/standard-slide-components.html`:

- `COVER-01` is derived from the accepted v3 S01.
- `DIVIDER-01-HARDWARE`, `DIVIDER-01-COMMUNICATION`, and `DIVIDER-01-SOFTWARE` are derived from the accepted v3 S07, S14, and S20.
- Preserve their background family, logo and slogan positions, orange-ribbon geometry, left copy zone, type scale, and overall left/right balance. They are fixed components rather than examples to reinterpret.
- Replace only the fields listed in `references/standard-components.md`. A different retained family requires explicit approval in Gate 1.

### Cover

- Base the cover on the first-slide visual family of the retained half-year report template: light gray industrial background, official YOUIBOT logo at upper left, large dark-gray title at left, subtitle and presenter metadata below it, company slogan at lower left, orange diagonal band, and the official industry-scene visual on the right.
- Reuse the retained template's official right-side industry-scene asset by default. It is part of the company cover identity, not disposable example machinery. Replace it only when the user explicitly requests and approves a product- or project-specific cover visual during Gate 1.
- When replacement is approved, use verified user-supplied material and preserve the same visual zone, scale, masking, and left/right balance. Never invent a product rendering or silently substitute stock imagery.
- Keep the title and metadata editable. Do not flatten the cover into a full-slide screenshot.
- Do not default to a dark full-bleed cover, decorative gradient, neon style, or improvised logo treatment.

### Chapter dividers

- All numbered chapter dividers (`PART 01`, `PART 02`, `PART 03`, and later parts) inherit the approved cover's visual family: the same background family, logo placement, slogan treatment, orange diagonal geometry, typography, and left/right composition.
- Place the large orange part number, English section label, Chinese section title, and one-line section purpose on the left. Place one content-specific visual on the right.
- Choose the right-side visual by chapter meaning, not by decoration: hardware uses a verified product, assembly, or component visual; communications uses an editable network/topology diagram; software uses an editable layer, flow, or module abstraction. For other chapters, select the closest factual visual form from the supplied material.
- If a verified image is unavailable, use simple editable vector geometry. Do not invent a product rendering or use a generic stock image.
- The cover and chapter dividers should read as one visual family while remaining distinguishable through part number, title, and chapter-specific visual.

## Layout character

- Favor clean alignment, generous white space, thin orange rules, and simple rectangular geometry.
- Preserve the company's product imagery and technical tone. Do not add gradients, unrelated palettes, rounded UI cards, or decorative visual systems that conflict with the reference.
- Maintain object alignment to the source slide's grid. Reuse the closest existing layout instead of inventing a near-duplicate.
