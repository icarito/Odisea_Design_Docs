# FD-160: Searchlights & Tracker Props (Fire & Security Family)

## Overview
A family of animated searchlight and security props for Odisea's semi-exterior / large interior spaces. Based on the existing SciFiWorkLightV2 pattern — parameter-driven, tool-enabled, with exported variables for Godot 3.

## Design Goals
- **Searchlight**: A rotating/panning exterior light that sweeps left-right (and optionally up-down) for atmospheric lighting.
- **Tracker Light**: A light that follows a moving target (player) — used for security spotlights, guard drones, or stage lighting.
- **Security Camera**: A non-light prop in the same family that tracks the player by rotating its head, with a small red recording LED.
- Composable: a tracker light and a security camera share the same tracking logic base class.
- All props must work as decorations and as functional gameplay elements.

## Base Class: TrackerBase (extends PropBaseV2)

Shared rotation/tracking logic. Does not require a light — can be inherited by cameras, antennae, etc.

### Exported Variables (TrackerBase)

```
export(float) var rotation_speed := 30.0          # degrees per second
export(float) var pan_angle := 90.0                # half sweep (45 deg each side = 90 total)
export(float) var tilt_angle := 0.0                # vertical half sweep (0 = no tilt)
export(float) var initial_offset := 0.0            # degrees offset from forward
export(float) var home_angle := 0.0                # rest position when idle
export(bool) var track_player := false             # if true, follow player instead of sweep
export(float) var track_smooth := 5.0              # lerp speed when tracking
export(float) var detection_range := 30.0          # max distance to detect player
export(float) var detection_cone := 60.0           # field of view degrees
export(bool) var start_active := true
```

### Behavior
- When `track_player == false`: continuously sweep left-right within `pan_angle`, with optional `tilt_angle` vertical wobble.
- When `track_player == true`: idle sweep stops; head rotates to face player if within `detection_range` and `detection_cone`. Uses smooth lerp (`track_smooth`).
- When player exits range/cone: head returns to sweep pattern after configurable delay.
- All rotation on Y axis for pan, X axis for tilt.
- Head node name: "Head" (consistent with SciFiWorkLightV2 convention).

---

## Subclass A: SearchLightV2

Inherits TrackerBase + adds a SpotLight child. For exterior and large interior spaces.

### Exported Variables (SearchLight-specific)

```
export(float) var light_range := 40.0
export(float) var spot_angle := 60.0
export(Color) var light_color := Color(1.0, 0.95, 0.8)
export(float) var light_energy := 6.0
export(bool) var volumetric := false              # hint: enable volumetric fog cone (requires WorldEnvironment)
export(float) var light_energy_max := 8.0
export(float) var bulb_emission_energy := 4.0
export(Color) var albedo_color_on := Color(1.0, 1.0, 1.0)
export(Color) var albedo_color_off := Color(0.3, 0.3, 0.3)
export(bool) var enable_shadows := false
```

### Scene Structure
```
SearchLightV2 (Spatial)
  ├── Head (Spatial)             ← rotated by TrackerBase
  │   ├── SpotLight              ← main light
  │   └── Bulb (MeshInstance)    ← emissive bulb visual
  ├── Base (MeshInstance)        ← static base geometry
  └── Indicator (MeshInstance)   ← small LED (green/heartbeat)
```

### Behavior
- Light follows head rotation.
- When active: bulb glows, indicator is green.
- When inactive: bulb dim, indicator orange/red.
- All visual updates follow the same pattern as SciFiWorkLightV2._update_visuals().

---

## Subclass B: SecurityCameraV2

Inherits TrackerBase. No light — purely rotational tracking with recording indicator.

### Exported Variables (SecurityCamera-specific)

```
export(Color) var record_led_color := Color(1.0, 0.1, 0.1)   # red
export(float) var record_led_blink_speed := 1.5               # blinks per second
export(bool) var recording := true                             # starts recording by default
export(float) var record_led_energy := 3.0
```

### Scene Structure
```
SecurityCameraV2 (Spatial)
  ├── Head (Spatial)              ← rotated by TrackerBase
  │   ├── CameraBody (MeshInstance)
  │   └── Lens (MeshInstance)
  ├── Base (MeshInstance)
  ├── RecordLED (MeshInstance)    ← small red light that blinks
  └── MountArm (MeshInstance)     ← optional wall/ceiling bracket
```

### Behavior
- Head tracks player when `track_player == true`, sweeps otherwise.
- RecordLED blinks at `record_led_blink_speed` Hz when recording.
- When recording is false, LED stays solid dim red.
- No actual camera rendering — this is a decoration prop. The virtual camera system (FD-161) is separate.

---

## Integration Notes

### Dependencies
- Base class: PropBaseV2 (existing in core_v2)
- Light pattern: SciFiWorkLightV2.gd (existing)
- Godot version: 3.x (GDScript 1.x)

### Files to Create
```
core_v2/props/scifi_lights/TrackerBase.gd        — new
core_v2/props/scifi_lights/TrackerBase.tscn      — new
core_v2/props/scifi_lights/SearchLightV2.gd       — new
core_v2/props/scifi_lights/SearchLightV2.tscn     — new
core_v2/props/scifi_lights/SecurityCameraV2.gd    — new
core_v2/props/scifi_lights/SecurityCameraV2.tscn  — new
```

### Proposed Variants (optional, can be derived)
- SearchLightFloor: wall-mounted variant with tripod base
- SearchLightCeiling: ceiling drop-mount
- SecurityCameraWall: half-dome wall camera
- SecurityCameraCeiling: full-dome ceiling camera

### Testing
- Create TestSearchlights.tscn with one of each prop in a grey room
- Create test_trigger: Player mesh that moves through detection cone
- OYS test script to verify sweep cycle and tracking toggle
- **Important: you must have Godot 3 installed to run the test scene and visually inspect the props. Install instructions below.**

### Installing Godot 3
```
# Linux (extract to ~/godot):
wget https://downloads.tuxfamily.org/godotengine/3.5.3/Godot_v3.5.3-stable_x11.64.zip
unzip Godot_v3.5.3-stable_x11.64.zip -d ~/godot
sudo ln -s ~/godot/Godot_v3.5.3-stable_x11.64 /usr/local/bin/godot3

# macOS:
# Download from https://godotengine.org/download/3.x/macos/
# Unzip and copy to /Applications/Godot3.app

# Windows:
# Download from https://godotengine.org/download/3.x/windows/
```

Run tests:
```
godot3 --path /path/to/Odisea --script core_v2/tests/test_searchlight_sweep.gd
```
