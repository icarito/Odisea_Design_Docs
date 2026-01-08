# 🎮 DroidPad Dynamic QR Control Feature Specification (Godot 3.6.2)

---

## 1. Executive Summary

This specification outlines the requirements for implementing a **Dynamic QR Code Generation and Display** feature within the Godot Engine (v3.6.2). The goal is to provide a seamless, zero-configuration connection method for the DroidPad mobile client. The feature must dynamically generate a connection configuration, embed it into a QR code, and render it on a $\text{CanvasLayer}$. The connection data **must automatically use the host machine's local network IP address** and prioritize the **UDP** protocol.

---

## 2. Technical Requirements: Dynamic QR Generation

### 2.1. Environment and Components

- **Engine:** Godot Engine v3.6.2 (GDScript)
    
- **Networking:** $\text{StreamPeerTCP}$, $\text{UDPServer}$, $\text{WebSocketServer}$.
    
- **Display:** $\text{CanvasLayer}$ and $\text{TextureRect}$.
    
- **QR Generation:** Local Godot Addon (preferred over external API for production).
    

### 2.2. Configuration Data Source

The QR code must encode the connection parameters using the recommended **Deep Link URL format**:

```
droidpad://import/config?pad=my_gamepad&protocol={PROTOCOL}&host={LOCAL_IP}&port={PORT}
```

|**Parameter**|**Value Source**|**Notes**|
|---|---|---|
|`protocol`|**UDP** (Default) or **TCP** / **WEBSOCKET**|See Section 3 for protocol selection logic.|
|`host`|**Local IP Address**|Automatically retrieved LAN IPv4 address (excluding loopback).|
|`port`|**Configurable/Dynamic**|The port the Godot server is listening on.|
|`pad`|**Configurable String**|User-defined identifier for the controller.|

### 2.3. Dynamic Local IP Address Acquisition

The application must dynamically identify and use the host machine's non-loopback Local Area Network (LAN) IPv4 address.

- **Method:** Use the Godot $\text{IP.get\_local\_addresses()}$ function.
    
- **Selection Logic:** Iterate through the list and return the first address that meets these criteria:
    
    1. Contains a period (`.`) (to ensure IPv4 preference).
        
    2. Does not start with `127.` (excludes loopback).
        
    3. Does not start with `169.254.` (excludes link-local addresses).
        

#### Godot 3.x Implementation Snippet (Conceptual)

GDScript

```
func get_local_lan_ip() -> String:
    var ip_addresses = IP.get_local_addresses()
    for addr in ip_addresses:
        if addr.find(".") != -1 and not addr.begins_with("127.") and not addr.begins_with("169.254."):
            return addr
    return "127.0.0.1" # Fallback (will only work if both are on the same device)
```

### 2.4. QR Code Generation and Display

The QR code generation must be handled **locally** using a Godot 3.x Addon.

- The generated QR image must be assigned as a $\text{Texture}$ to a $\text{TextureRect}$ node placed within a $\text{CanvasLayer}$.
    
- The size of the QR code must be dynamically scaled to ensure scannability (e.g., a minimum $300\text{x}300$ resolution).
    

---

## 3. Communication Protocol Selection

### 3.1. Protocol Preference

The primary criterion for protocol selection is the requirement for **bidirectional data flow** (server-to-client communication).

|**Use Case**|**Protocol**|**Rationale**|
|---|---|---|
|**Default Control (One-Way)**|**UDP (Preferred)**|Lowest latency, high-frequency, fire-and-forget control events (Joysticks, Accelerometers, Buttons).|
|**Indicators/Gauges (Two-Way)**|**TCP or WebSocket**|Required if the Godot server needs to send data back to the DroidPad client (e.g., updating a speedometer gauge, activating haptic feedback). Guarantees delivery and ensures a persistent, bidirectional channel.|

### 3.2. Bidirectional Protocol Options in Godot 3.6.2

If bidirectionality is required, the developer can choose between $\text{TCP}$ and $\text{WebSocket}$ protocols, as both are natively supported by Godot 3.6.2 and are easily accessible on mobile devices.

#### TCP/WebSocket Bidirectional Flow

1. **Client (DroidPad) $\rightarrow$ Server (Godot):** Sends control events (JSON per line/frame).
    
2. **Server (Godot) $\rightarrow$ Client (DroidPad):** Sends command updates (JSON) to control visual elements or haptics on the client.
    

#### Example Server-to-Client Command (TCP/WebSocket)

JSON

```
{
  "command": "UPDATE",
  "id": "fuel_gauge",
  "value": 0.45,
  "meta": "low"
}
```

---

## 4. Feature Flow Diagram

The Godot application will follow this automated sequence upon loading the QR screen:

1. **Initialize Server:** Godot starts listening on the defined port using the selected protocol ($\text{UDP}$ or $\text{TCP/WebSocket}$).
    
2. **Acquire IP:** The script runs $\text{get\_local\_lan\_ip()}$.
    
3. **Format Link:** The Deep Link URL is constructed using the local IP, port, and selected protocol.
    
4. **Generate QR:** The local QR addon generates the $\text{Texture}$ from the URL string.
    
5. **Display:** The $\text{TextureRect}$ is updated on the $\text{CanvasLayer}$, making the QR visible for scanning.
    

---

## 5. DroidPad Event Mapping

The structure for real-time events received from DroidPad remains consistent, regardless of the transport protocol (UDP or TCP/WebSocket), as defined in the original specification (JSON format).

**Example Received Event (Joystick - Continuous):**

JSON

```
{
  "id": "left_stick",
  "type": "JOYSTICK",
  "x": 0.5,
  "y": -0.75
}
```