# DroidPad: Integración, Conexión y QR

---

## Tabla de Contenidos
1. [Datos de Conexión en QR](#datos-de-conexión-en-qr)
2. [Formatos de QR Soportados](#formatos-de-qr-soportados)
3. [Generar QR desde tu App](#generar-qr-desde-tu-app)
4. [Formato de Eventos en Tiempo Real](#formato-de-eventos-en-tiempo-real)
5. [Protocolo de Comunicación](#protocolo-de-comunicación)
6. [Preguntas Frecuentes](#preguntas-frecuentes)

---

## Datos de Conexión en QR

### ¿Incluyen todos los datos de conexión?

**Respuesta corta:** Sí, cuando se genera correctamente.

Los QR codes de DroidPad son diseñados para contener **toda la información necesaria** para que un dispositivo móvil se conecte automáticamente a tu servidor/app sin necesidad de configuración manual adicional.

**Datos incluidos:**
- Nombre del pad (identificador único)
- Protocolo de comunicación (TCP, UDP, WEBSOCKET, MQTT, BLE)
- Host/IP address del servidor
- Puerto de conexión
- Timeout (opcional)

---

## Formatos de QR Soportados

DroidPad soporta múltiples formatos para codificar datos de conexión. Elige el que mejor se adapte a tu caso de uso.

### Formato 1: Deep Link URL (Recomendado)

```
droidpad://import/config?pad=my_gamepad&protocol=TCP&host=192.168.1.100&port=8080
```

**Parámetros:**
| Parámetro | Obligatorio | Rango | Ejemplo |
|-----------|------------|-------|---------|
| `pad` | Sí | String | `my_gamepad` |
| `protocol` | Sí | TCP, UDP, WEBSOCKET, MQTT, BLE | `TCP` |
| `host` | Sí | IP o hostname | `192.168.1.100` |
| `port` | Sí | 1-65535 | `8080` |
| `timeout` | No | Milisegundos | `5000` |

**Ventajas:**
- URL limpia y legible
- Fácil de generar desde cualquier lenguaje
- Deep links permiten integración con navegadores
- Escálable a nuevos parámetros

**Desventajas:**
- Requiere que la app esté instalada para manejar `droidpad://`
- Si la app no está instalada, necesita fallback

**Ejemplo completo:**
```
droidpad://import/config?pad=game_controller&protocol=TCP&host=192.168.1.50&port=8080&timeout=10000
```

### Formato 2: JSON Base64 Encoded

**JSON original:**
```json
{
  "pad": "my_gamepad",
  "protocol": "TCP",
  "host": "192.168.1.100",
  "port": 8080
}
```

**Codificado en Base64:**
```
eyJwYWQiOiAibXlfZ2FtZXBhZCIsICJwcm90b2NvbCI6ICJUQ1AiLCAiaG9zdCI6ICIxOTIuMTY4LjEuMTAwIiwgInBvcnQiOiA4MDgwfQ==
```

**Ventajas:**
- Más compacto en algunos casos
- Fácil de parsear en JSON
- Puede contener más datos complejos

**Desventajas:**
- Menos legible
- QR más denso = más área requerida
- Requiere decodificación Base64

### Formato 3: Plain Text JSON

```
{"pad":"my_gamepad","protocol":"TCP","host":"192.168.1.100","port":8080}
```

**Ventajas:**
- Muy simple
- Completamente legible
- Fácil debug

**Desventajas:**
- QR más grande
- Menos robusto

---

## Generar QR desde tu App

### Opción 1: Usando API Web Gratuita (Más Simple)

**Ventajas:**
- No requiere dependencias locales
- Funciona en cualquier plataforma
- Instantáneo

**Desventajas:**
- Requiere conexión a internet
- Depende de servicios externos
- Potencial latencia de red

#### Godot 3.x

```gdscript
# QRGenerator.gd
extends Node

func generate_qr_from_deeplink(pad_name: String, host: String, port: int, protocol: String = "TCP") -> String:
    var deeplink = create_droidpad_deeplink(pad_name, host, port, protocol)
    var encoded = deeplink.uri_encode()
    
    # Usar qrserver.com (gratis, sin autenticación)
    return "https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=%s" % encoded

func create_droidpad_deeplink(pad_name: String, host: String, port: int, protocol: String = "TCP") -> String:
    var params = "pad=%s&protocol=%s&host=%s&port=%d" % [pad_name, protocol, host, port]
    return "droidpad://import/config?%s" % params

# Uso en escena
func _ready():
    var qr_url = generate_qr_from_deeplink("my_pad", "192.168.1.50", 8080, "TCP")
    print("QR URL: %s" % qr_url)
    
    # Mostrar en navegador (para testing)
    OS.shell_open(qr_url)
    
    # O mostrar la imagen en un TextureRect
    var http = HTTPClient.new()
    # ... código para descargar la imagen
```

#### Python (Servidor Backend)

```python
from urllib.parse import urlencode, quote
import requests

def generate_droidpad_qr(pad_name: str, host: str, port: int, protocol: str = "TCP") -> str:
    """Generar URL de QR para importar config en DroidPad"""
    deeplink = f"droidpad://import/config?pad={pad_name}&protocol={protocol}&host={host}&port={port}"
    
    # Usar API de qrserver
    qr_url = f"https://api.qrserver.com/v1/create-qr-code/?size=300x300&data={quote(deeplink)}"
    return qr_url

# Uso
qr_url = generate_droidpad_qr("game_controller", "192.168.1.100", 8080, "TCP")
print(f"Mostrar este QR: {qr_url}")

# Descargar la imagen
response = requests.get(qr_url)
with open("droidpad_qr.png", "wb") as f:
    f.write(response.content)
```

#### JavaScript/Node.js

```javascript
function generateDroidPadQR(padName, host, port, protocol = "TCP") {
    const deeplink = `droidpad://import/config?pad=${padName}&protocol=${protocol}&host=${host}&port=${port}`;
    const encoded = encodeURIComponent(deeplink);
    return `https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=${encoded}`;
}

// Uso
const qrUrl = generateDroidPadQR("my_pad", "192.168.1.50", 8080, "TCP");
console.log("QR URL:", qrUrl);

// Mostrar en HTML
document.getElementById("qrImage").src = qrUrl;
```

### Opción 2: Usar un Addon de QR Local (Recomendado para Producción)

Para Godot, existen addons gratuitos que generan QR sin necesidad de internet:

**Pasos:**
1. Descargar addon QR desde Asset Store de Godot
2. Instalarlo en `res://addons/qr/`
3. Activarlo en Project Settings → Plugins

**Godot 3.x con addon QR:**

```gdscript
# Requiere addon QR instalado
extends Node

func _ready():
    var qr_generator = preload("res://addons/qr/qr.gd")
    
    var config = {
        "pad": "game_controller",
        "protocol": "TCP",
        "host": get_local_ip(),
        "port": 8080
    }
    
    var qr_string = JSON.print(config)
    var qr_image = qr_generator.generate(qr_string, 10)  # 10 = tamaño
    
    # Mostrar en TextureRect
    $TextureRect.texture = qr_image

func get_local_ip() -> String:
    var ip_addresses = IP.get_local_addresses()
    for addr in ip_addresses:
        if addr.contains(".") and not addr.begins_with("127"):
            return addr
    return "127.0.0.1"
```

### Opción 3: Deep Link sin Generar Imagen

Si solo necesitas compartir el enlace (sin la imagen visual del QR):

```gdscript
func create_shareable_droidpad_link(pad_name: String, host: String, port: int) -> String:
    var deeplink = "droidpad://import/config?pad=%s&protocol=TCP&host=%s&port=%d" % [pad_name, host, port]
    return deeplink

# Uso: compartir vía WhatsApp, Telegram, email, etc.
func share_controller_config():
    var link = create_shareable_droidpad_link("my_game", "192.168.1.100", 8080)
    OS.shell_open("https://wa.me/?text=%s" % link.uri_encode())  # WhatsApp
```

---

## Formato de Eventos en Tiempo Real

### Eventos Recibidos desde DroidPad

Cuando los usuarios interactúan con controles en la app DroidPad, se envían eventos al servidor en formato JSON.

Cada evento contiene:
- **id:** Identificador único del elemento
- **type:** Tipo de control
- **Datos específicos:** Dependen del tipo

### Tabla de Eventos por Tipo

#### **BUTTON** (Botón)
```json
{
  "id": "btn_fire",
  "type": "BUTTON",
  "state": "PRESS"
}
```

Estados posibles:
- `PRESS` - Botón presionado (descenso)
- `RELEASE` - Botón liberado (ascenso)
- `CLICK` - Un click completo (presion + liberación)

#### **DPAD** (Botones Direccionales)
```json
{
  "id": "arrow_keys",
  "type": "DPAD",
  "button": "RIGHT",
  "state": "CLICK"
}
```

Direcciones: `LEFT`, `RIGHT`, `UP`, `DOWN`
Estados: `PRESS`, `RELEASE`, `CLICK`

#### **JOYSTICK** (Palanca Analógica)
```json
{
  "id": "left_stick",
  "type": "JOYSTICK",
  "x": 0.5,
  "y": -0.75
}
```

**Importante:**
- Rango: **x y y de -1.0 a +1.0** (normalizado)
- Centro: 0.0
- Sin campo "state" - es solo la posición actual
- Se envía continuamente mientras se mueve

**Interpretación de ejes:**
```
         y = -1.0
            ↑
            |
x = -1.0 ← 0,0 → x = +1.0
            |
            ↓
         y = +1.0
```

#### **SLIDER** (Control Deslizante)
```json
{
  "id": "volume",
  "type": "SLIDER",
  "value": 0.85
}
```

- Rango: **Desde `minValue` a `maxValue`** definidos en la configuración
- Típicamente 0.0 a 1.0, pero completamente configurable
- Se envía continuamente

#### **SWITCH** (Interruptor ON/OFF)
```json
{
  "id": "power",
  "type": "SWITCH",
  "state": true
}
```

- `state`: `true` (ON) o `false` (OFF)
- Se envía al cambiar de estado

#### **STEERING_WHEEL** (Volante de Dirección)
```json
{
  "id": "steering",
  "type": "STEERING_WHEEL",
  "angle": 45.233445
}
```

- Rango: **-180 a +180 grados**
- 0° = posición neutra (recto)
- Positivo = rotación horaria (derecha)
- Negativo = rotación contra-horaria (izquierda)
- Se envía continuamente

#### **ACCELEROMETER** (Sensor de Aceleración)
```json
{
  "type": "ACCELEROMETER",
  "x": 0.31892395,
  "y": -0.97802734,
  "z": 10.049896
}
```

- Unidad: **m/s²** (metros por segundo al cuadrado)
- Incluye gravedad (Z ≈ 9.8 en reposo)
- Rango típico: -20 a +20 m/s²
- Ejes: X (lateral), Y (frontal), Z (vertical)

#### **GYROSCOPE** (Sensor Giroscópico)
```json
{
  "type": "GYROSCOPE",
  "x": 0.15387291,
  "y": -0.22954187,
  "z": 0.08163925
}
```

- Unidad: **rad/s** (radianes por segundo)
- Rango típico: -π a +π (-3.14159 a +3.14159)
- Velocidad de rotación alrededor de cada eje
- No incluye posición, solo velocidad de giro

---

## Protocolo de Comunicación

### Conexión TCP

**Flujo de conexión:**

```
1. Cliente (DroidPad) inicia conexión TCP
2. Se conecta a host:puerto especificado
3. Envía eventos JSON, uno por línea
4. Servidor procesa cada línea como evento independiente
5. Conexión se mantiene abierta hasta cierre
```

**Formato:**
```
{evento JSON 1}\n
{evento JSON 2}\n
{evento JSON 3}\n
...
```

**Ejemplo de stream TCP recibido:**
```
{"id":"left_stick","type":"JOYSTICK","x":0.0,"y":0.0}
{"id":"left_stick","type":"JOYSTICK","x":0.1,"y":0.0}
{"id":"left_stick","type":"JOYSTICK","x":0.2,"y":-0.1}
{"id":"btn_a","type":"BUTTON","state":"PRESS"}
{"id":"btn_a","type":"BUTTON","state":"RELEASE"}
```

### Conexión WebSocket

Similar a TCP, pero con protocolo WebSocket (ws:// o wss://):

```javascript
// Cliente WebSocket
const ws = new WebSocket("ws://192.168.1.100:8080");

ws.onmessage = (event) => {
    const data = JSON.parse(event.data);
    console.log("Evento recibido:", data);
};
```

### MQTT

Para usar MQTT, DroidPad envía eventos a un tópico específico:

```
Tópico: droidpad/{pad_name}/{element_id}
Payload: {"type":"JOYSTICK","x":0.5,"y":-0.75}
```

### UDP

Eventos enviados como datagramas UDP:

```
Destino: {host}:{port}
Payload: {evento JSON}
```

Nota: UDP no garantiza entrega, ideal para datos de alta frecuencia donde la pérdida ocasional es aceptable.

---

## Preguntas Frecuentes

### P1: ¿Puedo usar diferentes protocolos simultáneamente?

**R:** No en una misma conexión de pad. Debes crear pads separados para cada protocolo.

```
Pad 1 (TCP) - Conectado a 192.168.1.100:8080
Pad 2 (WebSocket) - Conectado a 192.168.1.50:9000
Pad 3 (MQTT) - Conectado a broker.example.com:1883
```

### P2: ¿Qué tan frecuentes son los eventos?

**R:** Depende del tipo de control:
- **Joystick/Slider/Steering:** ~60 Hz (cada ~16ms) mientras se mueven
- **Button/DPAD/Switch:** Solo al cambiar estado
- **Accelerometer/Gyroscope:** 30-60 Hz según sensor

### P3: ¿La precisión es suficiente para juegos?

**R:** Sí. Los joysticks tienen precisión de float (6-8 decimales). Es comparable a controles físicos profesionales.

### P4: ¿Puedo modificar el QR después de generarlo?

**R:** El QR es estático - encadena datos específicos. Para cambiar la configuración, debes:
1. Generar un nuevo QR
2. O cargar la configuración vía archivo JSON

### P5: ¿Qué sucede si el servidor está offline cuando se escanea el QR?

**R:** DroidPad intentará conectar según el `timeout` especificado. Si falla:
- Reintentar automáticamente
- Mostrar error al usuario
- Permitir configuración manual

### P6: ¿Puedo usar localhost (127.0.0.1)?

**R:** **No.** El teléfono es un dispositivo diferente, localhost refiere a sí mismo. Usa:
- IP local de tu máquina (ej: 192.168.1.x)
- IP pública (si están en redes diferentes)
- Hostname con DNS resuelto

### P7: ¿El protocolo es seguro?

**R:** No tiene autenticación en los protocolos base. Para producción:
- Usa **wss://** (WebSocket seguro) en lugar de ws://
- Implementa verificación de token/API key
- Usa VPN o red privada
- No expongas puertos públicos directamente

### P8: ¿Puedo enviar comandos de vuelta al teléfono?

**R:** Depende del protocolo:
- **TCP/WebSocket:** Sí, es bidireccional. Envía JSON y DroidPad puede procesarlo
- **UDP:** No, es unidireccional (móvil → servidor)
- **MQTT:** Sí, usa tópicos de respuesta

---

## Referencias

- [GitHub: UmerCodez/DroidPad](https://github.com/UmerCodez/DroidPad)
- [QR Server API](https://qr-server.com/) - Generador QR gratis
- [Deep Linking](https://developer.android.com/training/app-links)
- Licencia: GPL-3.0
