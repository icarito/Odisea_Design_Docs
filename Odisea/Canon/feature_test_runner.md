# Especificación Técnica: Runner de Pruebas de Regresión Determinista

## Objetivo

Implementar un sistema de pruebas automatizadas con GDUnit3 que recorra recursivamente el directorio de tests, ejecute cada replay encontrado y valide que el resultado de simulación coincida con el estado final grabado.

## Convenciones de Archivos

- Ubicación base: `res://core_v2/tests/`
- Patrón de nombre: `replay_test_[description].json`
- Estructura de carpetas (ejemplo):

```text
tests/movement/replay_test_strafing_jump.json
tests/obstacles/replay_test_conveyor_push.json
tests/platforms/replay_test_vertical_elevator.json
```

## Requerimientos del Runner (GDUnit3)

### Escaneo de Datos (Data Provider)

El test debe implementar una función estática o interna que actúe como `DataSource`.

- Lógica: usar `Directory` para caminar recursivamente por `res://core_v2/tests/`.
- Filtro: procesar solo archivos que comiencen con `replay_test_` y terminen en `.json`.
- Retorno: array de paths (`String`) para inyectar en test parametrizado.

### Ciclo de Ejecución por Test

Para cada `path` entregado por el data provider:

- Instanciación: cargar escena de pruebas estándar (`TestScene_v2.tscn`).
- Preparación: llamar a `SessionManager.load_and_play(path)`.
- Reporte: extraer `description` del nombre del archivo para GDUnit.
- Simulación: dejar que `SessionManager` tome el control.
- Espera: usar `yield` o señal `replay_finished`.
- Validación:
- Comparar `player.global_transform.origin` con `final_state` del JSON.
- Umbral de éxito: `0.0001`.
- Validar también rotación (`yaw`, `pitch`) si están presentes.

## Reporte y Diagnóstico

Si el test falla, el mensaje de error de GDUnit debe incluir:
