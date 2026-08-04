#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Genera el SPA del Bernat CyberLab (cyberlab-ai) a partir dels .md amb
contingut real. Sortida: site/index.html (fitxer auto-contingut).

Fes servir el template de la skill static-site-from-markdown. Converteix
els links interns .md en navegació SPA (#doc=slug) perquè es pugui llegir
des del navegador/mòbil sense servidor.
"""
from __future__ import annotations
import json
import re
from datetime import datetime
from pathlib import Path

import markdown  # pip install markdown

# ── Config ───────────────────────────────────────────────────────────
ROOT = Path(__file__).resolve().parent.parent
SITE_DIR = Path(__file__).resolve().parent
# L'SPA es publica des de l'arrel del repo (com les altres webs del BernatMora),
# mantenint site/ només com a font (template + build.py).
OUT_FILE = ROOT / "index.html"

# Fitxers que entren a la web (només contingut real, no esquelets)
DOCS = [
    # (rel_path, emoji, categoria)
    ("book/README.md", "📖", "El llibre"),
    ("book/chapters/cap-00-10-proleg.md", "📖", "El llibre"),
    ("book/chapters/cap-00-20-filosofia.md", "📖", "El llibre"),
    ("book/chapters/cap-00-30-objectius.md", "📖", "El llibre"),
    ("book/chapters/cap-00-40-com-llegir.md", "📖", "El llibre"),
    ("book/chapters/cap-00-50-etica-legalitat-abast.md", "📖", "El llibre"),
    ("book/chapters/cap-01-60-ubicacions-i-desplegaments.md", "🧱", "Fonaments"),
    ("docs/00-pla-director.md", "🎯", "Pla Director"),
    ("architecture/topologia-xarxa.md", "🌐", "Arquitectura"),
    ("architecture/convencions-noms.md", "🏷️", "Arquitectura"),
    ("architecture/diagram-general.md", "🗺️", "Arquitectura"),
    ("book/appendices/ann-05-xuleta-comandes.md", "⚡", "Apèndixs"),
    ("book/appendices/ann-07-historia-del-projecte.md", "📜", "Apèndixs"),
]


def slugify(path: str) -> str:
    s = re.sub(r"[^a-zA-Z0-9._-]+", "-", path).strip("-").lower()
    return s or "doc"


def strip_frontmatter(md_text: str) -> str:
    """Treu el bloc YAML inicial (--- ... ---)."""
    if md_text.startswith("---"):
        m = re.match(r"^---\s*\n.*?\n---\s*\n?", md_text, re.S)
        if m:
            return md_text[m.end():]
    return md_text


def rewrite_internal_links(html: str, abs_dir: Path) -> str:
    """Converteix links interns .md/.html a navegació SPA (#doc=slug).

    abs_dir = directori ABSOLUT del fitxer actual, per resoldre links
    relatius (noms de fitxer nus, ./x, ../y).
    """
    known = {p: slugify(p) for p, _, _ in DOCS}

    def repl(m):
        url = m.group(1)
        text = m.group(2)
        # Enllaços externs o ancorats a mateixa pàgina: es deixen
        if url.startswith(("http", "#", "mailto:")):
            return m.group(0)
        # Si no té extensió .md/.html (ex: carpeta/), es deixa
        if not re.search(r"\.(md|html)(#|$)", url):
            return m.group(0)
        target_path = url.split("#")[0]
        anchor = ""
        if "#" in url:
            anchor = url[url.index("#"):]
        # Resol el target absolutament respecte al directori del fitxer
        resolved = (abs_dir / target_path).resolve()
        try:
            rel = resolved.relative_to(ROOT).as_posix()
        except ValueError:
            return m.group(0)
        if rel in known:
            slug = known[rel]
            return f'<a href="#doc={slug}{anchor}">{text}</a>'
        # No està a la web però és un .md del repo: enllaça a GitHub
        github_url = "https://github.com/BernatMora/cyberlab-ai/blob/main/" + rel
        return f'<a href="{github_url}">{text}</a>'
    return re.sub(r'<a href="([^"]*)">(.*?)</a>', repl, html, flags=re.S)


def extract_title_summary(md_text: str, fallback: str):
    title = fallback
    summary = ""
    for ln in md_text.splitlines():
        ln = ln.strip()
        if ln.startswith("# "):
            title = ln[2:].strip()
            break
    for ln in md_text.splitlines():
        ln = ln.strip()
        if not ln:
            continue
        if ln.startswith(("#", ">", "-", "*", "|", "!")):
            continue
        summary = ln
        break
    return title, summary[:220]


def build():
    docs = []
    for rel, emoji, cat in DOCS:
        p = ROOT / rel
        if not p.exists():
            print(f"  !! MISSING: {rel}")
            continue
        md_text = strip_frontmatter(p.read_text(encoding="utf-8"))
        title, summary = extract_title_summary(md_text, p.stem)
        this_dir = p.parent
        html = markdown.markdown(
            md_text,
            extensions=["tables", "fenced_code", "sane_lists", "nl2br"],
            output_format="html5",
        )
        html = rewrite_internal_links(html, this_dir)
        docs.append({
            "id": slugify(rel),
            "path": rel,
            "title": title,
            "summary": summary,
            "category": cat,
            "html": html,
        })

    # Sidebar agrupada per categoria
    from collections import OrderedDict
    cats = OrderedDict()
    for rel, emoji, cat in DOCS:
        cats.setdefault(cat, {"emoji": emoji, "docs": []})
        slug = slugify(rel)
        d = next(x for x in docs if x["id"] == slug)
        cats[cat]["docs"].append(d)
    sidebar = [{"name": c, "emoji": v["emoji"], "count": len(v["docs"])}
               for c, v in cats.items()]

    total = len(docs)
    generated_at = datetime.now().strftime("%Y-%m-%d %H:%M")

    tpl = (SITE_DIR / "template.html").read_text(encoding="utf-8")
    out = (tpl
           .replace("__DOCS__", json.dumps(docs, ensure_ascii=False))
           .replace("__SIDEBAR__", json.dumps(sidebar, ensure_ascii=False))
           .replace("__TOTAL__", str(total))
           .replace("__NCAT__", str(len(sidebar)))
           .replace("__DATE__", generated_at))
    OUT_FILE.write_text(out, encoding="utf-8")

    print(f"OK {OUT_FILE.name} generat")
    print(f"  Documents:  {total}")
    print(f"  Categories: {len(sidebar)}")
    print(f"  Mida:       {OUT_FILE.stat().st_size/1024:.1f} KB")
    for s in sidebar:
        print(f"    {s['emoji']} {s['name']:<18} {s['count']}")


if __name__ == "__main__":
    build()
