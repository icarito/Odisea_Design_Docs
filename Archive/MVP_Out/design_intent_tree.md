# Design Intent Tree (DIT)

## Purpose
The Design Intent Tree captures the **learning objectives** that each room (or set of rooms) aims to teach the player, and the **metrics** used to verify that those objectives have been met. It serves as a communication tool between design, implementation, and QA to ensure the vertical slice delivers a clear, progressive skill curve.

## Structure
Each node in the tree corresponds to a **room** (or a logical group of rooms) and contains:
- **Objective**: What the player should be able to do after completing the room.
- **Success Criteria**: Observable player behaviors that indicate mastery.
- **Metrics**: Quantitative or qualitative measures to evaluate success.
- **Dependencies**: Prior rooms/objectives that must be mastered first.

## Rooms & Objectives (Acto I – Vertical Slice)

| Room | Learning Objective | Success Criteria | Metrics |
|------|--------------------|------------------|---------|
| **Criogenia – Despertar** | Familiarizar controles básicos de movimiento y cámara en 3D. | Player llega al primer interruptor sin atascos; usa giro y salto básicos. | Tiempo para llegar al interruptor < 20 s; número de colisiones con paredes < 2. |
| **Criogenia – Primer Interruptor** | Asociar la acción **Interactuar (E)** con cambios en el entorno (puerta, luz). | Player activa el interruptor y nota la apertura de la puerta adyacente. | % de jugadores que activan el interruptor en el primer intento > 80 %; tiempo medio de activación < 5 s. |
| **Criogenia – Ascensor** | Entender el uso de plataformas móviles como medio de transporte vertical. | Player sube al ascensor, lo activa y llega al piso superior sin caer. | Tiempo total de uso del ascensor < 15 s; número de intentos fallidos < 1. |
| **Criogenia – Segundo Piso – Consola de Techo** | Vincular una secuencia de acciones (interruptor → ascensor → consola) para alcanzar un objetivo superior. | Player activa la consola del techo y observa el cambio de estado (puerta de salida o holograma). | % de jugadores que completan la secuencia sin ayuda externa > 75 %; número de retrocesos (bajar y volver a subir) < 1. |
| **Transporte – Cintas Transportadoras** | Aprender a mover objetos (cajas) y usarlos como plataformas móviles para superar huecos. | Player empuja una caja sobre la cinta, la detiene y la usa para alcanzar una plataforma elevada. | Tiempo para completar el puzzle < 40 s; número de cajas mal posicionadas > 2 penaliza. |
| **Transporte – Puzzle de Cajas** | Internalizar la mecánica de **apilar cajas** para crear altura variable. | Player construye una pila de al menos 3 cajas y salta a la salida. | Número de cajas usadas = 3 (óptimo); tiempo de construcción < 25 s; porcentaje de jugadores que logran la pila en ≤2 intentos > 70 %. |
| **Transporte – Salida** | Consolidar todas las mecánicas aprendidas (movimiento, interacción, plataformas, empuje) en una salida con bajo nivel de guía. | Player llega a la salida sin ayuda visual explícita y activa la puerta final. | Tiempo total de sala < 90 s; número de pistas usadas (si existen) = 0 para jugadores expertos. |

## Métricas de Éxito Global (para el Vertical Slice)
- **Tiempo medio de completar la secuencia completa (desde spawn hasta salida final)**: 3‑5 min.
- **Tasa de abandono antes de terminar la secuencia**: < 10 %.
- **Feedback subjetivo (encuesta corta)**: ≥ 4/5 en claridad de objetivos y sensación de progreso.

## Cómo usar este documento
1. **Durante la implementación**: Cada desarrollador verifica que su sistema (interruptor, ascensor, cinta, caja) cumple con los success criteria definidos.
2. **Durante playtests**: Los testers registran métricas (tiempos, intentos, colisiones) y comparan contra los umbrales.
3. **Iteración**: Si una métrica no se cumple, se ajusta el diseño de la habitación (p.ej., aumentar señal visual, reducir distancia, cambiar velocidad de cinta) y se vuelve a testear.

## Próximos pasos
- Añadir este archivo al repositorio bajo `Odisea/Canon/`.
- Vincularlo desde el índice maestro (`Master_Index.md`) para fácil acceso.
- Programar una sesión de playtest interno enfocada en recolectar las métricas listadas arriba.
