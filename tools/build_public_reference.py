#!/usr/bin/env python3
"""Build a smaller distribution copy of the YOUIBOT reference deck.

The source file is never modified. HarmonyOS embedded fonts are retained; other
embedded font payloads and their relationships are removed from the output copy.
"""

from __future__ import annotations

import argparse
import shutil
import tempfile
import zipfile
from pathlib import Path
from xml.etree import ElementTree as ET

P_NS = "http://schemas.openxmlformats.org/presentationml/2006/main"
R_NS = "http://schemas.openxmlformats.org/officeDocument/2006/relationships"
PKG_REL_NS = "http://schemas.openxmlformats.org/package/2006/relationships"
CT_NS = "http://schemas.openxmlformats.org/package/2006/content-types"
RID = f"{{{R_NS}}}id"

ET.register_namespace("p", P_NS)
ET.register_namespace("a", "http://schemas.openxmlformats.org/drawingml/2006/main")
ET.register_namespace("r", R_NS)
ET.register_namespace("", PKG_REL_NS)


def build(source: Path, output: Path) -> tuple[list[str], list[str]]:
    if source.resolve() == output.resolve():
        raise ValueError("Output must be a different file; the source is immutable.")

    with zipfile.ZipFile(source, "r") as zin:
        presentation = ET.fromstring(zin.read("ppt/presentation.xml"))
        relationships = ET.fromstring(zin.read("ppt/_rels/presentation.xml.rels"))
        content_types = ET.fromstring(zin.read("[Content_Types].xml"))

        embedded_list = presentation.find(f"{{{P_NS}}}embeddedFontLst")
        if embedded_list is None:
            raise RuntimeError("No embedded font list found in source deck.")

        removed_rids: set[str] = set()
        removed_typefaces: list[str] = []
        for embedded in list(embedded_list):
            font = embedded.find(f"{{{P_NS}}}font")
            typeface = (font.attrib.get("typeface", "") if font is not None else "")
            if typeface.startswith("HarmonyOS Sans SC"):
                continue
            removed_typefaces.append(typeface)
            for child in embedded:
                rid = child.attrib.get(RID)
                if rid:
                    removed_rids.add(rid)
            embedded_list.remove(embedded)

        removed_targets: set[str] = set()
        for rel in list(relationships):
            if rel.attrib.get("Id") in removed_rids:
                target = rel.attrib.get("Target", "")
                removed_targets.add("ppt/" + target.lstrip("/"))
                relationships.remove(rel)

        for override in list(content_types):
            part_name = override.attrib.get("PartName", "").lstrip("/")
            if part_name in removed_targets:
                content_types.remove(override)

        replacements = {
            "ppt/presentation.xml": ET.tostring(
                presentation, encoding="utf-8", xml_declaration=True
            ),
            "ppt/_rels/presentation.xml.rels": ET.tostring(
                relationships, encoding="utf-8", xml_declaration=True
            ),
            "[Content_Types].xml": ET.tostring(
                content_types, encoding="utf-8", xml_declaration=True
            ),
        }

        output.parent.mkdir(parents=True, exist_ok=True)
        with tempfile.NamedTemporaryFile(
            prefix="youibot-reference-", suffix=".pptx", delete=False
        ) as temp:
            temp_path = Path(temp.name)

        try:
            with zipfile.ZipFile(
                temp_path, "w", compression=zipfile.ZIP_DEFLATED, compresslevel=6
            ) as zout:
                for item in zin.infolist():
                    if item.filename in removed_targets:
                        continue
                    payload = replacements.get(item.filename, zin.read(item.filename))
                    zout.writestr(item, payload)
            with zipfile.ZipFile(temp_path, "r") as check:
                bad = check.testzip()
                if bad:
                    raise RuntimeError(f"Corrupt ZIP member after build: {bad}")
                names = set(check.namelist())
                leftovers = sorted(removed_targets & names)
                if leftovers:
                    raise RuntimeError(f"Removed font payloads still present: {leftovers}")
            shutil.move(str(temp_path), str(output))
        finally:
            temp_path.unlink(missing_ok=True)

    return sorted(set(removed_typefaces)), sorted(removed_targets)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("source", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    removed_fonts, removed_files = build(args.source, args.output)
    print(f"output={args.output}")
    print(f"removed_typefaces={removed_fonts}")
    print(f"removed_font_files={len(removed_files)}")
    print(f"output_bytes={args.output.stat().st_size}")


if __name__ == "__main__":
    main()

