# Technical Specification: Deterministic Interactable System (Odisea V2)

## Objective

Create a base framework for objects that toggle states (Open/Closed, On/Off, Active/Inactive) through player interaction.

The system must ensure 100% mathematical determinism for replay integrity, inspired by the state-logic of Cogito but optimized for Odisea's snapshot architecture.

## Core Architecture

### InteractableBaseV2.gd (Abstract Class)

Inherits from `KinematicBody` (preferred for floor velocity inheritance) or `Spatial`.

### State Variables

- `is_active: bool`: The logical state (`true = open/on`, `false = closed/off`).
- `anim_progress: float`: Normalized value (`0.0` to `1.0`) representing the current visual position.
- `target_progress: float`: The goal state (usually `1.0` or `0.0`).
- `anim_speed: float`: Progress increment per second (`1.0 / duration`).

### Core Methods

- `interact()`: Toggles `is_active` and sets `target_progress`.
- `step(dt)`: Calculated during the fixed physics step. Updates `anim_progress` towards `target_progress` and calls `_update_visuals()`.

## Implementation Types

### Sliding Door / Drawers (SlidingObjectV2)

Similar to `Cogito_Door.gd` but using relative translation.

- Logic: `translation = start_pos.linear_interpolate(start_pos + slide_vector, _ease(anim_progress))`.
- Generalization: Drawers are sliding objects with a restricted axis and specific sound triggers.

### Rotational Levers / Valves (RotatingObjectV2)

- Logic: Applies `lerp` to a specific axis of rotation.
- Reference: Mimics `Cogito_Switch.gd` mechanics for flipping states via angular displacement.

### Push Buttons / Consoles (ButtonV2)

- Logic: Combines a short Z-axis displacement with material emission changes.
- Feedback: `material.emission_energy = lerp(min_e, max_e, anim_progress)`.

## Replay and Determinism (The Odisea Contract)

Unlike Cogito's reliance on standard `AnimationPlayers` (which can drift if not synced to physics), Odisea objects calculate their state based on a `time_accumulator` or a fixed-step increment.

```gdscript
func get_snapshot() -> Dictionary:
    return {
        "active": is_active,
        "progress": anim_progress,
        "target": target_progress
    }
```
