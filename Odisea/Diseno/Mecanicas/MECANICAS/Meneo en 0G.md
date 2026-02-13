# Animación Procedural de Extremidades en Godot 3

Para integrar un **"meneo" procedural** en las extremidades de tu modelo rigged (brazos flotando con aceleración/gravedad variable) sin interrumpir animaciones clave como `float_idle`, utiliza la combinación de **animación procedural con `Skeleton3D` y `PhysicalBone3D`**.

Este método es ligero y se mezcla perfectamente con las animaciones preexistentes.

> **Referencia:** [Publicación original en Reddit](https://www.reddit.com/r/godot/comments/15yormo/how_do_i_make_an_idle_animation_happen_im_new_to/)

---

## ⚙️ Implementación Rápida (5 Líneas Clave)

### 1. Preparación del Rig con PhysicalBone3D

Convierte los huesos que deseas simular en nodos `PhysicalBone3D`:

- En tu nodo `Skeleton3D`, haz que los huesos de los brazos (ej. `upperarm.L/R`, `forearm.L/R`) sean hijos de nodos `PhysicalBone3D`.
    
- **Configuración clave:** Para una respuesta suave y flotante, ajusta los parámetros:
    
    - `mass`: $0.5$
        
    - `damping`: $2.0$
        

### 2. Script de Control (Adjunto a `CharacterBody3D` Root)

Este script aplicará la fuerza de la aceleración a los huesos físicos **solo** cuando la animación de flotación esté activa.

GDScript

```
extends CharacterBody3D

@onready var skeleton = $Model/Skeleton3D # Asegúrate de que la ruta sea correcta
var arm_bones = ["upperarm.L", "forearm.L", "upperarm.R", "forearm.R"] # Nombres de tus huesos

func _physics_process(delta):
    # Condición: Solo aplica la fuerza durante la animación 'float_idle'
    if $AnimationPlayer.current_animation == "float_idle":
        var accel = velocity / delta # Calcula la aceleración real-time
        
        # 1. Activa la simulación de huesos físicos
        skeleton.physical_bones_start_simulation() 
        
        # 2. Aplica impulso a cada hueso
        for bone_name in arm_bones:
            var bone_id = skeleton.find_bone(bone_name)
            
            if bone_id != -1:
                var force = accel * 0.1 # Factor de escalado suave (ajusta 0.05-0.2)
                
                # 3. Encuentra el PhysicalBone y aplica el impulso
                skeleton.get_physical_bone_children()[bone_id].apply_central_impulse(force * delta)
```

### 3. Mezcla con AnimationTree

Para asegurar que la animación procedural se mezcle correctamente con la animación fija:

- Utiliza un `BlendSpace1D` dentro de tu `AnimationTree`.
    
- **Mezcla:** Combina `float_idle` (ej. `blend = 0.7`) con un nodo `AnimationNodeOneShot` vacío que represente la lógica procedural (ej. `blend = 0.3`).
    
- **Transición:** Controla la mezcla automáticamente usando `velocity.length()` o la magnitud de la aceleración.
    

---

## ✨ Ventajas para un Juego de Odisea Espacial

Este enfoque ofrece beneficios significativos en entornos de gravedad variable o movimiento inercial:

- **Reacción a Jetpack/Fuerzas G:** Las extremidades reaccionan instantáneamente a cambios en la **aceleración** (`thrust`) o la dirección de la **gravedad** (ideal para la Acto II).
    
- **`0G float_idle` Mejorado:** Los brazos "flotan" de manera natural con inercia y rebote, sustituyendo la sensación rígida de una animación cíclica fija.
    
- **Rendimiento Ligero:** Solo se simulan los 4 huesos de las extremidades. El impacto en el rendimiento de la CPU es mínimo.
    
- **Sistema No Chocante:** El `AnimationPlayer` mantiene la prioridad. La simulación procedural de los huesos físicos actúa como una **capa de superposición** (_overlay_) sobre la animación base.
    

¿Te gustaría que adapte este ejemplo a la sintaxis y nombres de nodos de Godot 4, ya que Godot 3 está menos actualizado?