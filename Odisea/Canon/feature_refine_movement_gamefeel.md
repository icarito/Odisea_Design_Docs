# Especificación: Refinamiento de Gamefeel y Mecánicas (Core V2)

## Salto Variable (Short Jump)

Para mejorar el control, el jugador debe poder controlar la altura del salto según cuánto tiempo presiona el botón.

- Lógica: si el jugador suelta el botón de salto (`!input.jump`) y la velocidad vertical es mayor a un umbral (ej. `jump_velocity * 0.5`), aplicar frenado o recortar velocidad vertical inmediatamente.
- Determinismo: esta comprobación debe ocurrir exclusivamente dentro de `step(dt, input)` de `PlayerJumpV2`.

## Fricción Diferenciada (Air vs Ground)

El control en el aire debe sentirse más pesado o con menos capacidad de giro para evitar exceso de agilidad.

Nuevas constantes:

- `movement_friction`: usada cuando `is_on_floor()`.
- `air_friction`: usada cuando `!is_on_floor()` (valor menor para más inercia o mayor para restringir control).

Implementación: `PlayerMovementV2` debe seleccionar la fricción basada en el estado de colisión del frame anterior.

## Curvas de Aceleración y Suavizado

Sustituir interpolaciones lineales por curvas de aceleración (easing) para evitar movimiento robótico.

- Plataformas: usar `SINE` o `CUBIC` en los extremos del recorrido.
- Curvas: usar `data/curves` para las aceleraciones.
- Input/movimiento: aplicar curva al `wish_direction`; no alcanzar velocidad máxima instantáneamente.
- Cámara: usar suavizado (`SmoothDamp` o `Lerp` determinista) en `step_camera(dt)` para evitar jitter en replay.

## Re-añadir Tank Turn (Opcional por Zona)

El sistema debe permitir activar modo de giro tipo Tank (estilo clásico):

- Input lateral: rota al personaje sobre eje Y.
- Input vertical: mueve hacia adelante/atrás en su vector frontal (`basis.z`).
- Estado: booleano `use_tank_controls`, conmutable y capturable en snapshot.

## Agachado (Crouch)

- Mecánica: al presionar agachado, reducir altura de `CollisionShape` y penalizar `max_speed` (ej. 50%).
- Visual: `PilotAnimatorV2` debe recibir señal/estado para `crouch_idle_loop` o `crouch_fwd_loop`.
- Importante: reducir la colisión hacia arriba para evitar atravesar suelo o quedar atrapado en techos bajos.

## Reglas de Oro para el Agente

- Snapshots: cualquier variable nueva (`is_crouching`, `current_friction`, etc.) debe incluirse en snapshot.
- Fixed step: prohibido usar delta variable de `_process`; todo refinamiento visual atado a `FIXED_DT`.
- Fricción de conveyors: la velocidad heredada debe sumarse al vector final de movimiento, no sustituirlo.
