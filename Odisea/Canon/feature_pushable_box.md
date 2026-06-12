# Especificación: PushableBoxV2 (Objeto Híbrido Determinista)

## Objetivo

Crear un objeto con comportamiento físico dual: un modo dinámico para caídas y rotaciones realistas (6DoF), y un modo cinemático para reposo, apilamiento y transporte determinista. Este sistema permite realismo visual sin comprometer la integridad del replay.

## Clase Base y Configuración

- Nodo: `RigidBody` (configurado para alternar modos).
- Grupo: `replay_sync`.
- Configuración inicial: `mode = MODE_RIGID`. El control de `step(dt)` manejará el cambio a `MODE_KINEMATIC`.

## Lógica de Estados (Híbrido)

### Estado Dinámico (Caída/Caos)

Cuando el objeto es golpeado con fuerza o cae de una plataforma:

- Se comporta como un `RigidBody` estándar de Godot.
- Permite rotaciones en los 3 ejes y colisiones complejas.
- Determinismo: para minimizar el drift, forzar `sleeping = false` y registrar cada frame en replay.

### Estado Cinemático (Asentamiento)

Cuando la velocidad lineal y angular caen por debajo de un umbral durante N frames:

- Snap de rotación: si está cerca de los 90°, hacer snap a ejes globales para asegurar apilado.
- Cambio de modo: pasar a `MODE_KINEMATIC`.
- Drift correction: redondear posición a 4 decimales para eliminar inconsistencias de coma flotante.

## Integración de Simulación `step(dt)`

En lugar de dejarlo 100% en manos del motor, el `step` supervisa el estado:

- Monitoreo: si está en modo dinámico, verificar `linear_velocity.length() < 0.1`.
- Transición: si se cumple reposo, guardar la posición actual como nueva posición de anclaje determinista.
- Interacción: si el jugador toca el objeto en modo cinemático, "despertar" y volver a modo dinámico.

## Contrato de Replay (Snapshots)

El snapshot debe capturar el modo actual para saber cómo restaurar la física.

```gdscript
func get_snapshot() -> Dictionary:
    return {
        "pos": [global_transform.origin.x, global_transform.origin.y, global_transform.origin.z],
        "rot": [global_transform.basis.get_euler().x, global_transform.basis.get_euler().y, global_transform.basis.get_euler().z],
        "vel": [linear_velocity.x, linear_velocity.y, linear_velocity.z],
        "ang": [angular_velocity.x, angular_velocity.y, angular_velocity.z],
        "mode": mode # Captura si es RIGID o KINEMATIC
    }

func restore_snapshot(data: Dictionary):
```
