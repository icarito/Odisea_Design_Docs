
## Física del SCG (Sistema Centrífugo de Gravedad) - Odisea

![SCG dual-sphere rotating gravity system with centrifugal force vectors](https://user-gen-media-assets.s3.amazonaws.com/gemini_images/15fa7d51-0c5c-4710-bcbd-39321aa7f5e0.png)
He preparado una **documentación completa y detallada** sobre la implementación de los cálculos físicos del SCG para Godot 3. Aquí está el resumen ejecutivo:

### 📊 Archivos Generados

1. **`odisea_scg_physics.md`** - Documento teórico exhaustivo con:
    - Fundamentos matemáticos de gravedad centrífuga
    - Cálculos geométricos para plataformas cóncavas
    - Fórmulas para esferas conectadas con tubos
    - Interpolación de gravedad en transiciones
    - Ejemplos prácticos para Odisea
    - 
2. **`godot3_scg_implementation.gd`** - Código funcional GDScript con:
    - Clase `GravitySource` completa
    - `PlayerController` modificado con gravedad variable
    - Sistema de zonas (`GravityZone`)
    - Plataformas rotantes (`RotatingPlatform`)
    - Cache de rendimiento
3. **`scg_reference_quick.md`** - Guía rápida con tablas y fórmulas
![SCG dual-sphere rotating gravity system with centrifugal force vectors](https://user-gen-media-assets.s3.amazonaws.com/gemini_images/15fa7d51-0c5c-4710-bcbd-39321aa7f5e0.png)
### 🔢 Fórmulas Clave

**Aceleración centrífuga:**

$$
a = \omega^2 \cdot r
$$

Para **1G a r=100m**: $$
\omega = 0.287 \text{ rad/s}, \quad T = 21.9 \text{ seg}, \quad v = 34.4 \text{ m/s}
$$

![SCG dual-sphere rotating gravity system with centrifugal force vectors](https://user-gen-media-assets.s3.amazonaws.com/gemini_images/15fa7d51-0c5c-4710-bcbd-39321aa7f5e0.png)

SCG dual-sphere rotating gravity system with centrifugal force vectors

![Gravity interpolation through tube connector - transitional field visualization](https://user-gen-media-assets.s3.amazonaws.com/gemini_images/9905dbfc-fbab-45be-a9b8-d8e4475c2e6d.png)

Gravity interpolation through tube connector - transitional field visualization

### 🎯 Configuración Propuesta para Odisea

**Dos esferas conectadas:**


| Componente | Esfera A (Bio-Granja) | Esfera B (Hábitat) | Tubo |
| :-- | :-- | :-- | :-- |
| Radio | 120 m | 100 m | 310 m largo |
| ω | 0.287 rad/s | 0.287 rad/s | Interpolado |
| Gravedad | 1.0G | 0.82G | Transición suave |
| Período | 21.9 seg | 21.9 seg | - |

**Interpolación en tubo:**

```
Gravity(s) = lerp(g_A, g_B, smooth_step(s))
donde s ∈ [0, 1] es la posición en el tubo
```


### 💻 Implementación Godot 3

**Cálculo de gravedad en punto:**

```gdscript
func get_gravity(point: Vector3, omega: float) -> Vector3:
    var perp_dist = sqrt(point.x*point.x + point.z*point.z)
    var g_mag = omega * omega * perp_dist
    var g_dir = -Vector3(point.x, 0, point.z) / perp_dist
    return g_dir * g_mag
```

**Alineación del jugador:**

- Rotación suave del personaje conforme cambia la dirección de "abajo"
- Salto contra la dirección de gravedad actual
- Movimiento en plano tangente a la gravedad


### 🎮 Casos de Uso en Odisea

**Acto II - Bio-Granjas SCG:**

- Plataformas cóncavas que parecen suelos pero están sobre esferas rotantes
- **Puzzle:** Realinear brazos giratorios para cambiar ω de una esfera
- **Efecto visual:** Paredes se convierten en suelos cuando gira

**Área Tubular:**

- Transición progresiva de gravedad mientras se cruza el tubo
- Cambio de orientación de "arriba/abajo"
- Desafío: mantener movimiento mientras la gravedad rota


### ⚡ Optimizaciones

- **Caching:** Almacenar gravedad por posición redondeada
- **LOD:** Desactivar cálculos complejos a distancia > 200m
- **Raycast volumétrico:** Detectar zona actual del jugador


### 📐 Visualizaciones Generadas

- Diagrama de sistema dual-esfera con vectores de gravedad