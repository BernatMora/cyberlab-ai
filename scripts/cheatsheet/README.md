# Scripts de la xuleta de comandes

Aquesta carpeta conté els scripts que generen i mantenen el PDF de
l'annex [`../../book/appendices/ann-05-xuleta-comandes.md`](../../book/appendices/ann-05-xuleta-comandes.md).

## Ús

```bash
bash scripts/cheatsheet/build-pdf.sh
```

Genera `book/appendices/ann-05-xuleta-comandes.pdf` des del .md.

## Requisits

- Python 3.11+
- `pip install weasyprint markdown`

Si uses el venv Hermes (recomanat):
```bash
uv pip install --python "C:/Users/iadmin/AppData/Local/hermes/hermes-agent/venv/Scripts/python.exe" weasyprint markdown
```

## Per què un PDF?

El PDF serveix per:

- Imprimir i tenir una còpia física de referència ràpida.
- Compartir amb qui no tingui accés al repo.
- Portar a l'hort en una tablet si cal.

El .md al repo és la **font de veritat**; el PDF es regenera sempre
des del .md.