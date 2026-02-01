# Protocolo de Desarrollo Core_V2: Reglas de Oro

Este documento establece las normativas técnicas obligatorias para el desarrollo en la arquitectura Core_V2 de Odisea. El incumplimiento de estas reglas rompe el determinismo del sistema de replay.

## Las 7 Reglas de Oro del Determinismo

1.  **Simulación Determinista via `step(dt)`**: Todo movimiento y lógica de física (Player, Cajas, Túneles de Viento) debe ejecutarse dentro de un método `step(dt)`. Se prohíbe el uso de `_physics_process` para lógica de simulación core.
2.  **Contrato de Replay (R-S-R-P)**: La arquitectura se basa en el flujo **Record -> Snapshot -> Restore -> Playback**. Cualquier estado que no sea capturado en un snapshot es un estado perdido y causará desincronización.
3.  **Hard Reset Obligatorio**: El sistema debe garantizar que un `Restore` limpie completamente el estado anterior. No deben quedar residuos de fuerzas, velocidades o estados de animación previos.
4.  **No Direct Basis Manipulation**: Se prohíbe la manipulación directa de `transform.basis` o `rotation` para forzar orientaciones. La rotación debe emerger orgánicamente de los inputs y el estado de la simulación.
5.  **Contrato de Cámara Core_V2**: La cámara es una entidad de observación cuyo estado de rotación emerge del input acumulado. El controlador no debe "forzar" el basis de la cámara hacia el jugador.
6.  **Entidades de Simulación Pura**: Las mecánicas (como las *Pushable Boxes*) deben ser tratadas como entidades matemáticas en la simulación, independientes de su representación visual.
7.  **Separación Estricta Core/Vista**: El "Core" (Simulación) no debe conocer la existencia de nodos visuales, efectos de sonido o partículas. Estos deben reaccionar a la simulación, no dirigirla.

## Implementación de Snapshots

Cada entidad que forme parte del estado del mundo debe implementar los métodos:
- `get_snapshot()`: Devuelve un diccionario con el estado mínimo necesario.
- `restore_snapshot(data)`: Restaura el estado a partir del diccionario.

## Zonas 2.5D y QOL Fixes

Las zonas 2.5D deben seguir el estándar de:
- **Lazy Pan**: Suavizado de cámara que no persigue instantáneamente cada micro-movimiento.
- **Liberación de Ángulo**: Permitir un rango de libertad en la rotación antes de forzar el alineamiento con el eje 2.5D.
