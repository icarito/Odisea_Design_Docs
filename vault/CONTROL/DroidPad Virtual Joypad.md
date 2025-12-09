# DroidPad: Configuración, Escalas y Magnitudes

![[DroidPad_Odisea.png]]

## Tabla de Contenidos
1. [Almacenamiento de Configuración](#almacenamiento-de-configuración)
2. [Escala y Magnitudes](#escala-y-magnitudes)
3. [Interpretación de Datos](#interpretación-de-datos)
4. [Integración GDScript - Godot 3.x](#integración-gdscript---godot-3x-draft)

---

## Almacenamiento de Configuración

### Formato JSON Completo para Guardar/Exportar Pads

Cuando exportas un pad desde la app de DroidPad o lo guardas para importar después, se usa esta estructura completa:

```json
{
  "$schema": "droidpad_pad_v1.0",
  "meta": {
    "name": "Mi Controlador de Juego",
    "version": "1.0",
    "created": "2025-12-08T10:30:00Z",
    "padId": "game_pad_001"
  },
  "connection": {
    "type": "TCP",
    "defaultHost": "192.168.1.100",
    "defaultPort": 8080,
    "autoConnect": false
  },
  "canvas": {
    "width": 1080,
    "height": 1920,
    "backgroundColor": "#1e1e1e",
    "orientation": "portrait"
  },
  "elements": [
    {
      "id": "btn_a",
      "type": "BUTTON",
      "label": "A",
      "position": {
        "x": 800,
        "y": 600,
        "width": 100,
        "height": 100
      },
      "style": {
        "backgroundColor": "#ff0000",
        "textColor": "#ffffff",
        "fontSize": 24,
        "borderRadius": 50,
        "opacity": 1.0
      },
      "properties": {
        "vibration": true,
        "sound": true
      }
    },
    {
      "id": "left_stick",
      "type": "JOYSTICK",
      "label": "Left Stick",
      "position": {
        "x": 150,
        "y": 800,
        "width": 250,
        "height": 250,
        "radius": 125
      },
      "style": {
        "backgroundColor": "#333333",
        "stickColor": "#00ff00",
        "borderColor": "#666666",
        "borderWidth": 2
      },
      "properties": {
        "deadzone": 0.1,
        "sensitivity": 1.0,
        "returnToCenter": true,
        "locked": false
      }
    },
    {
      "id": "volume_slider",
      "type": "SLIDER",
      "label": "Volume",
      "position": {
        "x": 100,
        "y": 200,
        "width": 300,
        "height": 50
      },
      "style": {
        "trackColor": "#666666",
        "thumbColor": "#00ff00",
        "textColor": "#ffffff"
      },
      "properties": {
        "minValue": 0.0,
        "maxValue": 1.0,
        "defaultValue": 0.5,
        "step": 0.05,
        "orientation": "horizontal",
        "showLabel": true
      }
    },
    {
      "id": "dpad_movement",
      "type": "DPAD",
      "label": "Movement",
      "position": {
        "x": 150,
        "y": 400,
        "width": 200,
        "height": 200
      },
      "style": {
        "backgroundColor": "#333333",
        "buttonColor": "#0066ff",
        "activeColor": "#00ff00"
      },
      "properties": {
        "diagonalInput": true
      }
    },
    {
      "id": "switch_power",
      "type": "SWITCH",
      "label": "Power",
      "position": {
        "x": 500,
        "y": 100,
        "width": 100,
        "height": 60
      },
      "style": {
        "onColor": "#00ff00",
        "offColor": "#ff0000"
      },
      "properties": {
        "defaultState": false
      }
    },
    {
      "id": "steering_wheel",
      "type": "STEERING_WHEEL",
      "label": "Steering",
      "position": {
        "x": 300,
        "y": 1000,
        "width": 200,
        "height": 200,
        "radius": 100
      },
      "style": {
        "wheelColor": "#ff9900",
        "markerColor": "#ffffff"
      },
      "properties": {
        "minAngle": -180,
        "maxAngle": 180,
        "returnToCenter": true,
        "sensitivity": 1.0
      }
    }
  ]
}
```

### Estructura de Elementos

Cada elemento en `elements[]` contiene:

#### **BUTTON**
```json
{
  "id": "btn_fire",
  "type": "BUTTON",
  "label": "Fire",
  "position": {"x": 800, "y": 600, "width": 100, "height": 100},
  "style": {
    "backgroundColor": "#ff0000",
    "textColor": "#ffffff",
    "fontSize": 24,
    "borderRadius": 50
  },
  "properties": {
    "vibration": true,
    "sound": false
  }
}
```

#### **JOYSTICK**
```json
{
  "id": "left_stick",
  "type": "JOYSTICK",
  "label": "Left Stick",
  "position": {
    "x": 150,
    "y": 800,
    "width": 250,
    "height": 250,
    "radius": 125
  },
  "style": {
    "backgroundColor": "#333333",
    "stickColor": "#00ff00",
    "borderColor": "#666666"
  },
  "properties": {
    "deadzone": 0.1,
    "sensitivity": 1.0,
    "returnToCenter": true
  }
}
```

#### **SLIDER**
```json
{
  "id": "volume",
  "type": "SLIDER",
  "label": "Volume",
  "position": {
    "x": 100,
    "y": 200,
    "width": 300,
    "height": 50
  },
  "properties": {
    "minValue": 0.0,
    "maxValue": 1.0,
    "defaultValue": 0.5,
    "step": 0.05,
    "orientation": "horizontal"
  }
}
```

#### **DPAD**
```json
{
  "id": "dpad_movement",
  "type": "DPAD",
  "label": "Movement",
  "position": {
    "x": 150,
    "y": 400,
    "width": 200,
    "height": 200
  },
  "properties": {
    "diagonalInput": true
  }
}
```

#### **SWITCH**
```json
{
  "id": "power",
  "type": "SWITCH",
  "label": "Power",
  "position": {
    "x": 500,
    "y": 100,
    "width": 100,
    "height": 60
  },
  "properties": {
    "defaultState": false
  }
}
```

#### **STEERING_WHEEL**
```json
{
  "id": "steering",
  "type": "STEERING_WHEEL",
  "label": "Steering",
  "position": {
    "x": 300,
    "y": 1000,
    "width": 200,
    "height": 200,
    "radius": 100
  },
  "properties": {
    "minAngle": -180,
    "maxAngle": 180,
    "returnToCenter": true,
    "sensitivity": 1.0
  }
}
```

---

## Escala y Magnitudes

### Tabla Completa de Rangos por Componente

| Componente | Rango | Unidad | Precisión | Notas |
|-----------|-------|--------|-----------|-------|
| **Joystick X** | -1.0 a +1.0 | Normalizado | Float | 0.0 = centro, 1.0 = máximo derecha, -1.0 = máximo izquierda |
| **Joystick Y** | -1.0 a +1.0 | Normalizado | Float | 0.0 = centro, 1.0 = máximo abajo, -1.0 = máximo arriba |
| **Slider** | `minValue` a `maxValue` | Configurable | Float | Rango completamente definible en diseño |
| **Steering Angle** | -180 a +180 | Grados | Float | 0° = recto, positivo = horario, negativo = contra-horario |
| **Accelerometer X,Y,Z** | -20 a +20 | m/s² | Float | Incluye gravedad (Z ≈ 9.8 en reposo) |
| **Gyroscope X,Y,Z** | -π a +π | rad/s | Float | ±3.14159... radianes por segundo |
| **Button State** | N/A | Discreto | String | PRESS, RELEASE, CLICK |
| **DPAD Direction** | N/A | Discreto | String | LEFT, RIGHT, UP, DOWN |
| **Switch State** | N/A | Booleano | Boolean | true (ON), false (OFF) |

### Propiedades de Configuración

#### **Deadzone** (Joystick)
- **Rango:** 0.0 a 0.5
- **Significado:** Área alrededor del centro donde se ignoran pequeños movimientos
- **Ejemplo:** `deadzone: 0.1` = ignora movimientos menores a 10% del rango máximo

#### **Sensitivity** (Joystick, Steering)
- **Rango:** 0.1 a 3.0 (típicamente)
- **Significado:** Multiplicador del movimiento
- **Ejemplo:** `sensitivity: 1.0` = normal, `sensitivity: 2.0` = el doble de sensible

#### **Step** (Slider)
- **Rango:** Cualquier valor positivo
- **Significado:** Incremento mínimo entre cambios
- **Ejemplo:** `step: 0.05` con `maxValue: 1.0` = 20 posiciones distintas

#### **Radius** (Joystick, Steering)
- **Unidad:** Píxeles
- **Significado:** Radio del área circular interactiva
- **Ejemplo:** `radius: 125` = círculo de 250px de diámetro

---

## Interpretación de Datos

### Ejes de Joystick

```
       Y = -1.0 (ARRIBA)
           ↑
           │
X = -1.0 ← 0,0 → X = +1.0 (DERECHA)
(IZQUIERDA) │
           ↓
       Y = +1.0 (ABAJO)
```

**Ejemplo de lectura:**
- `{"x": 0.5, "y": 0.0}` = Palanca hacia la derecha
- `{"x": 0.0, "y": -1.0}` = Palanca hacia arriba (máximo)
- `{"x": -0.707, "y": 0.707}` = Diagonal inferior-izquierda

### Slider - Cálculo de Valor Real

```
rango_disponible = maxValue - minValue
valor_real = minValue + (valor_normalizado * rango_disponible)
```

**Ejemplo:**
- `minValue: 20`, `maxValue: 100`, `valor_recibido: 0.5`
- `rango = 100 - 20 = 80`
- `valor_real = 20 + (0.5 * 80) = 60`

### Steering Wheel - Ángulos

```
        0° (RECTO)
           ↑
           │
-90° ← ─── → +90°
(IZQUIERDA) (DERECHA)
           │
           ↓
        ±180° (REVERSA)
```

**Interpretación:**
- `angle: 0°` = posición neutral
- `angle: 45°` = girado 45° hacia la derecha
- `angle: -90°` = girado 90° a la izquierda
- `angle: 180°` o `-180°` = girado hacia atrás (equivalentes)

### Acelerómetro - Gravedad

El acelerómetro **incluye la gravedad** en todas sus mediciones:

```
En reposo (dispositivo plano sobre mesa):
{
  "x": 0.0,
  "y": 0.0,
  "z": 9.81  ← Gravedad terrestre
}
```

**Para obtener aceleración "verdadera", restar gravedad:**

```gdscript
var true_acceleration = Vector3(
    accel.x,
    accel.y,
    accel.z - 9.81  # Restar gravedad del eje Z
)
```

---

## Integración GDScript - Godot 3.x [DRAFT]

### Clase Base para Cargar Configuración

```gdscript
# DroidPadConfig.gd
extends Reference

class_name DroidPadConfig

var schema_version: String
var meta: Dictionary
var connection: Dictionary
var canvas: Dictionary
var elements: Array

func _init():
    schema_version = ""
    meta = {}
    connection = {}
    canvas = {}
    elements = []

# Cargar desde archivo JSON
func load_from_file(file_path: String) -> bool:
    if not ResourceLoader.exists(file_path):
        push_error("File not found: %s" % file_path)
        return false
    
    var file = File.new()
    var error = file.open(file_path, File.READ)
    
    if error != OK:
        push_error("Could not open file: %s" % file_path)
        return false
    
    var json_string = file.get_as_text()
    file.close()
    
    var json = JSON.parse(json_string)
    if json.error:
        push_error("JSON Parse Error: %s" % json.error_string)
        return false
    
    return load_from_dict(json.result)

# Cargar desde diccionario
func load_from_dict(data: Dictionary) -> bool:
    if not data.has("$schema"):
        push_error("Invalid DroidPad config: missing $schema")
        return false
    
    schema_version = data["$schema"]
    meta = data.get("meta", {})
    connection = data.get("connection", {})
    canvas = data.get("canvas", {})
    elements = data.get("elements", [])
    
    return true

# Guardar a archivo JSON
func save_to_file(file_path: String) -> bool:
    var data = to_dict()
    var json_string = JSON.print(data, "\t")
    
    var file = File.new()
    var error = file.open(file_path, File.WRITE)
    
    if error != OK:
        push_error("Could not write to file: %s" % file_path)
        return false
    
    file.store_string(json_string)
    file.close()
    return true

# Convertir a diccionario
func to_dict() -> Dictionary:
    return {
        "$schema": schema_version,
        "meta": meta,
        "connection": connection,
        "canvas": canvas,
        "elements": elements
    }

# Obtener elemento por ID
func get_element(element_id: String) -> Dictionary:
    for element in elements:
        if element.get("id") == element_id:
            return element
    return {}

# Obtener elementos por tipo
func get_elements_by_type(element_type: String) -> Array:
    var result = []
    for element in elements:
        if element.get("type") == element_type:
            result.append(element)
    return result

# Obtener todas las propiedades de un elemento
func get_element_properties(element_id: String) -> Dictionary:
    var element = get_element(element_id)
    return element.get("properties", {})

# Obtener la posición de un elemento
func get_element_position(element_id: String) -> Dictionary:
    var element = get_element(element_id)
    return element.get("position", {})

# Obtener el rango de un slider
func get_slider_range(element_id: String) -> Dictionary:
    var props = get_element_properties(element_id)
    return {
        "min": props.get("minValue", 0.0),
        "max": props.get("maxValue", 1.0),
        "default": props.get("defaultValue", 0.5),
        "step": props.get("step", 0.01)
    }

# Obtener propiedades de joystick
func get_joystick_properties(element_id: String) -> Dictionary:
    var props = get_element_properties(element_id)
    return {
        "deadzone": props.get("deadzone", 0.1),
        "sensitivity": props.get("sensitivity", 1.0),
        "returnToCenter": props.get("returnToCenter", true)
    }

# Obtener propiedades de steering wheel
func get_steering_properties(element_id: String) -> Dictionary:
    var props = get_element_properties(element_id)
    return {
        "minAngle": props.get("minAngle", -180),
        "maxAngle": props.get("maxAngle", 180),
        "returnToCenter": props.get("returnToCenter", true),
        "sensitivity": props.get("sensitivity", 1.0)
    }
```

### Clase para Procesar Eventos

```gdscript
# DroidPadEventProcessor.gd
extends Reference

class_name DroidPadEventProcessor

# Signals
signal button_pressed(element_id)
signal button_released(element_id)
signal joystick_moved(element_id, position)  # Vector2
signal slider_changed(element_id, value)      # float
signal dpad_pressed(element_id, direction)    # STRING: LEFT/RIGHT/UP/DOWN
signal switch_toggled(element_id, state)      # bool
signal steering_rotated(element_id, angle)    # float

var config: DroidPadConfig

func _init(p_config: DroidPadConfig = null):
    config = p_config

# Procesar evento JSON recibido
func process_event(json_string: String) -> Dictionary:
    var json = JSON.parse(json_string)
    
    if json.error:
        push_error("Invalid JSON: %s" % json.error_string)
        return {}
    
    return process_dict(json.result)

# Procesar evento desde diccionario
func process_dict(data: Dictionary) -> Dictionary:
    var event_type = data.get("type", "UNKNOWN")
    var element_id = data.get("id", "")
    
    match event_type:
        "BUTTON":
            _handle_button(element_id, data)
        "DPAD":
            _handle_dpad(element_id, data)
        "JOYSTICK":
            _handle_joystick(element_id, data)
        "SLIDER":
            _handle_slider(element_id, data)
        "SWITCH":
            _handle_switch(element_id, data)
        "STEERING_WHEEL":
            _handle_steering(element_id, data)
        "ACCELEROMETER":
            return _handle_accelerometer(element_id, data)
        "GYROSCOPE":
            return _handle_gyroscope(element_id, data)
        _:
            push_warning("Unknown event type: %s" % event_type)
    
    return data

func _handle_button(element_id: String, data: Dictionary) -> void:
    var state = data.get("state", "")
    
    match state:
        "PRESS":
            button_pressed.emit(element_id)
        "RELEASE":
            button_released.emit(element_id)
        "CLICK":
            button_pressed.emit(element_id)

func _handle_joystick(element_id: String, data: Dictionary) -> void:
    var x = float(data.get("x", 0.0))
    var y = float(data.get("y", 0.0))
    
    # Clamping a [-1, 1]
    x = clamp(x, -1.0, 1.0)
    y = clamp(y, -1.0, 1.0)
    
    var position = Vector2(x, y)
    joystick_moved.emit(element_id, position)

func _handle_slider(element_id: String, data: Dictionary) -> void:
    var value = float(data.get("value", 0.0))
    slider_changed.emit(element_id, value)

func _handle_dpad(element_id: String, data: Dictionary) -> void:
    var button = data.get("button", "")
    var state = data.get("state", "")
    
    match state:
        "PRESS", "CLICK":
            dpad_pressed.emit(element_id, button)

func _handle_switch(element_id: String, data: Dictionary) -> void:
    var state = bool(data.get("state", false))
    switch_toggled.emit(element_id, state)

func _handle_steering(element_id: String, data: Dictionary) -> void:
    var angle = float(data.get("angle", 0.0))
    steering_rotated.emit(element_id, angle)

func _handle_accelerometer(element_id: String, data: Dictionary) -> Dictionary:
    var accel = Vector3(
        float(data.get("x", 0.0)),
        float(data.get("y", 0.0)),
        float(data.get("z", 0.0))
    )
    
    # Restar gravedad del eje Z para aceleración "verdadera"
    var true_accel = Vector3(accel.x, accel.y, accel.z - 9.81)
    
    return {
        "acceleration": accel,
        "true_acceleration": true_accel,
        "magnitude": accel.length()
    }

func _handle_gyroscope(element_id: String, data: Dictionary) -> Dictionary:
    var rotation = Vector3(
        float(data.get("x", 0.0)),
        float(data.get("y", 0.0)),
        float(data.get("z", 0.0))
    )
    
    return {
        "angular_velocity": rotation,
        "magnitude": rotation.length()
    }
```

### Ejemplo de Uso en Escena

```gdscript
# GamepadManager.gd
extends Node

var config: DroidPadConfig
var processor: DroidPadEventProcessor
var player: Node  # Referencia al jugador

func _ready() -> void:
    # Cargar configuración
    config = DroidPadConfig.new()
    if not config.load_from_file("res://pads/game_controller.json"):
        push_error("Failed to load pad configuration")
        return
    
    print("Pad loaded: %s" % config.meta.get("name", "Unknown"))
    print("Canvas: %dx%d" % [
        config.canvas.get("width", 0),
        config.canvas.get("height", 0)
    ])
    
    # Inicializar procesador de eventos
    processor = DroidPadEventProcessor.new(config)
    processor.connect("joystick_moved", self, "_on_joystick_moved")
    processor.connect("button_pressed", self, "_on_button_pressed")
    processor.connect("slider_changed", self, "_on_slider_changed")
    processor.connect("dpad_pressed", self, "_on_dpad_pressed")
    processor.connect("switch_toggled", self, "_on_switch_toggled")
    processor.connect("steering_rotated", self, "_on_steering_rotated")
    
    # Obtener información de controles
    var left_stick_props = config.get_joystick_properties("left_stick")
    print("Left Stick Deadzone: %f" % left_stick_props.deadzone)
    
    var volume_range = config.get_slider_range("volume_slider")
    print("Volume Range: %.1f to %.1f" % [volume_range.min, volume_range.max])

func _process(delta: float) -> void:
    # En un servidor real, recibirías eventos JSON vía TCP/WebSocket
    pass

# Callbacks
func _on_joystick_moved(element_id: String, position: Vector2) -> void:
    print("Joystick %s: (%.2f, %.2f)" % [element_id, position.x, position.y])
    
    if element_id == "left_stick":
        player.velocity = position * player.speed

func _on_button_pressed(element_id: String) -> void:
    print("Button pressed: %s" % element_id)
    
    if element_id == "btn_a":
        player.jump()
    elif element_id == "btn_b":
        player.attack()

func _on_slider_changed(element_id: String, value: float) -> void:
    print("Slider %s: %.2f" % [element_id, value])
    
    if element_id == "volume_slider":
        AudioServer.set_bus_mute(0, false)
        AudioServer.set_bus_volume_db(0, linear2db(value))

func _on_dpad_pressed(element_id: String, direction: String) -> void:
    print("DPAD %s: %s" % [element_id, direction])
    
    match direction:
        "UP":
            player.look_direction = Vector3(0, 0, -1)
        "DOWN":
            player.look_direction = Vector3(0, 0, 1)
        "LEFT":
            player.look_direction = Vector3(-1, 0, 0)
        "RIGHT":
            player.look_direction = Vector3(1, 0, 0)

func _on_switch_toggled(element_id: String, state: bool) -> void:
    print("Switch %s: %s" % [element_id, "ON" if state else "OFF"])
    
    if element_id == "power":
        get_tree().paused = state

func _on_steering_rotated(element_id: String, angle: float) -> void:
    print("Steering angle: %.1f°" % angle)
    
    # Convertir ángulo a radians para Godot
    var rotation_rad = deg2rad(angle)
    player.rotation.y = rotation_rad
```

### Lectura Práctica de Configuración

```gdscript
# Ejemplo: Interpretar configuración de slider
var config = DroidPadConfig.new()
config.load_from_file("res://pads/my_controller.json")

var slider_element = config.get_element("volume_slider")
var props = slider_element.get("properties", {})

var min_val = props.get("minValue", 0.0)
var max_val = props.get("maxValue", 1.0)
var step = props.get("step", 0.01)

# Cuando recibas un valor (ej: 0.5)
var received_value = 0.5
var real_value = min_val + (received_value * (max_val - min_val))
print("Valor interpretado: %.2f" % real_value)

# Ejemplo: Usar propiedades de joystick
var js_element = config.get_element("left_stick")
var js_props = js_element.get("properties", {})

var deadzone = js_props.get("deadzone", 0.1)
var sensitivity = js_props.get("sensitivity", 1.0)

# Al recibir posición de joystick
var received_pos = Vector2(0.05, 0.03)  # Movimiento pequeño
if received_pos.length() < deadzone:
    # Ignorar por debajo de deadzone
    received_pos = Vector2.ZERO
else:
    # Aplicar sensibilidad
    received_pos *= sensitivity
```

---

## Notas sobre este Draft

⚠️ **IMPORTANTE:** Esta es una especificación **DRAFT para Godot 3.x**

**Cambios esperados para Godot 4.x:**
- `JSON.parse()` → `JSON.parse_string()` (más intuitivo)
- `Signal.emit()` → sintaxis de signals actualizada
- `File` → `FileAccess` (nueva API)
- Tipado más fuerte con tipos opcionales

**Limitaciones conocidas:**
- No incluye validación exhaustiva de esquema JSON
- Las señales están básicamente implementadas (sin validación de parámetros)
- No hay manejo automático de reconexión TCP
- Los ejemplos de servidor TCP no están incluidos (solo procesamiento de eventos)

**Próximas mejoras:**
- Clase de servidor TCP/WebSocket integrada
- Validador de esquema JSON más robusto
- Sistema de presets para configuraciones comunes
- Soporte para hot-reload de configuraciones

---

## Referencias

- [GitHub: UmerCodez/DroidPad](https://github.com/UmerCodez/DroidPad)
- [Godot 3.x Documentation](https://docs.godotengine.org/en/3.5/)
- Licencia: GPL-3.0
