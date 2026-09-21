# Requirements intake and Gate 1

## Goal

Do not start slide production from an incomplete mental model. Gather the best available source package, expose gaps, and obtain explicit approval for the brief and page-level outline.

## Recommended invocation

The user does not need to complete every field. Accept free-form requests and incomplete input; the minimum useful input is a topic plus a source path or source package. Use the following only as a convenient prompt template:

```text
使用最新版 $artifact-template-youibot-ppt。

PPT主题：
使用目的：
主要受众：
使用场景：
预计时长或页数：
资料路径：
必须包含的内容：
已知的特殊要求：

请先检查资料并补问缺失信息。先确认需求和页级大纲，不要直接生成HTML或PPTX。
```

Blank fields are allowed. Never return the form merely because it is incomplete. Inspect the supplied sources first, infer only non-business context that is safe to infer, and ask one consolidated round of questions for material gaps.

## Intake checklist

Ask the user for the following in one consolidated message whenever it is not already known:

- Content mode: `培训/SOP型`, `汇报/数据型`, or hybrid
- Purpose and desired decision/action after the presentation
- Audience, their current knowledge, and seniority
- Use setting: live presentation, meeting discussion, async reading, printed handout, or mixed
- Presentation duration and target slide count/range
- Density: speaker-led/low-density or reading-first/high-density
- Deadline and review milestones
- Exact deck title, subtitle, presenter, department, and date
- Required chapters, mandatory messages, and content that must not appear
- Source-of-truth priority when supplied files disagree
- Latest approved data, units, time periods, definitions, and citations
- Images, screenshots, product renders, customer logos, and permissions
- Confidentiality level and whether sensitive information must be anonymized
- Output language, bilingual requirements, and speaker-note needs

For `汇报/数据型` or any slide containing numbers, verify five fields for every metric before drafting the affected HTML slide: unit, time period, target value, comparison baseline, and source. Missing any of these is a blocking gap unless the slide is explicitly approved as a non-numeric method/example page. Never invent a value to complete a chart.

For the cover, default to the retained half-year-report official industry-scene visual. Ask about replacement only when the user requests a product/project-specific cover; record that approval in the brief.

## Source audit

For each supplied file, state:

1. What it contains.
2. Which proposed slides it can support.
3. Whether it is current and authoritative.
4. Any contradictions, missing units, missing dates, or ambiguous labels.

Never silently select between conflicting figures. Ask the user which source wins.

## Blocking versus optional gaps

Blocking gaps prevent a truthful or useful draft, for example: missing objective, unknown audience, contradictory KPI values, absent product/version identity, or no approval for confidential material.

Optional enhancements improve quality but need not block the outline, for example: a higher-resolution image, a customer quote, or a preferred illustration. Record these as optional and state the fallback.

## Confirmed brief format

Present a compact brief before the outline:

- Goal
- Audience and setting
- Core message
- Desired action/decision
- Duration, density, and slide-count target
- Required sections
- Source hierarchy
- Visual/data constraints
- Content mode and cover-visual decision
- Approved assumptions and open items

## Page-level outline format

Use one row per slide:

| ID | Page title | Communication purpose | Key content | Evidence/source | Company layout | Missing/assumption |
|---|---|---|---|---|---|---|
| S01 | ... | ... | ... | filename/page or user statement | source slide/layout family | none or explicit item |

IDs are stable (`S01`, `S02`, ...). If the user reorders slides, retain each existing ID and only change its sequence position. New slides receive new IDs.

## Approval rule

End with a direct request to approve or amend the brief and page-level outline. Do not create HTML until the user explicitly approves them. Even a complete source package does not waive this gate.
