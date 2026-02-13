import os
import yaml

def get_files_relative(directory, base="Odisea"):
    files = []
    abs_dir = os.path.join(base, directory)
    if not os.path.exists(abs_dir):
        return []

    for root, dirs, filenames in os.walk(abs_dir):
        for filename in filenames:
            if filename.endswith(".md"):
                filepath = os.path.join(root, filename)
                files.append(filepath)

    files.sort()

    # Prioritize index.md
    target_index = os.path.join(base, directory, "index.md")
    if target_index in files:
        files.remove(target_index)
        files.insert(0, target_index)

    return files

def main():
    canon_files = get_files_relative("Canon")
    diseno_narrativa = get_files_relative("Diseno/Narrativa")
    diseno_mecanicas = get_files_relative("Diseno/Mecanicas")
    diseno_arte = get_files_relative("Diseno/Arte")
    diseno_level = get_files_relative("Diseno/LevelDesign")
    arquitectura_files = get_files_relative("Arquitectura")
    produccion_files = get_files_relative("Produccion")
    archivo_files = get_files_relative("Archivo")

    # Handle Design index separately
    # It might be in Odisea/Diseno/index.md but not picked up by subfolders
    # We explicitly add it.

    design_chapters = []
    design_index = "Odisea/Diseno/index.md"
    if os.path.exists(design_index):
        design_chapters.append(design_index)

    design_chapters.append("Odisea/Diseno/Pilares.md")
    design_chapters.extend(diseno_narrativa)
    design_chapters.extend(diseno_mecanicas)
    design_chapters.extend(diseno_arte)
    design_chapters.extend(diseno_level)

    config = {
        "project": {
            "type": "book",
            "output-dir": "outputs",
            "resources": [
                "Odisea/_ASSETS/*",
                "Odisea/Canon/*",
                "Odisea/Diseno/*",
                "Odisea/Arquitectura/*",
                "Odisea/Produccion/*"
            ]
        },
        "book": {
            "title": "Odisea: El Arca Silenciosa",
            "author": "Equipo Odisea",
            "date": "last-modified",
            "chapters": [
                "Odisea/index.md",
                "Odisea/Master_Index.md",
                {
                    "part": "Canon (Especificaciones)",
                    "chapters": canon_files
                },
                {
                    "part": "Diseño",
                    "chapters": design_chapters
                },
                {
                    "part": "Arquitectura",
                    "chapters": arquitectura_files
                },
                {
                    "part": "Producción",
                    "chapters": produccion_files
                },
                {
                    "part": "Archivo",
                    "chapters": archivo_files
                }
            ]
        },
        "format": {
            "html": {
                "theme": "cosmo",
                "css": "style.css",
                "toc": True,
                "number-sections": True
            },
            "pdf": {
                "output-file": "Odisea.pdf",
                "toc": True,
                "number-sections": True,
                "colorlinks": True,
                "documentclass": "scrbook",
                "papersize": "a4",
                "geometry": ["top=25mm", "left=25mm", "right=25mm", "bottom=25mm"]
            }
        },
        "filters": [
             "quarto/filters/obsidian-callouts.lua",
             "quarto/filters/obsidian-wikilinks-images.lua"
        ]
    }

    with open("_quarto.yml", "w") as f:
        yaml.dump(config, f, sort_keys=False, allow_unicode=True)

if __name__ == "__main__":
    main()
