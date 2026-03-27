Aquí tienes el **Master Plan** para tu suite de herramientas de animación. Como buen activista del software libre, vamos a mantener esto modular, desacoplado y con estándares abiertos (nada de formatos propietarios oscuros).

Todo esto corre bajo la premisa de que **Python** hace el trabajo sucio (matemáticas, inferencia, UI GTK4) y **Godot** solo se encarga de renderizar lo que le mandan.

---

# 1. Odisea LiveLink (Live Streaming)

_El titiritero digital. Convierte tu webcam en un mocap suit de bajo presupuesto._

**Propósito:** Transmisión de datos de huesos en tiempo real desde Python hacia una instancia de Godot corriendo `Odisea`. Latencia mínima es la prioridad.

## Inputs

- **Video Source:** Stream de cámara (`/dev/video0`) o archivo de video en loop (para debug).
    
- **Calibration Config:** JSON con offset de altura (para que no flotes o te hundas en el piso) y sensibilidad de suavizado (jitter reduction).
    
- **Network Target:** IP y Puerto (ej. `127.0.0.1:9000`).
    

## Outputs

- **Data Stream (UDP/WebSocket):** Paquetes JSON (o Binary Blob para mas performance) enviados a 30/60Hz.
    
    - _Estructura:_ `{ "t": timestamp, "bones": { "hips": [x,y,z,qx,qy,qz,qw], "spine": [qx,qy,qz,qw], ... } }`
        
    - Solo se envían rotaciones (Quaternions) locales para todos los huesos, excepto `Hips` que lleva Posición + Rotación.
        

## Componentes Clave

- **Jitter Filter:** Un One-Euro Filter implementado en Python para que tu personaje no parezca que tiene cafeína intravenosa.
    
- **Transport:** Librería `zeromq` o `websockets`. UDP es preferible para "fire and forget".
    

---

# 2. Odisea Animator (Animation Editor)

_El estudio de post-producción GTK4. Porque el output crudo de la IA siempre necesita cariño._

**Propósito:** Cargar animaciones crudas, limpiar ruido, editar curvas, visualizar "Onion Skinning" y exportar el GLB final.

## Inputs

- **Raw Animation Data:** Archivos `.npy` (numpy dump) o JSON crudo del _Pose Recorder_.
    
- **Reference Mesh:** Un GLB estático de tu personaje de Odisea para visualización.
    

## Outputs

- **Clean GLB (glTF 2.0):** Archivo binario listo para Godot.
    
    - Debe incluir: `Animation` channel, `Skin`, y `Skeleton`.
        
    - Optimizado: Keyframes redundantes eliminados (douglas-peucker algorithm).
        

## Features & UI Specs (GTK4/Libadwaita)

- **Timeline Widget:** Un `Gtk.DrawingArea` custom. Permite scrubbing.
    
- **Onion Skinning:**
    
    - Renderiza en el viewport (usando `pyglet` o `wgpu` embebido en GTK) el frame actual (opaco), frame -3 (alpha 0.5, tinte rojo) y frame +3 (alpha 0.5, tinte verde).
        
- **Curve Editor:** Visualización simple de las curvas de rotación X/Y/Z/W para detectar picos de ruido.
    

---

# 3. Odisea Batch Recorder (Pose Recorder)

_La granja de render. Para cuando quieres robarle los movimientos a 200 videos de YouTube._

**Propósito:** CLI o GUI minimalista para procesar carpetas enteras de videos y generar archivos de animación intermedios.

## Inputs

- **Source Directory:** Ruta a carpeta con `.mp4` / `.mkv`.
    
- **FPS Target:** Framerate de muestreo (ej. forzar todo a 30fps).
    
- **Model Complexity:** Selector (Lite/Full) del modelo de pose estimation.
    

## Outputs

- **Intermediate Format:** Archivos JSON por video.
    
    - Estructura: `[ {frame: 0, keypoints_3d: [...]}, {frame: 1, ...} ]`.
        
    - Guarda la data _cruda_ de los puntos 3D sin procesar a huesos todavía (para poder re-calcular el retargeting después si mejoras el algoritmo).
        

## Componentes Clave

- **Multiprocessing:** Usa todos los cores de tu CPU. Un proceso por video.
    
- **Ffmpeg binding:** Para extraer frames rapidísimo sin overhead de UI.
    

---

# 4. The Bone Mapper (Rig Adapter)

_El traductor universal. Convierte "Puntos en el espacio" a "Rotaciones de Huesos"._

**Propósito:** Módulo de lógica pura (sin UI) que toma puntos 3D (Landmarks) y resuelve la cinemática para un esqueleto estándar (Mixamo/Godot Humanoid).

## Inputs

- **Landmarks 3D:** Array de vectores `(x, y, z)` provenientes del modelo de IA (ej. MediaPipe Topology).
    
- **Target Skeleton Definition:** Un diccionario definiendo la jerarquía y el "Bind Pose" (T-Pose) del esqueleto de destino.
    

## Outputs

- **Bone Transforms:** Diccionario de matrices 4x4 o Quaternions locales por hueso.
    
    - _Ejemplo:_ `GetRotation(ParentBone, ChildBone, TargetVector)` -> Quaternion.
        

## Lógica Específica

- **Global vs Local:** Debe convertir las posiciones globales predichas por la IA a rotaciones locales relativas al padre.
    
- **Twist Correction:** Corregir giros antinaturales en muñecas y tobillos (el "candy wrapper effect").
    
- **Foot Locking (Opcional):** Detectar cuando la velocidad del pie es cercana a 0 y "clavar" la posición IK para evitar que patine.
    

---

# 5. Odisea Importer (Godot Plugin)

_El receptor en tierra. Código GDScript/C++ que vive dentro de tu juego._

**Propósito:** Recibir datos (live) o importar archivos (offline) y aplicarlos a los nodos `Skeleton3D` nativos.

## Inputs

- **Network Packet:** JSON entrante del _LiveLink_.
    
- **File Import:** Archivos `.glb` generados por el _Animator_.
    

## Outputs

- **Visual Update:** Movimiento de los nodos en el Viewport.
    
- **Resource (.tres):** Guardar la animación recibida en vivo como un `AnimationLibrary` resource para usar luego.
    

## Componentes Clave

- **RemoteTransform3D Manager:**
    
    - Script que asigna dinámicamente nodos `RemoteTransform3D` a los huesos del esqueleto si estás en modo Live.
        
- **Stream Player:**
    
    - Un buffer circular de ~5 frames para interpolar la data que llega por red y evitar "tirones" si un paquete UDP se pierde.
        
- **Retargeting Runtime (Opcional):** Si decides enviar solo puntos 3D, Godot hace el IK (`SkeletonIK3D`). Si envías rotaciones (recomendado), Godot solo aplica rotación.
    

---

## Resumen del Flujo de Datos

1. **Webcam** -> _LiveLink_ (Python) -> **JSON UDP** -> _Godot Plugin_ -> **Juego** (Live Mode)
    
2. **Video File** -> _Recorder_ (Python) -> **Raw JSON** -> _Rig Adapter_ -> _Animator_ (GTK4) -> **GLB** -> _Godot_ (Asset Mode)