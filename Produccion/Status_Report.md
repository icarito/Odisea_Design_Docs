# Status Report — Odisea: El Arca Silenciosa
**Fecha:** Junio 2026
**Última actualización:** 2026-09-01 (Reconciliado con el canon del domo criogénico)

## 1. Sistemas Completados
El proyecto ha avanzado significativamente, estableciendo las bases técnicas y de contenido para el Vertical Slice:

- **Core V2:** Sistema determinista con soporte de replay funcional (`SessionManager`, `OysScript`, batería de tests completa).
- **Movimiento 3ra Persona:** Refinado con momentum, inercia y game feel mecánico.
- **Controladores Funcionales:** Tres esquemas validados: 3ra persona (Elias), 4WD (vehículo terrestre), 0G (ZeroGravityController).
- **Scaffold WFC:** Generación procedural de andamios con 9 módulos y alineación automática de altura.
- **Bridge de Telemetría:** Sistema centralizado para heartbeats, ghosts y sesiones históricas con persistencia en SQLite.
- **Dashboard Web:** Herramienta de tracking en vivo, visualización de heatmaps 3D y playback de sesiones con Viewport3D.
- **Props (Batch 1):** Completados e integrados: `LeverV2`, `BrokenFloorPanel`, `WarningBarrier`, `DataSlate`, `SteelPlate/Stack`, `PipeValve`, `Manometer`, tuberías, `FireEmitter`, `RetractableBridge`.
- **Domo Criogénico:** Canon actualizado a domo criogénico con 4 redes de sistemas (coolant, plasma, aire y energía), reactor central, blast door y hangar de mantenimiento (escena separada que conduce a la esclusa exterior). *Nota: El diseño previo de "3 niveles + esclusa" queda superseded/legacy.*
- **PRC-07:** Protocolo de Reactivación Post-Criogénica totalmente documentado *(SUPERSEDED - ver `Anexos/Anexo_PRC07_Protocolo_Reactivacion.md`)*.
- **Personaje Elías:** Modelo base listo e integrado en el pipeline.
- **Multiplataforma:** Pipeline de exportación funcional para HTML5, Linux, Windows y macOS.

## 2. Pendiente para el Vertical Slice (VS)
Tareas críticas en desarrollo para completar la demo técnica del MVP:

- **Puzzle de reparación:** Mecánica interactiva de mantenimiento en las máquinas del domo (válvulas, bomba, purga, fusible, parche) y puzzles físicos del hangar.
- **IA Odisea:** Integración de diálogos y sistema de guía narrativa.
- **Level Design:** Refinamiento de la estructura del domo criogénico (blast door, descenso al hangar de mantenimiento y esclusa exterior).

### Elementos fuera del MVP (Backlog)
- **Sigilo con DD:** Implementación de comportamiento de patrulla y detección del drone enemigo (postergado, FUERA del MVP).
- **Cargol:** Dron asistente y su sistema de órdenes simples (postergado, FUERA del MVP por ahora).
- **Multi-tool:** Herramienta de mantenimiento versátil (postergada, FUERA del MVP).

## 3. Riesgos Actuales
- Complejidad en la navegación de la IA en entornos generados proceduralmente (WFC).
- Balanceo de los puzzles de reparación de máquinas en el domo.
- Sincronización de audio para la IA Odisea en la versión HTML5.

## 4. Próximo Hito
**Integración de Sistemas de IA y Puzzles del Domo (Julio 2026):** Primera prueba de juego completa en el Domo Criogénico con interacción de máquinas y guía de la IA.
