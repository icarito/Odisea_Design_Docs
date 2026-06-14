# Spec: Interaction Marker System — Floating Tags & Off-Screen Indicators

## Architectural Concept

A screen-space overlay system that displays contextual information about interactable objects: name, action hint, key binding, and status. Designed for **narrative minimalism** — markers are a diegetic tool, not a HUD flood.

Three marker states controlled by a single `InteractionMarker` component:

1. **ON_SCREEN** — the object is in viewport and within range. Shows label + icon + key hint.
2. **OFF_SCREEN** — the object is outside viewport but within range. Shows a minimal arc/edge indicator pointing toward the object. No text, only direction.
3. **LOCKED** — the object is identified but cannot be interacted with (no power, locked, out of range). Shows icon + status text in muted color. Disappears if the object has never been seen/interacted with.

## Constraints

- Maximum **3 visible markers** at any time, enforced by priority.
- **No markers on lore objects** (data slates, ambient panels, decorative props) — those remain pure environmental storytelling.
- Markers appear only for interactables on the **critical path** or objects the player has already discovered and locked.
- Off-screen indicators are **one single arc stroke** per object — no text, no icon, just a thin directional hint at the screen edge.
- The system must integrate with `InteractionSensor.gd` (the existing Area-based sensor) — the marker follows the sensor's focus target.

## Component API: `InteractionMarker.gd`

### Location
`core_v2/Components/UI/InteractionMarker.gd`

### Singleton access (Autoload)
`InteractionMarker` — global registry and render manager.

### Public Methods

```gdscript
func register(interactable: Spatial, config: MarkerConfig) -> void
func unregister(interactable: Spatial) -> void
func update_config(interactable: Spatial, config: MarkerConfig) -> void
```

### `MarkerConfig` (Resource or Dictionary shape)

```gdscript
# MarkerConfig — passed at registration time
# Properties:
#   label: String                  # "Consola OD-02"
#   icon: Texture                  # Optional icon texture
#   hint: String                   # "E₀ — Usar"
#   locked_text: String            # "Sin energía" (shown when locked)
#   is_locked: Callable            # fun() -> bool, evaluated each frame
#   range: float                   # Max distance to show marker
#   off_screen: bool               # Allow off-screen indicator
#   priority: int                  # 0=critical, 3=lowest; lower = higher prio
#   screen_margin: float           # Edge margin for off-screen arc (px)
```

### Marker States (enum)

```gdscript
enum MarkerVisualState {
    HIDDEN,       # No marker at all
    ON_SCREEN,    # Full label + hint
    OFF_SCREEN,   # Edge arc only (direction)
    LOCKED        # Dimmed label + locked_text
}
```

### State Machine Logic (per frame)

```
if object is out of range or camera can't see it:
    if was_ever_seen and is_locked():
        → LOCKED (show locked_text, muted alpha)
    else:
        → HIDDEN
elif object is in viewport (unproject_position inside rect):
    → ON_SCREEN (full label + hint + icon)
elif off_screen is enabled:
    → OFF_SCREEN (only arc indicator on edge)
```

### Priority Culling

Each frame, collect all objects in non-HIDDEN state. Sort by priority. If > 3, keep only the 3 highest priority. If tie, keep closest to camera center.

## Off-Screen Indicator Design

- Rendered on same `CanvasLayer` as the on-screen markers.
- Each indicator is a **thin arc segment** (12 px stroke, 24 px radius) at the screen edge pointing toward the object's world position.
- Color: same accent as the object's on-screen marker, but at 40% alpha.
- No text, no icon.
- The arc fades out smoothly over 0.5s when the object enters ON_SCREEN state.

## Integration with Existing Systems

### InteractionSensor.gd
`InteractionMarker` subscribes to `InteractionSensor.focus_changed`. When the sensor changes focus, the marker system animates the hint transition.

### InteractableEntity.gd
Each `InteractableEntity` can optionally hold a `MarkerConfig` resource. If present, `InteractionMarker.register()` is called in `_ready()`. If absent, no marker is spawned for that entity.

```gdscript
# InteractableEntity.gd (extension)
var marker_config: MarkerConfig = null  # optional
```

### HUD Layer
- `CanvasLayer` at layer 2 (above gameplay, below pause/overlay).
- A single `Control` node as root of all markers.
- Markers are recycled `Panel` instances with `Label` and `TextureRect` children.

## Performance Budget

- Max 3 active markers, max 9 registered objects.
- `unproject_position` called only for registered objects within range, once per frame.
- Off-screen arc: 3 draw calls max (one per indicator).
- No floating-point heavy operations per frame (no string concatenation per frame — cache formatted strings).
- Total GPU draw calls for the system: **≤ 6** (3 markers × 2 layers each).

## Edge Cases

1. **Object behind the player**: off-screen arc points backward through the camera's right/up vectors, clamped to edge.
2. **Rapid focus change**: debounce 150ms in `InteractionMarker` before switching hint text, to avoid flickering when the player looks past a row of objects.
3. **Two objects at same screen position (overlap)**: higher priority one wins; lower one is hidden regardless of state.
4. **Locked + newly discovered**: object stays LOCKED if `is_locked()` returns true AND the player has previously looked at it (tracked via a `seen_set` hash set per session). If never seen, it's HIDDEN even if locked — no spoilers.

## Implementation Notes

- `seen_set` is a `Dictionary` keyed by `InteractableEntity.get_instance_id()`.
- Marker text formatting: `"[icon] {label} — {hint}"` for ON_SCREEN. `"[icon] 🔒 {label} — {locked_text}"` for LOCKED.
- Font: use the game's UI font (currently `res://assets/fonts/odisea_ui.tres`). Size 14 for label, 12 for hint.
- Key bindings should be read from `InputMap` at scene start, not hardcoded.

## Files Changed

| File | Action |
|------|--------|
| `core_v2/Components/UI/InteractionMarker.gd` | Create |
| `core_v2/Components/UI/InteractionMarker.tscn` | Create |
| `core_v2/Components/Shared/InteractableEntity.gd` | Modify (add `marker_config` property) |
| `core_v2/Components/Player/InteractionSensor.gd` | Verify `focus_changed` signal compatibility |
| `project.godot` | Add `InteractionMarker` autoload |

## Future (Out of Scope — Backlog)
- Animation on marker appearance (scale-in, fade).
- Voice-over style "narrator" names for markers (Odisea IA reading the label aloud).
- Player preference to disable markers entirely.
