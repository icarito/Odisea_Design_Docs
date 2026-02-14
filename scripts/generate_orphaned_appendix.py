import os
import re

def main():
    # Configuration
    wiki_base = "Odisea"
    assets_dir = os.path.join(wiki_base, "_ASSETS")
    output_file = os.path.join(wiki_base, "Apéndice_Imagenes_Huérfanas.md")
    
    # 1. Get all images in _ASSETS
    all_images = set()
    if os.path.exists(assets_dir):
        for f in os.listdir(assets_dir):
            if f.lower().endswith(('.png', '.jpg', '.jpeg', '.gif', '.webp')):
                all_images.add(f)
    else:
        print(f"Warning: Assets directory '{assets_dir}' not found.")
        return

    # 2. Find all used images in .md files
    used_images = set()
    # Simple regex for ![[image.png]] format
    # We'll also catch simple standard markdown images ![alt](path) if they point to _ASSETS, but wiki usually uses obsidian style
    obsidian_pattern = re.compile(r'!\[\[(.*?)\]\]')
    
    for root, dirs, files in os.walk(wiki_base):
        for file in files:
            if file.endswith(".md"):
                file_path = os.path.join(root, file)
                
                # Skip the output file itself to avoid self-reference loop if we run it multiple times
                if os.path.abspath(file_path) == os.path.abspath(output_file):
                    continue

                try:
                    with open(file_path, 'r', encoding='utf-8') as f:
                        content = f.read()
                        matches = obsidian_pattern.findall(content)
                        for match in matches:
                            # Match might contain pipe for sizing like ![[image.png|100]]
                            clean_name = match.split('|')[0]
                            used_images.add(clean_name)
                except Exception as e:
                    print(f"Error reading {file_path}: {e}")

    # 3. Determine orphaned images
    orphaned_images = sorted(list(all_images - used_images))
    
    print(f"Total images found: {len(all_images)}")
    print(f"Used images found: {len(used_images)}")
    print(f"Orphaned images found: {len(orphaned_images)}")

    # 4. Generate the Appendix
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write("# Apéndice: Galería de Imágenes Huérfanas\n\n")
        f.write("Este apéndice se genera automáticamente y contiene imágenes presentes en el repositorio `_ASSETS` que no han sido utilizadas en la documentación.\n\n")
        
        if not orphaned_images:
            f.write("¡No hay imágenes huérfanas! Todo el contenido visual está en uso.\n")
        else:
            # Group by simple heuristics if possible, or just list them
            # For now, just a flat list but with sections based on prefixes if common ones exist
            
            # Simple header
            f.write(f"## Imágenes no referenciadas ({len(orphaned_images)})\n\n")
            
            for img in orphaned_images:
                f.write(f"![[_ASSETS/{img}]]\n")
                f.write(f"*_ASSETS/{img}*\n\n")

    print(f"Successfully generated '{output_file}'")

if __name__ == "__main__":
    # Ensure we run from the wiki root (parent of 'Odisea')
    # Use script location to find wiki root
    script_dir = os.path.dirname(os.path.abspath(__file__))
    wiki_root = os.path.dirname(script_dir)
    os.chdir(wiki_root)
    
    main()
