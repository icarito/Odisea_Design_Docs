## Introducción

Los subsistemas de Odisea siguen una arquitectura modular inspirada en Cogito, con componentes reutilizables, singletons globales para gestión de estados y separación estricta entre lógica de datos, comportamiento y UI. Cada subsistema opera de forma desacoplada: la lógica central reside en singletons o managers accesibles globalmente, los componentes se adjuntan a nodos del mundo para funcionalidades específicas (e.g., interactuables), y la UI se actualiza reactivamente vía señales. Esto facilita pruebas independientes, escalabilidad para actos múltiples y mantenimiento, priorizando el MVP del Acto I (controlador Elías, Cargol, gravedad).

​

## Subsistema de Controlador Principal

Implementa movimiento preciso de Elías con plataformas 3D, doble salto vía propulsor y agarre de bordes, adaptable a gravedad variable. Usa un `PlayerController` singleton que gestiona estados (terrestre, 0G) y aplica fuerzas kinemáticas para predictibilidad. Componentes modulares como `GravityAdapter` se adjuntan para cambios dinámicos de vector gravedad, inspirado en la modularidad de Cogito para inputs duales.

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

## Subsistema de UI y HUD

Reactiva a singletons vía signals: inventario futuro, quests, combustible propulsor, diálogos. `UIManager` singleton con canvases modulares (e.g., `DialoguePanel`, `GravityIndicator`). Desacoplada de lógica para testing headless.

​

## Subsistema de Gestión de Escenas y Progreso

`SceneManager` singleton carga actos/secuencias (split-screen futuro), trackea checkpoints/respawns. Integra `ProgressManager` para finales basados en choices (e.g., sacrificar Cargol).