#!/usr/bin/env python3
"""Validacions lleugeres i sense dependències del repositori."""
from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
errors: list[str] = []

changelog = (ROOT / "CHANGELOG.md").read_text(encoding="utf-8")
headings = re.findall(r"^## \[([^]]+)]", changelog, flags=re.MULTILINE)
for heading in sorted(set(headings)):
    if headings.count(heading) > 1:
        errors.append(f"CHANGELOG.md: versió duplicada: {heading}")

secret_patterns = {
    "private key": re.compile(r"BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY"),
    "GitHub token": re.compile(r"gh[pousr]_[A-Za-z0-9_]{20,}"),
    "API key": re.compile(r"sk-[A-Za-z0-9_-]{20,}"),
    "Tailscale key": re.compile(r"tskey-[A-Za-z0-9_-]{10,}"),
}
text_suffixes = {".md", ".yml", ".yaml", ".json", ".toml", ".sh", ".ps1", ".py"}
for path in ROOT.rglob("*"):
    if not path.is_file() or ".git" in path.parts or path.suffix.lower() not in text_suffixes:
        continue
    text = path.read_text(encoding="utf-8", errors="replace")
    for line_number, line in enumerate(text.splitlines(), start=1):
        placeholder = any(marker in line.lower() for marker in ("xxxxx", "example", "placeholder", "<tail", "<token", "<api"))
        if placeholder:
            continue
        for label, pattern in secret_patterns.items():
            if pattern.search(line):
                errors.append(f"{path.relative_to(ROOT)}:{line_number}: possible {label}")

for path in (ROOT / "book").rglob("*.md"):
    text = path.read_text(encoding="utf-8")
    if text.startswith("---\n") and "\n---\n" not in text[4:]:
        errors.append(f"{path.relative_to(ROOT)}: frontmatter sense tancament")

if errors:
    print("\n".join(f"ERROR: {error}" for error in errors))
    sys.exit(1)
print("Repository validation: OK")
