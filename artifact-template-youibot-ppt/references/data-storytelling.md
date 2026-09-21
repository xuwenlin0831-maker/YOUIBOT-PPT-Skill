# Data storytelling and chart selection

## Data readiness gate

Before drafting a quantitative HTML slide, obtain or confirm for every metric:

- Metric name and definition
- Unit
- Time period and granularity
- Target or threshold
- Comparison baseline
- Source and freshness date

If unit, period, target, comparison baseline, or source is missing, ask the user. Do not infer or invent it. If the user has no real data, convert the slide into a clearly labeled method page, empty data template, or future-case placeholder.

## One-slide data story

Build each data slide in this order:

1. Conclusion title: state what the data means, not merely the metric name.
2. Primary evidence: one dominant editable chart or table.
3. Reference context: target, baseline, period, unit, and source near the evidence.
4. Explanation: no more than three evidence-backed drivers or observations.
5. Action: owner, timing, or decision when relevant.

## Chart selection

| Question | Preferred editable form | Avoid |
|---|---|---|
| How does a metric change over time? | Line chart; column chart for few periods | Pie chart |
| Which category is larger? | Sorted horizontal bar or clustered column | Unsorted decorative shapes |
| Actual versus target | Bullet/progress bar or paired column | Gauge without a meaningful scale |
| Composition at one point | Donut only for few parts; otherwise stacked bar | Many-slice pie |
| Composition over time | Stacked column/area with stable categories | Separate pies by period |
| Relationship between two measures | Scatter plot | Dual-axis chart unless explicitly justified |
| Process, ownership, or sequence | Editable flow, swimlane, or roadmap | Numeric chart |
| Exact multi-field lookup | Native table with visual emphasis | Screenshot of Excel |

Use the closest retained company layout from the template catalog. Slides 41–46 provide native chart families; slides 35–40 provide table, process, and roadmap families. Keep the underlying chart data editable in the final PPTX.

## Visual rules

- Use company orange for the focus series or gap; keep context series gray.
- Label values directly when it reduces legend lookup.
- Start bar/column axes at zero unless a non-zero scale is analytically necessary and clearly disclosed.
- Do not use 3D charts, pictorial scaling, invented precision, or decorative gauges.
- Put units and periods on the slide, not only in speaker notes.
- Cite the source and data date in readable small text.

## Verification

- Recalculate totals and percentages.
- Confirm category ordering and time ordering.
- Confirm chart labels match source units and periods.
- Confirm the chart, table, and labels remain native/editable in PPTX.
- Render at 1920×1080 and check that the conclusion remains legible from a classroom or meeting-room distance.
