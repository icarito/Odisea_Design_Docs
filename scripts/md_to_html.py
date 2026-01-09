#!/usr/bin/env python3
"""Genera un único documento HTML largo a partir de los .md en `Odisea/`.
Crea una tabla de contenidos simple que enlaza a cada sección (por archivo).

Uso: python3 scripts/md_to_html.py [--output path]
"""

import re
import sys
from pathlib import Path
from datetime import datetime

try:
    import markdown
except Exception:  # pragma: no cover - entorno puede no tener la librería
    markdown = None

ROOT = Path(__file__).parent.parent
MD_DIR = ROOT / "Odisea"
ASSETS_DIR = MD_DIR / "_ASSETS"
OUTPUT_HTML = ROOT / "outputs" / "odisea_long.html"

LINK_RE = re.compile(r"(?<!\!)\[\[([^\]|#]+)(?:#[^\]]*)?\]\]")  # [[Page]]
IMG_RE = re.compile(r"!\[\[([^\]]+)\]\]")  # ![[image.png]]
HEADING_RE = re.compile(r"^#{1,6}\s+(.*)", re.MULTILINE)


def slugify(text):
    s = text.lower()
    s = re.sub(r"[^a-z0-9\s-]", "", s)
    s = re.sub(r"[\s]+", "-", s).strip("-")
    return s or "section"


def read_files():
    files = sorted([p for p in MD_DIR.rglob("*.md") if p.is_file()])
    # Prefer index.md first if present
    files = sorted(files, key=lambda p: (0 if p.name.lower() == "index.md" else 1, str(p)))
    return files


def extract_title(text, fallback):
    m = HEADING_RE.search(text)
    if m:
        return m.group(1).strip()
    return fallback


def replace_internal_links(text, name_to_slug):
    def repl(m):
        target = m.group(1).strip()
        slug = name_to_slug.get(target)
        if slug:
            return f"<a href=\"#{slug}\">{target}</a>"
        # if not found, leave as plain text
        return target
    return LINK_RE.sub(repl, text)


def replace_images(text):
    def repl(m):
        img = m.group(1).strip()
        # If the asset exists in _ASSETS, reference it relatively
        if (ASSETS_DIR / img).exists():
            return f"<img src=\"_ASSETS/{img}\" alt=\"{img}\" />"
        # else, return alt text
        return f"<em>[imagen: {img}]</em>"
    return IMG_RE.sub(repl, text)


def remove_first_heading(text):
    return re.sub(r"^#{1,6}\s+.*\n", "", text, count=1)


def to_html(md_text):
    if markdown is None:
        # Fallback: very simple conversions (headings, bold, italics, links)
        html = md_text
        html = re.sub(r"^###### (.*)$", r"<h6>\1</h6>", html, flags=re.M)
        html = re.sub(r"^##### (.*)$", r"<h5>\1</h5>", html, flags=re.M)
        html = re.sub(r"^#### (.*)$", r"<h4>\1</h4>", html, flags=re.M)
        html = re.sub(r"^### (.*)$", r"<h3>\1</h3>", html, flags=re.M)
        html = re.sub(r"^## (.*)$", r"<h2>\1</h2>", html, flags=re.M)
        html = re.sub(r"^# (.*)$", r"<h1>\1</h1>", html, flags=re.M)
        html = re.sub(r"\*\*(.*?)\*\*", r"<strong>\1</strong>", html)
        html = re.sub(r"\*(.*?)\*", r"<em>\1</em>", html)
        html = re.sub(r"\[(.*?)\]\((.*?)\)", r"<a href=\"\2\">\1</a>", html)
        html = "\n".join(f"<p>{line}</p>" for line in html.splitlines() if line.strip())
        return html
    else:
        return markdown.markdown(md_text, extensions=["extra", "sane_lists"]) 


def build():
    files = read_files()
    if not files:
        print("No se encontraron archivos .md en Odisea/")
        return 1

    # Primer pase: extraer títulos y slugs
    name_to_slug = {}
    titles = {}
    used_slugs = set()

    for f in files:
        text = f.read_text(encoding="utf-8")
        title = extract_title(text, f.stem)
        slug = slugify(title)
        # asegurarse único
        base = slug
        i = 1
        while slug in used_slugs:
            slug = f"{base}-{i}"
            i += 1
        used_slugs.add(slug)
        name_to_slug[f.stem] = slug
        titles[f.stem] = title
        # También mapear por título literal para enlaces que usen nombres amigables
        name_to_slug[title] = slug

    # Construir TOC y contenido
    toc_items = []
    sections = []

    for f in files:
        content = f.read_text(encoding="utf-8")
        title = titles.get(f.stem, f.stem)
        slug = name_to_slug[f.stem]
        toc_items.append((title, slug))

        # Procesar internals
        # 1) reemplazar imágenes
        content = replace_images(content)
        # 2) reemplazar links [[Page]] -> <a href="#slug">Page</a>
        content = replace_internal_links(content, name_to_slug)
        # 3) eliminar primer heading si existe (ya lo mostramos como H1)
        content = remove_first_heading(content)
        # 4) convertir a HTML
        html = to_html(content)
        # envolver en sección
        section_html = f"<section id=\"{slug}\">\n<h1>{title}</h1>\n{html}\n</section>"
        sections.append(section_html)

    # HTML final
    now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    toc_html = "\n".join(f"<li><a href=\"#{s}\">{t}</a></li>" for t, s in toc_items)

    full_html = f"""<!doctype html>
<html lang="es">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1" />
<title>Odisea - Documento único</title>
<style>
body {{ font-family: Inter, system-ui, -apple-system, 'Segoe UI', Roboto, 'Helvetica Neue', Arial; max-width: 900px; margin: 2rem auto; padding: 0 1rem; line-height: 1.6; color: #111; }}
nav.toc {{ background: #f8f9fa; border: 1px solid #e6e6e6; padding: 1rem; margin-bottom: 1.5rem; }}
nav.toc ul {{ margin: 0; padding-left: 1rem; }}
nav.toc li {{ margin: .3rem 0; }}
section {{ margin-bottom: 2.5rem; }}
section h1 {{ border-bottom: 1px solid #eee; padding-bottom: .25rem; }}
img {{ max-width: 100%; height: auto; }}
</style>
</head>
<body>
<header>
<h1>Odisea — Documento único</h1>
<p>Generado: {now}</p>
</header>
<nav class="toc">
<strong>Tabla de contenidos</strong>
<ul>
{toc_html}
</ul>
</nav>
<main>
{ '\n\n'.join(sections) }
</main>
<footer>
<hr>
<p>Documento generado automáticamente. </p>
</footer>
</body>
</html>"""

    OUTPUT_HTML.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT_HTML.write_text(full_html, encoding="utf-8")

    size_kb = OUTPUT_HTML.stat().st_size / 1024
    print(f"HTML largo exportado a {OUTPUT_HTML}")
    print(f"Secciones: {len(sections)}")
    print(f"Tamaño: {size_kb:.2f} KB")
    return 0


if __name__ == "__main__":
    sys.exit(build())
