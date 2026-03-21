# Spec: Upload Automático de Replays desde Demo

## Objetivo

Cuando un playtester juega la demo, el sistema captura automáticamente su sesión como un replay JSON (ya generado por Core V2) y lo sube a un servidor para análisis posterior. Sin fricción para el jugador — ocurre en background al terminar la sesión.

---

## Arquitectura

```
[Godot 3 — HTML5 export]
        │
        │  al finalizar sesión (muerte, salida, o fin de nivel)
        ▼
[ReplayUploader.gd]  ──► HTTP POST ──► [Endpoint de colección]
        │                                       │
        │                                       ▼
        │                              [Google Sheets / Supabase / archivo]
        │
        └── muestra prompt al jugador: "¿Subir tu sesión para ayudar al desarrollo?"
```

---

## Componentes

### 1. `ReplayUploader.gd` (Godot 3 — Autoload)

Responsabilidades:
- Al finalizar una sesión de juego, serializar el buffer de replay activo a JSON
- Mostrar un diálogo opcional al jugador: "Tu sesión puede ayudar al desarrollo. ¿Enviar replay?"
- Si acepta (o si `auto_upload = true` en config), hacer HTTP POST al endpoint
- Adjuntar metadata: timestamp, versión del build, duración, nivel jugado, plataforma

```gdscript
# core_v2/Components/ReplayUploader.gd
extends Node

const UPLOAD_URL = "https://api.odisea-game.com/replays"  # o endpoint temporal
const AUTO_UPLOAD = false  # true para demo sin prompt

func upload_replay(replay_data: Dictionary) -> void:
    var payload = {
        "version": ProjectSettings.get_setting("application/config/version"),
        "timestamp": OS.get_unix_time(),
        "level": replay_data.get("level", "unknown"),
        "duration_seconds": replay_data.get("duration", 0),
        "platform": OS.get_name(),
        "inputs": replay_data.get("inputs", []),
        "snapshots": replay_data.get("snapshots", [])
    }
    var http = HTTPRequest.new()
    add_child(http)
    http.connect("request_completed", self, "_on_upload_done", [http])
    var headers = ["Content-Type: application/json"]
    http.request(UPLOAD_URL, headers, true, HTTPClient.METHOD_POST,
                 JSON.print(payload))

func _on_upload_done(result, code, headers, body, http):
    http.queue_free()
    if code == 200 or code == 201:
        print("[ReplayUploader] Replay subido OK")
    else:
        print("[ReplayUploader] Error al subir replay: ", code)
```

### 2. Endpoint de colección

**Opción A — Sin backend propio (MVP):**
- [Pipedream](https://pipedream.com) o [n8n](https://n8n.io) como webhook receptor
- Recibe el JSON POST y lo escribe en Google Sheets o un bucket S3/R2
- Setup en ~30 minutos, gratis para volumen bajo

**Opción B — Backend propio (producción):**
- Supabase (PostgreSQL + API REST gratuita)
- Tabla `replays`: `id`, `version`, `timestamp`, `level`, `duration`, `platform`, `inputs_json`
- Permite queries: "¿cuánto tarda el jugador promedio en la Sala 1?", "¿dónde se atora más gente?"

**Recomendación MVP:** Pipedream → Google Sheets. Cero servidores, datos legibles directo.

### 3. Prompt en UI (opcional)

Si `AUTO_UPLOAD = false`, mostrar un diálogo simple al final de la sesión:

```
┌────────────────────────────────────────┐
│  ¿Ayudar al desarrollo de Odisea?      │
│                                        │
│  Tu sesión de juego puede enviarse      │
│  anónimamente para mejorar el juego.   │
│                                        │
│  [Enviar sesión]  [No, gracias]        │
└────────────────────────────────────────┘
```

---

## Datos capturados por replay

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `version` | string | Build del juego (ej: `0.3.1-alpha`) |
| `timestamp` | int | Unix time al iniciar la sesión |
| `level` | string | Nombre del nivel/escena jugado |
| `duration_seconds` | float | Duración total de la sesión |
| `platform` | string | `HTML5`, `Windows`, `Linux` |
| `inputs` | array | Buffer de inputs del Core V2 |
| `snapshots` | array | Snapshots de estado del motor (para replay determinista) |

---

## Métricas de playtesting derivables

Con los replays se pueden responder automáticamente:

- **Tiempo hasta el primer interactable** — ¿cuánto tarda en encontrar la terminal?
- **Número de veces que intenta abrir la puerta sin hackear** — mide confusión
- **Posición de muerte/abandono** — heatmap de dónde se pierden
- **Duración por sala** — comparar con targets del DIT
- **Tasa de completado** — % de jugadores que llegan al final del nivel

---

## Plan de implementación (MVP)

| Paso | Tarea | Estimado |
|------|-------|----------|
| 1 | Crear `ReplayUploader.gd` con HTTP POST | 2h |
| 2 | Configurar webhook Pipedream → Google Sheets | 30 min |
| 3 | Integrar `ReplayUploader` en la escena principal del nivel demo | 1h |
| 4 | Probar con export HTML5 en local | 1h |
| 5 | Actualizar `PlaySection.tsx` del sitio con info de replay anónimo | 30 min |

**Total estimado: ~5 horas de implementación**

---

## Consideraciones CORS para HTML5

El export HTML5 de Godot hace requests desde el browser — el endpoint debe tener headers CORS correctos:

```
Access-Control-Allow-Origin: *
Access-Control-Allow-Methods: POST
Access-Control-Allow-Headers: Content-Type
```

Pipedream y Supabase los tienen por defecto. Si usas un servidor propio, agregar estos headers es obligatorio.

---

## Próximos pasos

1. Decidir endpoint: **Pipedream** (rápido, gratis) o **Supabase** (más control)
2. Crear `ReplayUploader.gd` en el repo de código
3. Definir si el upload es automático o con prompt
4. Vincular con el cuestionario de playtesting del sitio web (mismo email/sesión)
