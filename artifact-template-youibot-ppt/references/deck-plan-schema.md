# Deck plan schema

`scripts/generate_deck.ps1` consumes UTF-8 JSON with this shape:

```json
{
  "slides": [
    {
      "source_slide": 1,
      "replacements": [
        {
          "match": "2026上半年述职报告",
          "text": "项目阶段总结",
          "mode": "exact",
          "occurrence": 1,
          "required": true
        }
      ],
      "pictures": [
        { "index": 1, "path": "D:/absolute/path/hero.png" }
      ],
      "tables": [
        {
          "index": 1,
          "cells": [
            { "row": 1, "column": 1, "text": "项目" }
          ]
        }
      ],
      "notes": "补充背景、数据口径和转场提示。"
    }
  ]
}
```

## Fields

- `source_slide`: required, 1-based source slide number from the catalog.
- `replacements`: existing text to replace. `mode` is `exact` or `contains`; `occurrence` is 1-based among matches; `required` defaults to true.
- `pictures`: replace the Nth picture on that slide in top-to-bottom, left-to-right order. Use absolute paths.
- `tables`: edit the Nth native table. Cell indices are 1-based.
- `notes`: optional speaker notes.

Prefer explicit replacements. Do not use broad matches such as `输入内容` without an occurrence number when that text appears multiple times.

The generator preserves native chart objects but does not activate embedded chart workbooks. If chart data must be changed, generate the working deck first and use the Presentations native-chart workflow on that smaller file.
