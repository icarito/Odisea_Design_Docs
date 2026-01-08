---
epoch: 1767765470262
modelKey: "deepseek/deepseek-r1-0528:free|openrouterai"
topic: "MVP Level 1 Obstacle Sequence"


tags:
  - copilot-conversation
---

**user**: Hagamos un plan para implementar el primer nivel del MVP. Vamos a implementar plataformas móviles tomando en cuenta[[Scene Testing]]  - Proponme una secuencia de obstáculos que respete el proceso de aprendizaje del jugador
[Context: Notes: _FEATURES PIPELINE/Scene Testing.md, NARRATIVA/ACTO 1/Acto_I_La_Negacion.md]
[Timestamp: 2026/01/07 00:57:50]

**ai**: Basado en el contexto de [[Acto_I_La_Negacion]] y [[Scene Testing]], aquí tienes un plan de implementación para el primer nivel MVP con progresión de aprendizaje:

### Secuencia de Obstáculos para Plataformas Móviles (MVP)
**Objetivo:** Introducir mecánicas gradualmente respetando la curva de aprendizaje.

| Orden | Obstáculo | Mecánica | Propósito Pedagógico | Vinculación con Testing |
|-------|-----------|----------|----------------------|-------------------------|
| **1** | Plataforma horizontal lenta | Movimiento lineal básico (eje X) | Enseñar timing de salto estático | `v2_platform_test.json` (validación de herencia de velocidad) |
| **2** | Plataforma vertical oscilante | Movimiento en Y con ciclo predecible | Dominar saltos en movimiento vertical | `v2_jump_consistency.json` (coyote time) |
| **3** | Plataforma rotatoria simple | Rotación básica (15-30 RPM) | Adaptarse a cambios de orientación | Test de deriva rotacional (`rot_snapshot` en `get_snapshot()`) |
| **4** | Plataforma + DDC pasivo | Combinar plataforma con patrulla de dron | Introducir multitarea (plataforma + sigilo) | N/A (foco en física) |
| **5** | Plataforma acelerante | Aceleración no lineal (fricción variable) | Dominar cambios de momentum | `v2_friction_test.json` (umbral 0.0001) |
| **6** | Secuencia sincronizada | 2-3 plataformas con timing coordinado | Planificación de rutas complejas | `sync_test.json` (nuevo caso) |

---

### Checklist de Implementación Técnica
1. **Prefab de Plataforma Móvil**  
   - Implementar `KinematicBody` con:  
     ```gdscript
     func get_snapshot() -> Dictionary:
         return {
             "transform": global_transform,
             "velocity": linear_velocity,
             "angular_vel": angular_velocity
         }
     ```

2. **Integración con Suite de Regresión**  
   - Grabar 3 replays específicos:  
     - `v2_platform_horizontal.json` (obstáculo 1)  
     - `v2_platform_vertical.json` (obstáculo 2)  
     - `v2_platform_sync.json` (obstáculo 6)

3. **Diseño de Nivel Progresivo**  
   ```mermaid
   graph LR
   A[Sector Criogénico] --> B[Plataforma Horizontal]
   B --> C[Salto Vertical]
   C --> D[Rotación Básica]
   D --> E[Combinación DDC]
   E --> F[Secuencia Sincronizada]
   ```

4. **Validación de Aprendizaje**  
   - Metricas clave:  
     - Intentos fallidos por obstáculo (meta < 3 reintentos)  
     - Tiempo de completación decreciente  
     - Ratio de detección por DDC (<10% en obstáculo 4)

---

### Próximos Pasos Recomendados
1. Crear `PlatformControllerV2.gd` con:  
   - Parámetros ajustables: `speed`, `accel_curve`, `sync_group`  
   - Señal `platform_restored()` para sincronización

2. Extender la suite de tests:  
   ```gdscript
   func test_platform_sync():
       var platform1 = add_platform("horizontal")
       var platform2 = add_platform("vertical")
       platform1.add_to_group("sync_group_A")
       platform2.add_to_group("sync_group_A")
       # ... lógica de sincronización ...
       assert_snapshot(platform1).matches(platform2)
   ```

¿Te gustaría que genere los prefabs base para las plataformas o prefieres enfocarnos en el diseño del primer sector criogénico?
[Timestamp: 2026/01/07 00:58:45]

**user**: Cool mira ya tengo ahora implementadas plataformas móviles deterministas. Me gustaría hacer una batería de tests y oijalá incluso empezar a medir la cobertura? En todo caso lo que quiero de ti es que me hagas una propuesta de plan de testing, tipo:

