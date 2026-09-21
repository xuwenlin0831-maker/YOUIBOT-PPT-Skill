# Editable PowerPoint workflow

## Preferred generation path

On Windows with Microsoft PowerPoint installed, use `scripts/generate_deck.ps1`. It copies the retained source, duplicates selected source slides, edits their existing objects, removes unused source slides, and saves a normal `.pptx`.

This route preserves features that are easy to lose in reconstruction:

- slide masters, layouts, and theme relationships;
- embedded company fonts and repeated brand chrome;
- native PowerPoint tables and charts;
- grouped shapes, freeforms, connectors, image crops, and z-order;
- existing icons, product renders, and notes-page structure.

Example invocation:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/generate_deck.ps1 `
  -Source assets/reference.pptx `
  -Plan path/to/deck-plan.json `
  -Output path/to/output.pptx
```

The output path must differ from the source. The script refuses to overwrite an existing output unless `-Overwrite` is provided.

## Editability rules

- Replace text inside the source text box instead of placing a new box over it.
- Replace pictures while preserving their original bounds. Keep diagrams as native shapes.
- Update native table cells with the generator. Native charts remain editable; when their data must be changed programmatically, edit them afterward with the Presentations workflow in the smaller generated deck. Never substitute a screenshot of a table or chart.
- Keep the source slide's master and layout. Do not flatten a slide into one image.
- Use an image only when the source material itself is an image, such as a product photo, screenshot, render, or logo.

## Validation

Run:

```powershell
python scripts/validate_deck.py path/to/output.pptx --expected-slides N
```

Use a Python runtime with `python-pptx`; the bundled Codex presentation runtime includes it. Treat placeholder warnings as failures unless the visible text is intentionally part of the requested content.

Then render every slide in PowerPoint or with the Presentations tooling. Check the whole deck for flow and inspect every slide individually for overflow, image distortion, missing logo/footer elements, and broken chart labels.

## Fallback

If PowerPoint COM is unavailable, use the Presentations skill to import and duplicate the retained reference. Preserve native objects and verify the imported deck before authoring. The retained reference contains large embedded-font parts, so a failed import is a real compatibility limit; do not silently rebuild the deck in a different visual system.
