# Feature Specification: 2.5D Side-Scroller Mode Transition

## Overview and Strategic Goals

This document specifies a seamless, automatic transition system between standard 3D third-person exploration and constrained 2.5D side-scrolling mode.

Implementation must strictly follow the deterministic pure-input replay architecture. Every new state variable introduced by this system must be integrated into snapshot and replay state.

Primary goals:

| Goal | Key Success Metric |
| --- | --- |
| Fluid Gameplay Transition | Controls and camera transition feel intuitive and polished, not jarring. |
| Deterministic Purity | Replays including 2.5D sections diverge less than `0.0001` units. |
| Design Flexibility | Designers can place/configure `SideScrollTransitionZone` instances quickly. |

## Core System Architecture and Data Flow

This section defines high-level interactions between `PlayerControllerV2`, `ReplayManager`, and new transition components.

Event flow when entering `SideScrollTransitionZone`:

1. Detection: `Area3D` detects `body_entered`.
2. State update: the zone signals `ReplayManager`, including the 2.5D plane `Transform`.
3. Controller constraint: `PlayerControllerV2.step()` detects `is_in_25d_mode`, ignores depth input, and constrains physics to plane.
4. Camera transition: `PlayerSpringCam` computes side-scroller target transform and interpolates from current 3D pose.
5. Snapshot integration: session snapshot stores `is_in_25d_mode`, `camera_transition_alpha`, `active_2d_plane_transform`.

This event-driven approach preserves determinism and avoids state-based puppeteering anti-patterns.

## Component Implementation Details

### SideScrollTransitionZone

Reusable Godot scene used by level designers to define side-scrolling boundaries.

- Node type: standalone scene with root `Area3D`.
- Configuration: exported variables; primary one is plane `Transform` (origin/orientation of 2D movement plane).
- Logic: connect `body_entered` and `body_exited`.
- On enter: call `ReplayManager.enter_25d_zone(plane_transform)`.
- On exit: call `ReplayManager.exit_25d_zone()`.

### PlayerControllerV2 Modifications

Changes must be minimal and reactive to snapshot state.

- New state: `is_in_25d_mode` (`bool`), `active_2d_plane` (`Transform`).
- Input handling: in `step()`, when in 2.5D mode, zero out local Z/depth input component.
- Physics constraint: before `move_and_slide()`, project final velocity onto `active_2d_plane`.

### PlayerSpringCam Update

The camera transition is the primary visual cue and must be deterministic and snapshot-restorable.

- State listener: `PlayerSpringCam.gd` listens to same global state changes.
- Target calculation: fixed offset from player along normal of `active_2d_plane`, with perpendicular look.
- Smooth transition: interpolate position (`lerp`) and rotation (`slerp`) from 3D orbit to side-scroller target.
- Determinism rule: drive transition by fixed frame counter or physics-tick timer; do not use variable delta.
- Track progress: store `camera_transition_alpha` (`0.0` to `1.0`) in state.
- In steady 2.5D mode: follow player projected onto plane with fixed offset/rotation.

### Replay and Snapshot System Integration
