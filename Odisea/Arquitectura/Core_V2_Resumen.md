# Resumen del Núcleo V2 (Core_V2)

## Estructura del Proyecto (2026)

- **src/core_v2/**: Todo el código fuente activo y refactorizado (componentes, sistemas, player_controller, UI, autoloads, simulación, utilidades, tests).
- **docs/canon/**: Especificaciones y features fundacionales implementados (OdysseyScript, interactuables, pushable box, gamefeel, sidescroller, test battery, test runner, etc).
- **docs/archived/**: Features descartados o legacy (ver notas en cada archivo).
- **AGENTS.md**: Contratos de desarrollo, determinismo y normas de trabajo.

## Contratos y Normas

Consulta **Protocolo_Desarrollo.md** (copia de AGENTS.md) para reglas de determinismo, contratos de agentes, y normas de desarrollo (commits pequeños, tests con GdUnit3, todo en core_v2, etc).

## Contratos Críticos

### PlayerController — Movimiento y Plataformas

El `PlayerControllerV2` usa **Transform-Delta Tracking** para seguir plataformas móviles (inspirado en [Terrestrial Characters](https://github.com/Trokara)):

1. **Tracking de Plataformas**: Almacena `_platform_collider` y `_platform_last_transform`. Cada frame calcula dónde *estaría* el jugador si siguiera perfectamente la plataforma.
2. **Herencia de Velocidad**: Al saltar o salir de una plataforma, hereda `_platform_velocity` para conservar momentum.
3. **Alineación a Pendientes**: `PlayerMovementV2.align_to_floor()` rota el vector de movimiento para que siga el plano del suelo, evitando drift lateral en rampas.
4. **Resistencia en Pendientes**: Ralentiza el movimiento cuesta arriba según el ángulo (configurable via `slope_resistance_factor`).
5. **Stair-Stepping**: `_try_step_up()` permite subir escalones automáticamente hasta `step_height` (default 0.4m).

### Contrato de Replay Determinístico

Para garantizar replays determinísticos, todo agente sincronizado debe:

1.  Pertenecer al grupo `replay_sync`.
2.  Implementar `restore_snapshot(data: Dictionary)`.
3.  Ejecutar toda la lógica de movimiento/simulación en `_physics_process(delta)`. **Nunca en `_process(delta)`**.
4.  Consumir input a través de `InputProviderV2` (jugador) o basarse solo en estado interno (NPCs).
