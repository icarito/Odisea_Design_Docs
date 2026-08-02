"""Genera _quarto.yml y el mapa de wikilinks a partir del árbol real de la wiki.

Estructura canónica (plana, sin duplicados):

    index.qmd
    GDD_v3.md, Master_Index.md
    Canon/  Diseno/{Narrativa,Mecanicas,Arte,LevelDesign}/  Arquitectura/  Produccion/  Anexos/
    Politica_Privacidad.md   (apéndice: documento legal público)

Los directorios de archivo histórico (Archive/, Archivo/) quedan fuera de la
navegación a propósito: son material congelado, no documentación viva.
"""
import os
import yaml

# Directorios que nunca forman parte del libro.
EXCLUIR_DIRS = {
    ".git", ".github", ".obsidian", ".quarto", "outputs", "_book", "_fit",
    "site_libs", "templates", "scripts", "quarto", "_ASSETS",
    "Archive", "Archivo", "Odisea",
}

# Apéndices. Politica_Privacidad es el documento legal público cuya URL exigen
# la App Store y Google Play; el de imágenes lo genera generate_orphaned_appendix.py.
APENDICES = ["Politica_Privacidad.md", "Apendice_Imagenes_Huerfanas.md"]

# Orden narrativo explícito. Lo que no esté aquí va después, alfabético.
# Evita que "Acto_III" caiga antes que "Acto_II" por orden alfabético.
ORDEN_NARRATIVA = [
    "Acto_0_Cold_Open", "Acto_I_La_Negacion",
    "Nivel 1", "Nivel 2", "Nivel 3",
    "Acto_II_El_Laberinto", "Acto_III_El_Desafio", "Acto_IV_La_Decision",
    "Narrativa_Finales", "Cuentos",
    "Personaje_Elias", "Personaje_IA_Odisea", "Personaje_PP_fantasma",
    "Entidad_Cargol", "GIZMO", "Multi-Tool", "Manifiesto de carga",
]


def listar(directorio, orden=None):
    """.md de un directorio (no recursivo), con index.md primero."""
    if not os.path.isdir(directorio):
        return []
    archivos = [
        os.path.join(directorio, f)
        for f in os.listdir(directorio)
        if f.endswith(".md") and os.path.isfile(os.path.join(directorio, f))
    ]

    def clave(ruta):
        base = os.path.splitext(os.path.basename(ruta))[0]
        if base == "index":
            return (0, 0, "")
        if orden and base in orden:
            return (1, orden.index(base), "")
        return (2, 0, base.lower())

    return sorted(archivos, key=clave)


def todos_los_md():
    """Todo .md/.qmd navegable del repo, para el mapa de wikilinks."""
    encontrados = []
    for raiz, dirs, files in os.walk("."):
        dirs[:] = [d for d in dirs if d not in EXCLUIR_DIRS and not d.startswith(".")]
        for f in files:
            if f.endswith((".md", ".qmd")):
                encontrados.append(os.path.relpath(os.path.join(raiz, f), "."))
    return sorted(encontrados)


def generar_vault_map():
    """basename -> ruta .html relativa a la raíz del sitio.

    El filtro Lua convierte esto en una ruta relativa al documento actual, para
    que el sitio funcione bajo un subdirectorio (github.io/Odisea_Design_Docs/).
    """
    mapa = {}
    colisiones = {}
    for ruta in todos_los_md():
        base = os.path.splitext(os.path.basename(ruta))[0]
        destino = os.path.splitext(ruta)[0] + ".html"
        if base in mapa:
            colisiones.setdefault(base, [mapa[base]]).append(destino)
            continue
        mapa[base] = destino

    lineas = [
        "-- GENERADO por scripts/generate_quarto_config.py — no editar a mano.",
        "-- basename de wikilink -> ruta .html relativa a la raíz del sitio.",
        "return {",
    ]
    for base in sorted(mapa):
        lineas.append('  ["%s"] = "%s",' % (base, mapa[base].replace("\\", "/")))
    lineas.append("}")

    with open("quarto/filters/vault_map.lua", "w", encoding="utf-8") as f:
        f.write("\n".join(lineas) + "\n")

    if colisiones:
        print("AVISO: nombres duplicados, el wikilink resuelve al primero:")
        for base, rutas in sorted(colisiones.items()):
            print(f"  [[{base}]] -> {rutas[0]}  (ignorado: {', '.join(rutas[1:])})")
    print(f"vault_map.lua: {len(mapa)} entradas")


def main():
    partes = [
        ("Canon (Especificaciones)", listar("Canon")),
        ("Diseño", (
            listar("Diseno")
            + listar("Diseno/Narrativa", ORDEN_NARRATIVA)
            + listar("Diseno/Mecanicas")
            + listar("Diseno/Arte")
            + listar("Diseno/LevelDesign")
        )),
        ("Arquitectura", listar("Arquitectura")),
        ("Producción", (
            listar("Produccion")
            + listar("Produccion/Backlog")
            + listar("Produccion/Backlog/PRODUCTION")
            + listar("Produccion/Pipeline")
            + listar("Produccion/Pipeline/TRAILER")
            + listar("Produccion/Pipeline/_FEATURES PIPELINE")
        )),
        ("Anexos", listar("Anexos")),
    ]

    capitulos = ["index.qmd"]
    for f in ("Master_Index.md", "GDD_v3.md"):
        if os.path.exists(f):
            capitulos.append(f)
    for titulo, archivos in partes:
        if archivos:
            capitulos.append({"part": titulo, "chapters": archivos})

    config = {
        "project": {
            "type": "book",
            "output-dir": "outputs",
            "resources": ["_ASSETS/*"],
        },
        "book": {
            "title": "Odisea: El Arca Silenciosa",
            "author": "Equipo Odisea",
            "date": "last-modified",
            "chapters": capitulos,
            "appendices": [a for a in APENDICES if os.path.exists(a)],
        },
        "lang": "es",
        "format": {
            "html": {
                "theme": "cosmo",
                "css": "style.css",
                "toc": True,
                "number-sections": True,
            },
            "pdf": {
                "output-file": "Odisea.pdf",
                "toc": True,
                "number-sections": True,
                "colorlinks": True,
                "documentclass": "scrbook",
                "papersize": "a4",
                "geometry": ["top=25mm", "left=25mm", "right=25mm", "bottom=25mm"],
            },
        },
        "filters": [
            "quarto/filters/obsidian-callouts.lua",
            "quarto/filters/obsidian-wikilinks-images.lua",
        ],
    }

    with open("_quarto.yml", "w", encoding="utf-8") as f:
        yaml.dump(config, f, sort_keys=False, allow_unicode=True)

    total = sum(len(a) for _, a in partes)
    print(f"_quarto.yml: {total} capítulos + {len(config['book']['appendices'])} apéndice(s)")


if __name__ == "__main__":
    os.chdir(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
    generar_vault_map()
    main()