Tests de movimientos (en Z, en X, saltar, etc - pero _separados_) además de Strafe (y posteriormente Tank Turn).

Tests de obstáculos (pasar por una y varias plataformas móviles distintas)

Hazme una tablita con casos para probar y sugerencias para implementar
[Context: Notes: _FEATURES PIPELINE/Movement Refinement.md]
[Timestamp: 2026/01/07 10:12:29]

**ai**: Basado en [[Scene Testing]] y [[Movement Refinement]], aquí tienes un plan de testing estructurado para mecánicas de movimiento y obstáculos:

### Plan de Testing para Movimiento y Plataformas Móviles

| **Categoría** | **Caso de Prueba** | **Métricas Clave** | **Implementación Sugerida** | **Vinculación con Regresión** |
|---------------|---------------------|---------------------|----------------------------|------------------------------|
| **Movimiento Básico** | Movimiento en eje X (aceleración/frenado) | Tiempo de 0 a max_speed, distancia de frenado | Usar `InputDataV2` simulado con aceleración gradual | `v2_friction_test.json` |
|  | Movimiento en eje Z (forward/backward) | Consistencia de velocidad en pendientes | Añadir rampas de prueba al escenario | Nuevo replay: `v2_slope_test.json` |
| **Saltos** | Salto básico (full height) | Altura máxima, tiempo de caída | Test en cámara de vacío (sin gravedad externa) | `v2_jump_consistency.json` |
|  | Short jump (early release) | Ratio altura_corta/altura_completa | Variar frames de presión (5-15 frames) | Nuevo test: `v2_short_jump.gd` |
| **Mov. Aéreo** | Air strafing (direccional) | Cambio de dirección en aire | Verificar air_friction ≠ ground_friction | `assert_float(air_friction).is_less(ground_friction)` |
|  | Tank turn (rotación en aire) | Grados/segundo con input máximo | Implementar curva de aceleración rotacional | `tank_turn_curve.tres` |
| **Plataformas** | Plataforma horizontal simple | Drift después de 10 segundos | `assert_drift(player_pos) < 0.0001` | `v2_platform_test.json` |
|  | Plataforma acelerante (curva) | Sync entre velocidad visual/física | Graficar speed vs time en debug overlay | `PlatformDebugger.gd` |
|  | Transición entre 2 plataformas | Conservación de momentum | Medir ∆v en punto de transición | `transition_test.json` replay |
| **Edge Cases** | Salto en borde de plataforma | Coyote time consistency | Contar frames válidos post-salida | `assert_coyote_time(6±1 frames)` |
|  | Plataforma + slope combo | Velocidad resultante vectorial | Calcular ángulo de rebote | `Vector3.angle_to()` |

---

### Herramientas de Implementación Recomendadas

1. **GdUnit Test Suite**:
```gdscript
# Ejemplo test strafing
func test_air_strafing():
    var player = spawn_player(Vector3(0, 5, 0))  // En aire
    simulate_input(InputDataV2.new({
        move_right: true, 
        move_forward: true
    }), duration: 2.0)
    assert_vector3(player.velocity).has_length(MAX_AIR_SPEED)
```

2. **Debug Overlay**:
   - Velocímetro vectorial (X/Y/Z)
   - Indicador de fricción activa (ground/air/platform)
   - Gráfico en tiempo real de curvas de aceleración

3. **Cobertura de Código**:
   ```bash
   gdunit3 --coverage --output=coverage.html
   ```
   - Meta inicial: 85% cobertura en `PlayerControllerV2.gd`
   - Excluir animaciones/VFX

---

### Secuencia Priorizada de Implementación

1. **Fase 1: Movimiento Básico (Tierra)**
   - [ ] Test X/Z movement con fricción variable
   - [ ] Curvas de aceleración para transiciones suaves

2. **Fase 2: Movimiento Aéreo**
   - [ ] Implementar tank turn con `rotation_accel_curve`
   - [ ] Validar conservación de momentum en air strafing

3. **Fase 3: Interacción Plataformas**
   - [ ] Sistema de snapshots para plataformas acelerantes
   - [ ] Tests de transición entre plataformas móviles

4. **Fase 4: Edge Cases**
   - [ ] Coyote time calibration
   - [ ] Slope angle threshold testing

---

### Próximos Pasos
¿Prefieres que:
1) Genere plantillas para los 5 tests más críticos (e.g. short jump, platform transition)
2) Diseñe un escenario de prueba modular para validar combinaciones
3) Implemente el sistema de debug overlay?
[Timestamp: 2026/01/07 10:13:28]