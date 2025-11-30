import os
import re
import json
from pathlib import Path
import hashlib
from datetime import datetime

# Carpeta raíz del proyecto
ROOT = Path(__file__).parent
MD_DIR = ROOT
ASSETS_DIR = ROOT / "assets"
DATA_DIR = ROOT / "data"
OUTPUT_JSON = DATA_DIR / "odisea_wiki.json"

# Regex para links internos Obsidian [[...]] y para imágenes ![[...]]
LINK_RE = re.compile(r"(?<!\!)\[\[([^\]|#]+)(?:#[^\]]*)?\]\]")  # Solo links, no imágenes
IMG_RE = re.compile(r"!\[\[([^\]]+)\]\]")

# Recorrer todos los .md
def get_markdown_files(directory):
    return [f for f in directory.glob("*.md") if f.is_file()]

def extract_links(text):
    return list(set(LINK_RE.findall(text)))

def extract_images(text):
    return list(set(IMG_RE.findall(text)))

def clean_text(text):
    # Elimina saltos de línea duplicados y espacios innecesarios
    return re.sub(r"\n{3,}", "\n\n", text).strip()

def main():
    wiki = {}
    all_links = set()
    all_images = set()
    all_words = 0
    DATA_DIR.mkdir(exist_ok=True)
    for md_file in get_markdown_files(MD_DIR):
        with open(md_file, encoding="utf-8") as f:
            content = f.read()
        name = md_file.stem
        links = extract_links(content)
        images = extract_images(content)
        all_links.update(links)
        all_images.update(images)
        word_count = len(re.findall(r"\w+", content))  # <-- CORREGIDO
        all_words += word_count
        wiki[name] = {
            "file": md_file.name,
            "content": clean_text(content),
            "links": links,
            "images": images,
            "word_count": word_count
        }
    # Metadatos de versión
    fecha = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    temp_json = json.dumps(wiki, ensure_ascii=False, indent=2)
    hash_version = hashlib.sha256(temp_json.encode('utf-8')).hexdigest()[:12]
    metadata = {
        "version_hash": hash_version,
        "generated_at": fecha
    }
    wiki["_metadata"] = metadata
    # Guardar JSON
    with open(OUTPUT_JSON, "w", encoding="utf-8") as out:
        json.dump(wiki, out, ensure_ascii=False, indent=2)
    # Reporte final
    kb_size = OUTPUT_JSON.stat().st_size / 1024
    page_count = all_words // 500 + 1
    broken_links = [l for l in all_links if l not in wiki]
    asset_files = set(f.name for f in ASSETS_DIR.glob("*") if f.is_file())
    broken_images = [img for img in all_images if img not in asset_files]
    print(f"Wiki exportada a {OUTPUT_JSON}")
    print(f"Total de links internos: {len(all_links)}")
    print(f"Total de palabras: {all_words}")
    print(f"Páginas estimadas (500 palabras c/u): {page_count}")
    print(f"Tamaño JSON final: {kb_size:.2f} KB")
    print(f"Hash de versión: {hash_version}")
    print(f"Fecha de generación: {fecha}")
    if broken_links:
        print("Links locales rotos:")
        for l in broken_links:
            print(f"  - {l}")
    else:
        print("No hay links locales rotos.")
    if broken_images:
        print("Imágenes referenciadas no encontradas en assets:")
        for img in broken_images:
            print(f"  - {img}")
    else:
        print("No hay imágenes rotas (todas están en assets).")
    # Actualizar index.md con hash y fecha
    index_path = ROOT / "index.md"
    if index_path.exists():
        with open(index_path, encoding="utf-8") as f:
            index_content = f.read()
        # Elimina versiones previas
        index_content = re.sub(r"\n\*\*Versión JSON\*\*:.*", "", index_content)
        # Inserta info después de los links
        info = f"\n**Versión JSON**: `{hash_version}`\n**Fecha de generación**: `{fecha}`\n"
        index_content = re.sub(r"(\[Ver odisea_wiki.json[\s\S]*?\))", r"\1" + info, index_content, count=1)
        with open(index_path, "w", encoding="utf-8") as f:
            f.write(index_content)

if __name__ == "__main__":
    main()
