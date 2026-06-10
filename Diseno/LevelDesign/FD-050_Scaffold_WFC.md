# FD-050 — Pasarelas y Andamios Procedurales (WFC 2D)

**Status:** En desarrollo — WFC funcional, requiere pulido visual  
**Scope:** Acto I — Gap casco-espirales  
**Branch:** `fd-050-scaffold-wfc-17347442582962886612` (PR #95)

---

## Visión general

Generador procedural de redes de pasarelas y andamios usando Wave Function Collapse sobre grilla 2D. Los módulos son instancias de `SteelGratePlatform` con dimensiones, rails y alturas paramétricas.

## Catálogo (9 módulos)

| ID | Tipo | Conexiones |
|----|------|-----------|
| W | Walkway | N-S o E-O |
| R | Railing | N-S o E-O con barandas |
| P | Platform | 4 direcciones |
| S | Stairs | N-S o E-O, +2m en un extremo |
| C | Curve | Esquina 90° |
| G | Gap | N-S o E-O, abertura central 3m |
| X | Cross | 4 direcciones |
| T | T-Junction | 3 direcciones |
| E | End | Terminal 1 dirección |

## Estado actual

**✅ Funciona:**
- WFC con constraint propagation + height domains
- 200 retries, ~48 celdas (8×6 grid)
- EMPTY fallback para celdas irresolubles
- 9 tipos de módulo con variantes rotadas
- Pesos tweakeables desde inspector
- Alturas forzadas: row 0 = 0m, última row = 4m
- Se generan stairs (4-5 por grid)

**⚠️ Problemas conocidos:**
1. **Stairs invisibles:** `front_height_offset` vs `back_height_offset` no alterna según rotación. El código actual siempre usa `front_height_offset`. Debe usar `back` para rot 0/90 y `front` para rot 180/270.
2. **Rampas/C esquinas planas:** Las curvas (C) no usan height_offset — son planas aunque conecten a stairs.
3. **Soportes a distinta altura:** Cada plataforma genera sus patas de soporte independientemente. Las de altura 0 tocan el suelo, las de altura 2m y 4m quedan flotando. Idealmente todos los soportes deberían partir de y=0.
4. **Islas EMPTY:** ~11-13 celdas vacías por grid. Bajar `weight_empty` de 0.3 a 0.1 ayuda pero no elimina el problema.
5. **Rails en T:** Las T-junctions no abren rails en las direcciones de conexión — todas las paredes están cerradas.

## Archivos

| Archivo | Rol |
|---------|-----|
| `core_v2/systems/ScaffoldWFCGenerator.gd` | WFC solver + instanciación (433 líneas) |
| `core_v2/props/scaffold/ScaffoldWalkway.tscn` | Módulo W |
| `core_v2/props/scaffold/ScaffoldRailing.tscn` | Módulo R |
| `core_v2/props/scaffold/ScaffoldPlatform.tscn` | Módulo P |
| `core_v2/props/scaffold/ScaffoldStairs.tscn` | Módulo S |
| `core_v2/props/scaffold/ScaffoldCurve.tscn` | Módulo C |
| `core_v2/props/scaffold/ScaffoldGap.tscn` | Módulo G |
| `core_v2/props/scaffold/ScaffoldCross.tscn` | Módulo X |
| `core_v2/props/scaffold/ScaffoldTJunction.tscn` | Módulo T |
| `core_v2/props/scaffold/ScaffoldEnd.tscn` | Módulo E |
| `core_v2/tests/test_scaffold_wfc.tscn` | Escena de test |
| `core_v2/tests/test_scaffold_wfc.oys` | Script OYS |

## Parámetros exportados (inspector)

- `grid_width` (4-32), `grid_depth` (2-12), `cell_size` (4-30)
- `weight_W` a `weight_E` + `weight_empty`
- `map_seed`, `debug_verbose`, `trigger_generate`

## Notas Godot 3

- `SteelGratePlatform.gd` acepta `platform_width`, `platform_depth`, `rail_front/back/left/right`, `front_height_offset`, `back_height_offset`, `rail_front/back_opening_width`
- Los módulos son escenas con script `SteelGratePlatform.gd`
- `_rebuild()` regenera la malla después de cambiar parámetros
