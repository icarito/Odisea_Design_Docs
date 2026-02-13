# Spec: Unified Interaction Framework (UIF) - Sensor-Based - Odisea Core_v2

## Architectural Concept

The interaction system shifts from a precise RayCast ("pixel hunting") to a volume-based detection (sensor). The player projects an invisible volume (box/cone) forward. Any `InteractableEntity` within this volume becomes a candidate.

The system evaluates candidates each frame to determine the best focus target based on proximity and angle. This unifies interaction logic for static objects (terminals) and dynamic objects (moving platforms, pushable boxes), ensuring all gameplay elements respect the deterministic `step(dt)` cycle.

## Component Architecture

### The Sensor (`InteractionSensor.gd`)

- Location: `core_v2/Components/Player/InteractionSensor.gd`
- Node: `Area` (child of `PlayerControllerV2`)
- Responsibilities:
- Candidate tracking: maintain a list of overlapping interactable objects.
- Evaluation loop (`step`): in every `step(dt)`, calculate a score for each candidate.
- Angle: dot product with camera forward vector (center is better).
- Distance: closer is better.
- Line of sight: internal RayCast check to prevent interaction through walls.
- Focus management: emit signals when the best candidate changes.

### The Interactable (`InteractableEntity.gd`)

- Location: `core_v2/Components/Shared/InteractableEntity.gd`
- Inheritance: base class for all interactive objects.
- Core data:
- `interaction_text: String` (`"Open"`, `"Push"`, `"Activate"`).
- `interaction_point: Position3D` (optional center for LoS checks).
- `requirements: AttributeResource` (e.g. `"Strength > 5"`).

## Integration with Existing Features ("The Zoo")

The goal is to refactor current prototypes (`MovingPlatform`, `Conveyor`, `Drawer`) into this unified system.

### Moving Platforms (`MovingPlatformV2`)

- Current status: deterministic `KinematicBody` with `time_accumulator`.
- UIF integration: add an `InteractableEntity` child node if the platform has a control panel (e.g. an elevator button). The button is the interactable, not the platform itself.

### Conveyor Belts (`Conveyor`)

- Current status: physics area applying force.
- UIF integration: generally passive. However, a conveyor switch object would be an `InteractableEntity` that toggles `Conveyor.active` deterministically.

### Pushable Boxes (`PushableBoxV2`)

- Current status: hybrid rigid/kinematic body.
