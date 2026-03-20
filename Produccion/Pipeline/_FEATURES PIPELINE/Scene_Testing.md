
## I. Especificación: Suite de Regresión de Interacción Física (Core_V2)

### 1. Objetivo Principal

Garantizar que la evolución del código en `core_v2` (fricción, aceleración, gravedad) no rompa la compatibilidad con grabaciones previas ni la interacción con objetos del mundo, validando que el **Drift** se mantenga por debajo de **0.0001 unidades**.

### 2. Requerimientos Técnicos (Arquitectura V2)

|**Componente**|**Requerimiento en Core_V2**|**Propósito**|
|---|---|---|
|**Nodos Externos**|Deben pertenecer al grupo `replay_sync` y tener un método `get_snapshot()`.|Permitir que el `SessionManager` guarde su estado inicial al empezar la grabación.|
|**`SessionManager.gd`**|**Captura de Snapshot Inicial:** Al iniciar (Ctrl-R), debe capturar el estado de TODO el grupo `replay_sync`.|Asegurar que el punto de partida del mundo sea idéntico en el replay.|
|**`PlayerControllerV2.gd`**|**Pureza del `step()`**: No debe leer `Input` global de Godot, solo el `InputDataV2` inyectado.|Garantizar que el `SessionManager` pueda "conducir" al jugador durante el test.|
|**`InputDataV2.gd`**|Debe incluir `mouse_delta` para validar el determinismo de la rotación (Yaw/Pitch).|Evitar que cambios en la sensibilidad de cámara rompan el test.|

---

## II. Casos de Regresión (Mecánicas V2)

Necesitaremos tres archivos de referencia grabados exclusivamente con `Pilot_v2.tscn`:

1. **`v2_platform_test.json`**: Interacción con `KinematicBody` que mueve al jugador (herencia de velocidad).
    
2. **`v2_friction_test.json`**: Secuencia de frenado en seco y aceleración (para validar el "patinaje").
    
3. **`v2_jump_consistency.json`**: Salto con buffer y coyote time para validar tiempos de respuesta.
    

---

## III. Instrucciones de Implementación (GDUnit + Core_V2)

### Paso 1: Preparar los Nodos del Entorno

Para que una plataforma móvil sea compatible con tu suite, el script de la plataforma debe ser determinista o estar sincronizado.

- **Acción:** Añade a tus plataformas móviles:
    
    GDScript
    
    ```
    func get_snapshot() -> Dictionary:
        return { "pos": global_transform.origin, "rot": global_transform.basis.get_euler() }
    
    func restore_snapshot(data: Dictionary):
        global_transform.origin = data.pos
        # ... restaurar rotación ...
    ```
    

### Paso 2: El Test Suite de Regresión (Basado en tu `test_player_determinism_v2.gd`)

A diferencia de tu versión anterior, ahora el test no solo "mira" el replay, sino que **instancia un mundo nuevo y recrea la simulación**.

GDScript

```
# res://core_v2/tests/test_physics_regression_v2.gd
extends GdUnitTestSuite

const PlayerControllerV2 = preload("res://core_v2/sim/PlayerControllerV2.gd")
const FIXED_DT = 1.0 / 60.0

func test_regression_suite(relative_path : String) -> void:
    # 1. Cargar datos de referencia (JSON generado por SessionManager)
    var data = load_json("res://core_v2/tests/replays/" + relative_path)
    
    # 2. Setup del Mundo (Headless)
    var world = load(data.meta.scene).instance()
    get_tree().root.add_child(world)
    
    var player = load("res://core_v2/scenes/Pilot_v2.tscn").instance()
    world.add_child(player)
    player.set_physics_process(false) # Control manual

    # 3. Restaurar Estado Inicial (Critical!)
    player.restore_snapshot(data.buffer[0].snapshot)
    
    # 4. Simulación Loop
    for i in range(1, data.buffer.size()):
        var input_obj = InputDataV2.new()
        input_obj.from_dict(data.buffer[i].input)
        player.step(FIXED_DT, input_obj)
    
    # 5. Assertion Final
    var expected_pos = array_to_vector3(data.final_expected_state.position)
    assert_vector3(player.global_transform.origin).is_equal_approx(expected_pos, Vector3(0.0001, 0.0001, 0.0001))
    
    world.free()

# --- Casos de Prueba ---
func test_moving_platform():
    test_regression_suite("v2_platform_test.json")

func test_friction_regression():
    test_regression_suite("v2_friction_test.json")
```

---

## IV. Cambios Clave vs. Spec Anterior

1. **Umbral de Tolerancia:** Hemos bajado de `0.05` a `0.0001`. Con `core_v2` y `FIXED_DT`, la precisión debe ser casi perfecta. Si hay más de `0.0001` de drift, es que algo en la lógica no es determinista (posiblemente un `delta` que se coló donde no debía).
    
2. **Eliminación de `MODE_TEST`:** Ya no necesitas un modo especial en el playback. El propio test apaga el `_physics_process` del player y llama a `step()` directamente. Es mucho más limpio.
    
3. **Snapshots de Inicio:** El nuevo spec exige que el replay guarde la posición exacta de inicio del jugador, no solo del mundo. Esto evita errores si el `SpawnPoint` se mueve en el editor.
    

### Siguiente paso sugerido para tu Agente Copilot:

> "Actualiza `SessionManager.gd` para que al guardar el JSON, incluya en la sección `meta` no solo la escena, sino un snapshot de todos los nodos en el grupo `replay_sync`. Esto permitirá que la suite de regresión restaure las plataformas móviles a su posición exacta de inicio antes de ejecutar el test."

**¿Te gustaría que te ayude a definir el método `get_full_snapshot()` del Player para que incluya el estado de la fricción y las variables internas?**