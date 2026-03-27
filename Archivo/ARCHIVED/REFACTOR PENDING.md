
## 💡 Refactor Sugerido para Claridad y Estabilidad

El objetivo del refactor es que **nunca haya duda** sobre qué script debe leer el input, cuál debe usar el input grabado y, sobre todo, cuál tiene permiso para **consumir (limpiar)** ese input.

### 1. Centralizar el Estado de la Cámara (ReplayManager.gd)

El agente debe centralizar la lógica de conmutación de la cámara usando un `enum` claro, eliminando la necesidad de variables booleanas dispersas.

|**Archivo**|**Acción Sugerida**|
|---|---|
|**ReplayManager.gd**|**Introducir un `enum` y una variable para el modo de cámara.**|

GDScript

```
# En ReplayManager.gd (o un script central de Replay)

enum CameraMode { FOLLOW_REPLAY, FREE_LOOK }

var current_camera_mode = CameraMode.FOLLOW_REPLAY # Estado por defecto
```

### 2. Clarificar la Fuente del Movimiento (PlayerSpringCam.gd)

En lugar de tener la lógica de conmutación de input directamente en `_physics_process`, encapsúlala en una función. Esto hace que el bucle principal sea trivial de leer.

|**Archivo**|**Acción Sugerida**|
|---|---|
|**PlayerSpringCam.gd**|**Crear una función `_get_mouse_motion()`** que aísle toda la lógica de qué input usar.|

GDScript

```
# En PlayerSpringCam.gd

# 1. Función para obtener la entrada de ratón de forma limpia
func _get_mouse_motion() -> Vector2:
    if not ReplayManager or ReplayManager.mode != ReplayManager.ReplayMode.PLAYBACK:
        # Modo LIVE o no-Replay: Usar el delta real
        return input_state.get_mouse_delta()
    
    # Estamos en modo PLAYBACK
    match ReplayManager.current_camera_mode:
        ReplayManager.CameraMode.FREE_LOOK:
            # FREE LOOK: Usar el delta real del usuario
            return input_state.get_mouse_delta()
        
        ReplayManager.CameraMode.FOLLOW_REPLAY:
            # FOLLOW REPLAY: Usar el delta inyectado (grabado)
            return input_state.mouse_delta
    
    return Vector2.ZERO

# 2. Simplificar _physics_process
func _physics_process(delta):
    # ...
    if not touch_active and player_id == 1:
        var motion = _get_mouse_motion() # <-- Trivial de leer
        
        # ... aplicación de target_yaw y target_pitch con 'motion'...

    # ... la lógica de limpieza ahora va separada (ver punto 3) ...
```

### 3. Consumo de Input (Limpieza) Condicional

Aquí se rompe el acoplamiento: la **única** razón para limpiar el `mouse_delta` es si el script lo acaba de usar **y** ese valor proviene de una **inyección** que debe borrarse.

|**Archivo**|**Acción Sugerida**|
|---|---|
|**PlayerSpringCam.gd**|**Limpiar solo el Pitch (Y) y solo en modo FOLLOW_REPLAY.**|
|**PlayerController.gd**|**Limpiar solo el Yaw (X) y solo en modo FOLLOW_REPLAY.**|

**Instrucción para Agente:**

> **Aísla y haz condicional la limpieza de input en ambos scripts:**
> 
> 1. En **`PlayerSpringCam.gd`**, al final de `_physics_process`, mantén la limpieza de `input_state.mouse_delta.y = 0.0` **solo si** `is_playback` y `ReplayManager.current_camera_mode == ReplayManager.CameraMode.FOLLOW_REPLAY`.
>     
> 2. En **`PlayerController.gd`**, al final de `_physics_process`, mantén la limpieza de `InputState.mouse_delta.x = 0.0` **solo si** `is_playback` y `ReplayManager.current_camera_mode == ReplayManager.CameraMode.FOLLOW_REPLAY`.
>     

### 4. Suavizado del Drift (Yank) y Control Basado en el Log

El log muestra un _drift_ constante (ej: `Divergence 0.000004`). La solución no es eliminar la corrección, sino **suavizarla**.

|**Archivo**|**Acción Sugerida**|
|---|---|
|**ReplayPlayback.gd**|**Reemplazar la asignación instantánea de `global_transform` con LERP/SLERP.**|

GDScript

```
# Archivo: scripts/replay/ReplayPlayback.gd

# Constante para el LERP: controla la velocidad de la corrección.
# 10.0 es fuerte (rápido), 5.0 es más suave.
const DRIFT_CORRECTION_STRENGTH = 10.0 

# Función para aplicar una corrección de posición y rotación suave
func _apply_smooth_drift_correction(pilot: Spatial, target_transform: Transform, delta: float) -> void:
    # Cálculo frame-rate-independiente.
    var t = 1.0 - exp(-delta * DRIFT_CORRECTION_STRENGTH)
    
    # 1. Suavizar Posición (LERP)
    var new_origin = pilot.global_transform.origin.linear_interpolate(
        target_transform.origin, t
    )
    
    # 2. Suavizar Rotación (SLERP)
    var new_basis = pilot.global_transform.basis.slerp(target_transform.basis, t) 
    
    # 3. Aplicar
    pilot.global_transform.origin = new_origin
    pilot.global_transform.basis = new_basis

# En la función principal de sincronización (donde se hace la corrección)
func _sync_pilot_to_frame(frame_data: Dictionary, delta: float) -> void:
    # ... cálculo de target_transform y divergencia ...
    
    # Si la divergencia es alta O está dentro de la tolerancia (pero queremos corregirla):
    if divergence_is_too_high or divergence_is_within_tolerance: 
        var target_transform = calculated_transform # La posición grabada
        
        # Reemplazar: pilot.global_transform = target_transform
        # Por:
        _apply_smooth_drift_correction(pilot, target_transform, delta) 
```

**Conclusión:** Este refactor hace que la intención del código sea inmediatamente clara para cualquier persona que lo lea: el modo de cámara determina la fuente del input, y la limpieza del input solo ocurre cuando se usa el valor grabado. El _yank_ se elimina reemplazando la corrección instantánea por un suavizado controlado.