# FD-161: OdiseaOS Surveillance Camera App

## Overview
A full-screen application for the OdiseaOS retro interface that lets the player select and view feeds from virtual cameras placed throughout the ship. The app shows a live rendering of the scene from a selected virtual camera's point of view.

## Dependencies
- OdiseaOS UI framework (OysCalc.gd pattern: VBoxContainer with RetroOS theme)
- VCameraSystem (existing in core_v2/camera/VCameraSystemRig.gd)
- Virtual cameras placed by level designers (VCameraSystem.tscn nodes)

## Design

### App: OysCameras

Extends the same VBoxContainer-based pattern as OysCalc. Acts as a Viewport-based camera switcher.

### Behavior
1. App detects all VCameraSystemRig instances in the current scene.
2. Lists each virtual camera in a scrollable menu (by camera node name).
3. Player clicks/taps a camera name → a Viewport renders the scene from that camera's perspective.
4. The Viewport replaces the main game view while the app is open (split or overlay).
5. Player can press ESC or a Back button to return to the game.
6. Each camera entry shows:
   - Camera name (from node name)
   - A small indicator if the camera has a SecurityCameraV2 nearby (recording status)
   - Optional: a small thumbnail feed (performance heavy — defer to V2)

### Scene States
- **Closed**: app not open, game renders normally.
- **Open (Browse)**: app overlay appears on top of game. Player sees camera list. Selecting a camera opens preview.
- **Open (Preview)**: Viewport renders from selected camera. Player sees live feed. Back button returns to browse.

### Visual Style
- Same retro green-terminal theme as OysCalc (RetroOS.tres)
- Camera list: labeled buttons in a ScrollContainer
- Preview area: a ColorRect with a ViewportContainer child
- Status bar at bottom: "OD-OS v4.21 | SURVEILLANCE | CAM: <name>"

### Technical Implementation

#### App Script Structure

```
extends VBoxContainer
class_name OysCameras

```

#### Exported Variables
```
export(float) var preview_width := 480
export(float) var preview_height := 360
export(bool) var show_framerate := false
export(float) var camera_switch_time := 0.3          # transition duration
```

#### Viewport Setup

- Create a Viewport node at runtime (not in scene — add via script).
- Set `size = Vector2(preview_width, preview_height)`.
- Set `transparent_bg = false`, `render_target_v_flip = true`.
- Assign the selected virtual camera as the Viewport's camera (via `viewport.add_child(cam)` or `viewport.camera = cam`).
- Wrap Viewport in a ViewportContainer for display in the UI.
- Cleanup: when switching cameras or closing, remove the previous camera from the Viewport.

The Viewport renders the scene in real time from the virtual camera's perspective. This is a live feed — the game world continues to run. The player's character may or may not be visible depending on camera placement.

#### Camera Detection

```gdscript
# Find all VCameraSystemRig instances
var camera_rigs = get_tree().get_nodes_in_group("vcamera_system")
# Fallback: scan root scene for VCameraSystemRig
if camera_rigs.empty():
    for child in get_tree().root.get_children():
        if child is VCameraSystemRig:
            camera_rigs.append(child)
```

For each VCameraSystemRig, enumerate its `$VCameras` children and treat each as a selectable camera.

#### Input Handling

- Mouse clicks on camera list items trigger camera selection.
- `Input.is_action_just_pressed("ui_cancel")` closes the app.
- While app is open, player movement input is paused (controller manager switches to UI mode).

#### SecurityCameraV2 Integration

- Check if any SecurityCameraV2 prop is near the selected virtual camera (within 5 units).
- If so, display the camera's recording status indicator in the list.
- Status: "● REC" (blinking red) when recording, "○ OFF" when not.

## Files to Create

```
core_v2/ui/retro/OysCameras.gd       — main app script
core_v2/ui/retro/OysCameras.tscn     — app scene (VBoxContainer)
core_v2/ui/retro/OysCamerasTest.tscn — test scene with a VCameraSystem + one camera
```

## Testing

- Create a test scene with a VCameraSystemRig containing 2-3 virtual cameras placed at different angles.
- Create a simple test floor (grey box room) with a few props for visual reference.
- Instance OysCameras in the scene.
- Run the scene in Godot 3.
- Verify: camera list populates, clicking a camera shows the preview, back button returns to list.
- **Important: you must have Godot 3 installed to run the test scene and visually inspect the viewport renders. Install instructions below.**

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

## Integration

This app can be launched from any OdiseaOS Terminal (TableTerminal or similar) via an Oys function call:
```
call_oys_app("OysCameras")
```

Pattern: same as OysCalc — terminal instantiates the `.tscn` as a child of the terminal's screen node, then removes it on close.

## Performance Notes

- Each Viewport adds a render pass. For the MVP, assume 1 active preview at a time (no multi-view).
- On low-end hardware: reduce `preview_width/height` to 320x240.
- Future: thumbnail mode using `$Camera.target` snapshots instead of live Viewport.
