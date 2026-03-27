# DroidPad Dynamic QR Control Feature Specification (Godot 3.6.2)

Tracking: https://github.com/icarito/Odisea/issues/10

## 1. Executive Summary

This specification details the implementation of a **Dynamic QR Code Generation and Display** feature in Godot Engine 3.6.2 for the *Odisea: El Arca Silenciosa* project. The feature enables seamless, zero-configuration wireless connection between the Godot host application and the DroidPad mobile client. A QR code is dynamically generated containing the host's local LAN IP, configurable port, and preferred protocol (UDP default), rendered on a `CanvasLayer` for mobile scanning.[^2]

## 2. Technical Requirements

### 2.1 Environment and Components

- **Engine**: Godot 3.6.2 using GDScript
- **Networking**: `StreamPeerTCP`, `UDPServer`, `WebSocketServer`
- **Display**: `CanvasLayer` with `TextureRect` node
- **QR Generation**: Local Godot QR addon (no external APIs for production reliability)[^2]


### 2.2 QR Code Data Format

Generate a DroidPad-compatible **Deep Link URL**:

```
droidpad://import/config?pad={PAD_NAME}&protocol={PROTOCOL}&host={LOCAL_IP}&port={PORT}
```

| Parameter | Source | Notes |
| :-- | :-- | :-- |
| `pad` | User-defined string | Gamepad identifier (e.g., "odisea_controller") |
| `protocol` | UDP (default), TCP, WebSocket | See Section 3 for selection logic |
| `host` | Local LAN IPv4 | Auto-detected (non-loopback) |
| `port` | Configurable | Server listening port |

### 2.3 Dynamic LAN IP Detection

Automatically detect the host machine's LAN IPv4 address:

```gdscript
func get_local_lan_ip() -> String:
    var ip_addresses = IP.get_local_addresses()
    for addr in ip_addresses:
        if addr.find(".") != -1 and not addr.begins_with("127.") and not addr.begins_with("169.254."):
            return addr
    return "127.0.0.1"  # Fallback for same-device testing
```


### 2.4 QR Generation and Display

- Generate QR texture locally using Godot QR addon
- Assign to `TextureRect.texture` in `CanvasLayer`
- Scale to minimum 300x300px for reliable mobile scanning[^2]


## 3. Protocol Selection

Prioritize **UDP** for low-latency, unidirectional control inputs suitable for *Odisea*'s precise platforming mechanics.


| Use Case | Protocol | Rationale |
| :-- | :-- | :-- |
| Default (Joysticks, Buttons, Accelerometer) | UDP | Lowest latency for high-frequency events |
| Bidirectional (Gauges, Haptics) | TCP/WebSocket | Guaranteed delivery, server→client updates |

**Server-to-Client Example (TCP/WebSocket)**:

```json
{
  "command": "UPDATE",
  "id": "fuel_gauge",
  "value": 0.45,
  "meta": "low"
}
```


## 4. Implementation Flow

1. **Initialize**: Start server listener on configured port/protocol
2. **Detect IP**: Call `get_local_lan_ip()`
3. **Build URL**: Construct Deep Link with IP, port, protocol, pad name
4. **Generate QR**: Create texture via local QR addon
5. **Display**: Update `TextureRect` on `CanvasLayer`

## 5. DroidPad Event Format

Events received from DroidPad follow standard JSON structure across all protocols:

**Joystick (Continuous)**:

```json
{
  "id": "left_stick",
  "type": "JOYSTICK",
  "x": 0.5,
  "y": -0.75
}
```

**Supported Types**: BUTTON, DPAD, JOYSTICK, SLIDER, SWITCH, STEERING_WHEEL, ACCELEROMETER, GYROSCOPE

## 6. Odisea Integration Notes

- **Primary Use**: Mobile control for *Odisea*'s precise 3D platforming (Elas controller, gravity manipulation)
- **Protocol**: UDP preferred for responsiveness during zero-gravity navigation and vehicle sections
- **UI Integration**: Display QR in configuration/menu scene with connection status indicator
- **Regeneration**: Support QR refresh if network changes occur
- **Testing**: Validate with *Odisea*'s variable gravity mechanics requiring precise analog input[^2]


## 7. Dependencies and Setup

1. Install Godot QR Code addon from Asset Library
2. Create `CanvasLayer` → `TextureRect` scene structure
3. Configure default port (e.g., 8080) and pad name in Project Settings
4. Enable network permissions for target platforms

***

[^1]: odisea_wiki.json

[^2]: https://docs.godotengine.org/en/3.6/about/list_of_features.html

[^3]: https://godotengine.org/article/dev-snapshot-godot-3-6-beta-2/

[^4]: https://docs.godotengine.org/en/latest/about/list_of_features.html

[^5]: https://godotengine.org/article/godot-3-6-finally-released/

[^6]: https://godotengine.org/article/maintenance-release-godot-3-6-2/

[^7]: https://github.com/MechanicalFlower/godot-template

[^8]: https://godotengine.org/download/archive/3.6.2-stable/

[^9]: https://www.reddit.com/r/godot/comments/1leic7t/building_godot_36_custom_export_template_for_web/

[^10]: https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_documentation_comments.html

[^11]: https://github.com/godotengine/godot-docs

[^12]: https://arxiv.org/pdf/1602.01876.pdf

[^13]: https://arxiv.org/ftp/arxiv/papers/2401/2401.17599.pdf

[^14]: https://arxiv.org/pdf/2502.05913.pdf

[^15]: https://arxiv.org/pdf/2101.07902.pdf

[^16]: https://arxiv.org/pdf/2111.01974.pdf

[^17]: https://arxiv.org/pdf/2306.14824.pdf

[^18]: https://arxiv.org/html/2412.18408v1

[^19]: http://arxiv.org/pdf/2303.13041.pdf
