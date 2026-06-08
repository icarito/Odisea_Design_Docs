# FD-162: Odisea Bridge — Peer de Telemetría y Observabilidad

## Resumen
Un proceso peer (Python o nativo Godot) que conecta el runtime del juego con el gateway de OpenClaw vía WebSocket, permitiendo observar sesiones de juego en vivo, recolectar datos de replay, y habilitar interacción asíncrona entre jugadores (ghosts).

## Motivación
- Centralizar la observabilidad de todas las sesiones de juego (desktop y HTML5) en un solo punto.
- Permitir que agentes de IA consulten el estado del jugador sin needing MCP (`web_fetch("http://peer:5001/status")`).
- Almacenar "ghosts" — secuencias de posiciones/rotaciones de sesiones anteriores — y reproducirlas en el juego como figuras semitransparentes.
- Habilitar interacción asíncrona: dejar mensajes en ubicaciones, ver el paso de otros jugadores.

## Arquitectura

```
                    ┌─────────────────────────┐
                    │   Gateway OpenClaw      │
                    │  (WS server central)    │
                    │  - Recibe heartbeats    │
                    │  - Cachea estados       │
                    │  - Almacena ghosts      │
                    │  - HTTP /status para    │
                    │    agentes              │
                    └──────────┬──────────────┘
                               │ WebSocket
                    ┌──────────▼──────────────┐
                    │   Peer Bridge (Python)   │
                    │  - WS client → Gateway   │
                    │  - WS server :5001       │
                    │  - HTTP :5001/status     │
                    │  - Conecta a ANNA MCP    │
                    │    (si está disponible)  │
                    └──────────┬──────────────┘
                               │ ANNA TCP :5000
                    ┌──────────▼──────────────┐
                    │  Godot Runtime           │
                    │  (desktop o HTML5)       │
                    │  - ANNA MCP endpoint     │
                    │  - (o WebSocket nativo   │
                    │    en HTML5)             │
                    └─────────────────────────┘
```

### Flujo de datos (heartbeat)

Cada ~100ms, el peer consulta el estado del player vía ANNA MCP (o recibe push desde Godot) y envía al Gateway:

```json
{
  "type": "heartbeat",
  "session_id": "uuid-de-la-sesion",
  "player": {
    "position": [12.5, 1.2, -3.8],
    "velocity": [0.1, 0.0, 0.0],
    "yaw": 1.57,
    "pitch": -0.1,
    "roll": 0.0
  },
  "mode": "standard",
  "scene": "Dome_Crio",
  "zone": "criogenia",
  "timestamp": 1717800000.123
}
```

### Ghosts

El gateway almacena secuencias de heartbeats como "ghosts". Cada ghost es un array de posiciones/rotaciones con timestamp relativo. Un jugador puede descargar ghosts cercanos y renderizarlos como figuras semitransparentes en su mundo.

Formato de ghost almacenado:

```json
{
  "ghost_id": "ghost-uuid",
  "session_id": "session-origen",
  "scene": "Dome_Crio",
  "frames": [
    {"t": 0.0, "pos": [0, 0, 0], "yaw": 0.0, "pitch": 0.0, "roll": 0.0},
    {"t": 0.1, "pos": [0.5, 0, 0], "yaw": 0.1, "pitch": 0.0, "roll": 0.0},
    ...
  ]
}
```

## Componentes

### 1. Peer Bridge (Python)

Ubicación sugerida: `core_v2/bridge/odisea_peer.py`

Responsabilidades:
- Conectarse a ANNA MCP (si el runtime lo expone)
- Loop de heartbeat cada 100ms
- Servir HTTP en `:5001` con endpoint `/status`
- Servir WebSocket en `:5001` para conexión directa desde agentes
- Conectarse como WS client al gateway de OpenClaw (URL configurable)
- Escuchar comandos remotos desde el gateway y ejecutarlos vía MCP

Dependencias: `websockets`, `aiohttp` (o `asyncio` puro).

### 2. Gateway Skill (OpenClaw)

Un skill que:
- Mantiene una conexión WebSocket con cada peer activo
- Cachea el último heartbeat de cada sesión en memoria
- Expone endpoint HTTP `/odisea-bridge/status` para consulta de agentes
- Almacena ghosts en disco (archivos JSON secuenciales)
- Reenvía ghosts a peers que los soliciten

### 3. Godot Integration (opcional, post-MVP)

Un autoload `OdiseaBridge.gd` que:
- Envía heartbeats directamente vía WebSocket si no hay peer Python
- Recibe ghosts y los renderiza como figuras semitransparentes
- Recibe comandos remotos (set_position, ejecutar OYS, etc.)

## Endpoints

### Peer HTTP

| Endpoint | Método | Respuesta |
|----------|--------|-----------|
| `/status` | GET | Último heartbeat completo |
| `/command` | POST | Ejecuta comando en Godot vía MCP |
| `/ghosts?scene=Dome_Crio` | GET | Lista de ghosts disponibles para esa escena |

### Gateway HTTP (para agentes)

| Endpoint | Método | Respuesta |
|----------|--------|-----------|
| `/odisea-bridge/status` | GET | Heartbeat más reciente de cada sesión activa |
| `/odisea-bridge/sessions` | GET | Lista de sesiones activas e históricas |

## Protocolo WebSocket

### Cliente → Gateway

| Tipo | Descripción |
|------|-------------|
| `heartbeat` | Estado actual del player (cada 100ms) |
| `ghost_upload` | Subir una secuencia de frames como ghost |
| `command_response` | Resultado de un comando ejecutado |

### Gateway → Cliente

| Tipo | Descripción |
|------|-------------|
| `command` | Ejecutar una acción en el runtime |
| `ghost_delivery` | Enviar un ghost solicitado |
| `broadcast` | Mensaje de otro jugador (interacción asíncrona) |

## Casos de uso inmediatos

1. **Agente consulta posición del player:** `web_fetch("http://localhost:5001/status")` → sabe dónde está, qué escena, qué modo.
2. **Detectar regresiones:** Un agente monitorea que el heartbeat se actualice cada ~200ms. Si deja de llegar, el juego se colgó.
3. **Replay centralizado:** Todos los replays de todas las sesiones se almacenan en el gateway, accesibles para debugging.
4. **Ghosts de desarrollo:** El desarrollador juega un nivel, sus ghosts quedan registrados. Otro desarrollador (o Jules) puede ver dónde caminó y entender el flujo de diseño.

## Implementación MVP

Fase 1 — Peer Python (hoy):
- Script que conecta ANNA MCP, hace heartbeat loop, sirve HTTP/WS en :5001
- Se conecta al gateway de OpenClaw
- Gateway skill mínimo que recibe y cachea heartbeats

Fase 2 — Agentes consultan:
- El gateway expone `/odisea-bridge/status`
- Odiseo (y otros agentes) pueden preguntar "status del player" sin MCP

Fase 3 — Ghosts:
- Gateway almacena secuencias como archivos JSON
- Endpoint para listar y descargar ghosts
- (Post-MVP) Godot renderiza ghosts como figuras semitransparentes

Fase 4 — Interacción asíncrona:
- Dejar mensajes en ubicaciones del mundo
- Ver ghosts de otros jugadores en tiempo real
- (Post-MVP) Intercambio de items entre sesiones
