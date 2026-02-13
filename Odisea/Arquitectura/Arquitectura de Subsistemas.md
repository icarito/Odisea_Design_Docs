# Arquitectura de Subsistemas

## Introducción

La arquitectura de Odisea ha evolucionado hacia **Core_V2**, un sistema modular inspirado en Cogito pero centrado en el **determinismo y el sistema de replay**. Los subsistemas utilizan componentes reutilizables, singletons globales para gestión de estados y una separación estricta entre el núcleo de simulación (Core) y la representación visual/UI.

Para las reglas fundamentales de esta arquitectura, consulta el [[Protocolo_Core_V2]].

## Subsistema de Simulación (Core_V2)

Es la espina dorsal del juego. Implementa un sistema de replay basado en:
- **Record**: Captura de estados de entrada por frame.
- **Snapshot**: Captura del estado completo del mundo en momentos específicos.
- **Restore**: Restauración del estado a partir de un snapshot (Hard Reset).
- **Playback**: Reproducción determinista de la simulación mediante el método `step(dt)`.

## Subsistema de Controlador Principal

Implementa movimiento preciso de Elías con plataformas 3D, doble salto vía propulsor y agarre de bordes, adaptado a la arquitectura determinista Core_V2. El movimiento se calcula en `step(dt)`, asegurando que cada salto y desplazamiento sea replicable exactamente en el sistema de replay.

​

## Subsistema de Gravedad Variable

Mecánica central que altera jugabilidad entre 1G, 0G (6DOF) y fluctuante vía volúmenes de trigger en niveles. `GravityManager` singleton actualiza `currentGravityDirection` globalmente, notificando a controladores vía señales; componentes `GravityVolume` definen zonas (e.g., rotatorios SCG). Desacopla física de UI (HUD indicador) para puzzles como alineación de plataformas.

​

## Subsistema de Dron Cargol

Control remoto de Cargol para puzzles multi-perspectiva y rutas alternativas, con vista switch fluida. `CargolManager` singleton maneja estados (aliado/rojo IA), vuelo inercial y vulnerabilidades (radiación); `RemoteControlComponent` en jugador alterna input sin pausar mundo. Integra con interacción para hacks a distancia, extendible a sacrificios narrativos.

​

## Subsistema de Vehículos

Cubre 4x4 terrestre, aéreo y 6DF para exploración escala-nave, con física inercial arcade. `VehicleBase` clase abstracta con componentes `WheelDrive`, `Thruster6DOF`; `VehicleManager` singleton trackea instancias y respawns. Prioridad Acto II/III, adaptable a sabotajes IA (PEM), reutilizando lógica de simuladores icarito.

​

## Subsistema de Interacción y Herramienta

Herramienta multi-modo (soldadura, hackeo, redirección) para puzzles sistemas; objetos usan `IInteractable` interface. `InteractionManager` singleton raycast-detecta highlights y ejecuta modos contextuales vía señales. Extensible a consolas IA/dialogos, desacoplado de combate (solo sigilo físico).

​

## Subsistema de IA Narrativa

Gestión de sabotajes pasivo-agresivos (gravedad, enemigos DDC) y diálogos PP-fantasma. `OdiseaAIManager` singleton orquesta eventos por acto, triggers ambientales y finales (5 variantes). Componentes `SabotageZone` activan amenazas; datos quests-like para progresión moral.

​

## Subsistema de Cámara (Core_V2)

Bajo Core_V2, la cámara sigue un contrato de **observación desacoplada**:
- **Rotación por Input**: La rotación de la cámara emerge puramente del input acumulado, sin que el controlador del jugador fuerce el `basis` del nodo.
- **Zonas 2.5D**: Implementa **Lazy Pan** (suavizado de seguimiento) y **Liberación de Ángulo**, permitiendo que la cámara mantenga la perspectiva 2.5D sin rigidez excesiva, mejorando el "feel" en secciones de plataformas laterales.

## Subsistema de UI y HUD

Reactiva a singletons vía signals: inventario futuro, quests, combustible propulsor, diálogos. `UIManager` singleton con canvases modulares (e.g., `DialoguePanel`, `GravityIndicator`). Desacoplada de lógica para testing headless.

​

## Subsistema de Gestión de Escenas y Progreso

`SceneManager` singleton carga actos/secuencias (split-screen futuro), trackea checkpoints/respawns. Integra `ProgressManager` para finales basados en choices (e.g., sacrificar Cargol).
