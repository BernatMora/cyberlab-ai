#!/usr/bin/env bash
# ============================================================================
# build-pdf.sh — Construeix el PDF de la xuleta de comandes (ANN-05).
#
# Llegeix book/appendices/ann-05-xuleta-comandes.md i el converteix en
# book/appendices/ann-05-xuleta-comandes.pdf amb un format net imprimible.
#
# Requisits:
#   - Python 3 amb reportlab (pip install reportlab)
#   - markdown (pip install markdown)
#
# S'usa reportlab per compatibilitat amb Windows (weasyprint necessita
# libgobject i altres libs natives que no són fàcils d'instal·lar).
#
# Ús:
#   bash scripts/cheatsheet/build-pdf.sh
#
# Resultat:
#   book/appendices/ann-05-xuleta-comandes.pdf
# ============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
SRC_UNIX="$ROOT/book/appendices/ann-05-xuleta-comandes.md"
OUT_UNIX="$ROOT/book/appendices/ann-05-xuleta-comandes.pdf"
# Convertir a path Windows per a Python
SRC="$(cygpath -w "$SRC_UNIX" 2>/dev/null || echo "$SRC_UNIX")"
OUT="$(cygpath -w "$OUT_UNIX" 2>/dev/null || echo "$OUT_UNIX")"

if [[ ! -f "$SRC" ]]; then
  echo "ERROR: No trobo $SRC" >&2
  exit 1
fi

# Detectar Python del venv Hermes (on tenim reportlab)
HERMES_VENV="C:/Users/iadmin/AppData/Local/hermes/hermes-agent/venv/Scripts/python.exe"
PY="${HERMES_VENV:-python}"

if ! command -v "$PY" >/dev/null 2>&1; then
  PY=python
fi

echo "Font: $SRC"
echo "Destí: $OUT"
echo "Python: $PY"
echo ""

# Generar PDF via reportlab + markdown
"$PY" - "$SRC" "$OUT" <<'PYEOF'
import sys
import os
import re
import markdown
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.units import mm, cm
from reportlab.lib.enums import TA_LEFT
from reportlab.lib.colors import HexColor, black, grey, white
from reportlab.platypus import (
    SimpleDocTemplate, Paragraph, Spacer, Preformatted,
    Table, TableStyle, PageBreak, KeepTogether
)

src, out = sys.argv[1], sys.argv[2]

with open(src, 'r', encoding='utf-8') as f:
    md_text = f.read()

# Treure el frontmatter YAML
md_text = re.sub(r'^---\n.*?\n---\n', '', md_text, count=1, flags=re.DOTALL)

# Parsejar el markdown a HTML
md = markdown.Markdown(extensions=['extra', 'tables', 'fenced_code', 'sane_lists'])
html_body = md.convert(md_text)

# Estils
styles = getSampleStyleSheet()
styles.add(ParagraphStyle(
    name='BookTitle',
    parent=styles['Title'],
    fontSize=18, leading=22,
    textColor=HexColor('#0a3d62'),
    spaceAfter=8*mm
))
styles.add(ParagraphStyle(
    name='H1Book',
    parent=styles['Heading1'],
    fontSize=16, leading=20,
    textColor=HexColor('#0a3d62'),
    spaceBefore=6*mm, spaceAfter=3*mm,
    keepWithNext=True
))
styles.add(ParagraphStyle(
    name='H2Book',
    parent=styles['Heading2'],
    fontSize=13, leading=16,
    textColor=HexColor('#1e6091'),
    spaceBefore=5*mm, spaceAfter=2*mm,
    keepWithNext=True
))
styles.add(ParagraphStyle(
    name='H3Book',
    parent=styles['Heading3'],
    fontSize=11, leading=14,
    textColor=HexColor('#2c3e50'),
    spaceBefore=3*mm, spaceAfter=2*mm,
    keepWithNext=True
))
styles.add(ParagraphStyle(
    name='CodeCheat',
    parent=styles['Code'],
    fontName='Courier',
    fontSize=8, leading=10,
    leftIndent=2*mm,
    rightIndent=2*mm,
    backColor=HexColor('#f8f8f8'),
    borderPadding=4,
    borderColor=HexColor('#0a3d62'),
    borderWidth=0,
    spaceBefore=3*mm, spaceAfter=4*mm
))
styles.add(ParagraphStyle(
    name='BodyBook',
    parent=styles['BodyText'],
    fontSize=10, leading=14,
    spaceAfter=3*mm
))
styles.add(ParagraphStyle(
    name='BodyBookSmall',
    parent=styles['BodyText'],
    fontSize=9, leading=12,
    leftIndent=4*mm,
    spaceAfter=1*mm
))
styles.add(ParagraphStyle(
    name='BlockquoteBook',
    parent=styles['BodyText'],
    fontSize=10, leading=13,
    leftIndent=5*mm,
    textColor=HexColor('#555555'),
    fontName='Helvetica-Oblique'
))


