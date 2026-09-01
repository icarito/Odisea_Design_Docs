# Locación: Domo Criogénico — Acto I

*   **Tema / Estética**: "El Sepulcro Criogénico". Un domo inmenso y oscuro: claustrofobia industrial, tuberías expuestas, la columna del reactor brillando tenue en el centro y miles de cápsulas criogénicas dispuestas en anillos concéntricos.
*   **Mecánica Principal**: [[Mecanicas_Controlador_Elias|Gravedad 1G]] constante. Puzzle de sistemas (4 redes interconectadas) en el domo + puzzles físicos en el hangar.
*   **Departamento**: CriOps (Cryogenic Operations).

## Estructura del vertical slice

El domo criogénico es la **base del vertical slice**. El sótano/hangar es una
**escena separada** que lo continúa: al completar los sistemas del domo, el blast
door se abre y el jugador desciende al hangar vía `change_scene`.

```
Dome_Intro (domo)                        Dome_Intro_Hangar (escena separada)
──────────────────────────               ──────────────────────────────────
1. Anillo superior (criopods)            5. Hangar de mantenimiento
2. Nivel de máquinas (4 redes)              - cajas empujables
3. Reactor central                          - cintas transportadoras
4. Blast door (compuerta de piso)        6. Esclusa → exterior (ScaffoldOrbit)
        └──────────── change_scene ──────┘
```

## Layout vertical del domo

1. **Anillo superior** — Entrada y hábitat. Criopods en el perímetro (anillos radiales).
   El jugador entra aquí y ve el domo entero; el blast door del piso es visible abajo.
2. **Nivel de máquinas** — Las 4 redes se cruzan a la vista: gabinete eléctrico (verde),
   junta de plasma (ámbar), costuras de coolant (cian), extractores de aire (blanco/rojo)
   y manómetros de todas las redes.
3. **Reactor central** — Columna vertebral del domo. El coolant baja de los criopods a la
   chaqueta del reactor; el plasma sale hacia arriba al bus eléctrico.
4. **Blast door (compuerta de piso)** — Requiere las 4 redes HEALTHY. Al abrirse revela el
   pozo de descenso: una **plataforma móvil de carga** (ruta cinemática) y una **rampa de
   servicio** (ruta peatonal).

## Continuación: sótano / hangar (escena separada)

5. **Hangar de mantenimiento** — Grande y abierto, dos niveles (piso + repisas/catwalks).
   Puzzles físicos con cajas empujables (`PushableBoxV2`: tapar respiraderos, activar
   placas, hacer de puente) y cintas transportadoras (`Conveyor`). **Varía por domo**:
   cada domo apunta a su propio hangar, mientras el rig de sistemas del domo es el mismo
   template.
6. **Esclusa al exterior** — Salida del hangar al anillo exterior (`ScaffoldOrbit` /
   `OdiseaExterior`).

## Sistemas del domo (4 redes)

| Red | Portador | Fuente | Color |
|---|---|---|---|
| **Criocoolant** | Tubos | `CoolantTank` | Cian `#00E5FF` |
| **Plasma** | Tubos | Reactor (salida) | Ámbar `#FF8F00` |
| **Aire** | Ductos | `PressurePump` | Blanco/Rojo `#FF5252` |
| **Energía** | Cables | Bus (reactor) | Verde `#00FF88` |

Especificación técnica completa en el repo del juego: `docs/features/FD-289_dome_systems_canon.md`.

## Puzzle principal
1. Entrar al domo oscuro (anillo superior) — el blast door abajo está sellado.
2. Bajar al nivel de máquinas — encontrar las 4 redes en fallo.
3. Restaurar el coolant (válvula → parche → reabrir) → red 1/4.
4. Activar la energía auxiliar (palanca del bus) → red 2/4.
5. Redirigir el plasma (válvulas) → red 3/4.
6. Restaurar el aire (bomba + purga) → red 4/4 → el blast door se abre.
7. Descender al hangar por la **plataforma móvil** (o la **rampa de servicio**) → `change_scene` → puzzles de cajas y cintas.
8. Cruza la esclusa → exterior.

## Lore ambiental
- Último reporte de tripulación: hace 11 meses.
- Red de la nave: sin actividad desde el despertar de Elías.
- OD-02: Odisea miente, dice que es sensor intermitente marcado por precaución.
- Elías no sabe que despertó 11 meses después de lo programado.
- Módulos adyacentes reportan lectura cero, no se ha asignado personal.
- Sabotaje intencional (Elías no lo sabe aún).

## Props clave
- PipeValve, PipeSection, PipeCorner (válvulas y tuberías)
- LeverV2, LightSwitchV2, FusibleV2 (energía)
- PressurePump, PurgeTuner (aire)
- PushableBoxV2, Conveyor (hangar)
- BlastDoorController (compuerta de piso)
- DataSlate (lore fragments)
- SteelPlate/Stack (escenografía)
- FireEmitter (copia de LeakEmitter con daño)

## Odisea IA — Primer contacto
- Fría, dismissiva, "no se requiere supervisión adicional".
- Miente sobre OD-02.
- No revela que Elías despertó tarde.

Parte de [[Acto_I_La_Negacion]].