def html_to_flow(html_content):
    """Convertim HTML simple a flowables de reportlab."""
    elements = []
    pos = 0
    while pos < len(html_content):
        # Buscar el següent tag (incloent self-closing com <hr/>)
        m = re.search(r'<(h1|h2|h3|p|pre|ul|ol|table|blockquote|hr)([^>]*)>', html_content[pos:])
        if not m:
            # Text restant
            text = html_content[pos:].strip()
            if text:
                text = re.sub(r'<[^>]+>', '', text).strip()
                if text:
                    elements.append(Paragraph(text, styles['BodyBook']))
            break
        # Text abans del tag
        before = html_content[pos:pos + m.start()].strip()
        if before:
            text = re.sub(r'<[^>]+>', '', before).strip()
            if text:
                elements.append(Paragraph(text, styles['BodyBook']))
        tag = m.group(1)
        rest_start = pos + m.end()
        attrs = m.group(2)
        # Detectar self-closing: acaba en /> o és hr
        is_self_closing = attrs.strip().endswith('/') or tag == 'hr'
        end_pos = rest_start
        if not is_self_closing:
            close_re = re.compile(rf'</{tag}>', re.IGNORECASE)
            close_m = close_re.search(html_content, rest_start)
            if not close_m:
                break
            content = html_content[rest_start:close_m.start()]
            end_pos = close_m.end()
        else:
            content = ''
        if tag in ('h1', 'h2', 'h3') and content:
            text = re.sub(r'<[^>]+>', '', content).strip()
            if text:
                style_name = f'H{tag[1]}Book'
                elements.append(Paragraph(text, styles[style_name]))
        elif tag == 'p' and content:
            text = re.sub(r'<[^>]+>', '', content).strip()
            if text:
                elements.append(Paragraph(text, styles['BodyBook']))
        elif tag == 'pre' and content:
            text = re.sub(r'<[^>]+>', '', content).strip()
            text = text.replace('&lt;', '<').replace('&gt;', '>').replace('&amp;', '&')
            if text:
                elements.append(Preformatted(text, styles['CodeCheat']))
        elif tag in ('ul', 'ol') and content:
            items = re.findall(r'<li[^>]*>(.*?)</li>', content, re.DOTALL)
            for item in items:
                item = re.sub(r'<p[^>]*>', '', item)
                item = re.sub(r'</p>', '', item)
                item_text = re.sub(r'<[^>]+>', '', item).strip()
                item_text = item_text.replace('&lt;', '<').replace('&gt;', '>').replace('&amp;', '&')
                if item_text:
                    bullet = '• ' if tag == 'ul' else '• '
                    elements.append(Paragraph(f'{bullet}{item_text}', styles['BodyBookSmall']))
        elif tag == 'blockquote' and content:
            text = re.sub(r'<[^>]+>', '', content).strip()
            if text:
                elements.append(Paragraph(text, styles['BlockquoteBook']))
        elif tag == 'hr':
            elements.append(Spacer(1, 5*mm))
        elif tag == 'table' and content:
            rows_raw = re.findall(r'<tr[^>]*>(.*?)</tr>', content, re.DOTALL)
            table_data = []
            for row_html in rows_raw:
                cells = re.findall(r'<t[hd][^>]*>(.*?)</t[hd]>', row_html, re.DOTALL)
                row = []
                for cell in cells:
                    cell_text = re.sub(r'<[^>]+>', '', cell).strip()
                    cell_text = cell_text.replace('&lt;', '<').replace('&gt;', '>').replace('&amp;', '&')
                    row.append(Paragraph(cell_text, styles['BodyBook']))
                if row:
                    table_data.append(row)
            if table_data:
                t = Table(table_data, colWidths=None)
                t.setStyle(TableStyle([
                    ('BACKGROUND', (0, 0), (-1, 0), HexColor('#0a3d62')),
                    ('TEXTCOLOR', (0, 0), (-1, 0), white),
                    ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
                    ('FONTSIZE', (0, 0), (-1, -1), 9),
                    ('GRID', (0, 0), (-1, -1), 0.5, HexColor('#dddddd')),
                    ('VALIGN', (0, 0), (-1, -1), 'TOP'),
                    ('LEFTPADDING', (0, 0), (-1, -1), 4),
                    ('RIGHTPADDING', (0, 0), (-1, -1), 4),
                    ('TOPPADDING', (0, 0), (-1, -1), 3),
                    ('BOTTOMPADDING', (0, 0), (-1, -1), 3),
                ]))
                elements.append(t)
                elements.append(Spacer(1, 3*mm))
        pos = end_pos
    return elements


# Construir PDF
doc = SimpleDocTemplate(
    out,
    pagesize=A4,
    leftMargin=18*mm, rightMargin=18*mm,
    topMargin=20*mm, bottomMargin=20*mm,
    title="Xuleta de comandes — Bernat CyberLab",
    author="Bernat Mora + Hermes Agent"
)

flow = []
flow.append(Paragraph("Xuleta de comandes", styles['BookTitle']))
flow.append(Paragraph("Bernat CyberLab — Annex ANN-05", styles['H2Book']))
flow.append(Spacer(1, 4*mm))
flow.extend(html_to_flow(html_body))

# Footer
def on_page(canvas, doc):
    canvas.saveState()
    canvas.setFont('Helvetica', 8)
    canvas.setFillColor(HexColor('#888888'))
    canvas.drawCentredString(
        A4[0] / 2,
        10*mm,
        f"Bernat CyberLab — Xuleta de comandes — pàgina {doc.page} de {{total}}".replace("{total}", "?")
    )
    canvas.restoreState()

try:
    doc.build(flow, onFirstPage=on_page, onLaterPages=on_page)
    print(f"PDF generat: {out}")
    print(f"Mida: {os.path.getsize(out)} bytes ({os.path.getsize(out)/1024:.1f} KB)")
except Exception as e:
    print(f"ERROR: {e}", file=sys.stderr)
    sys.exit(1)
PYEOF

echo ""
echo "Fet."