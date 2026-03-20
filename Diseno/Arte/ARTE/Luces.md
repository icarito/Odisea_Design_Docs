# Especificación: Sistema de Atmósfera y Luz (GLES2)

## 1. Objetivo Visual

Crear un contraste emocional mediante el color:

- **Zona A:** Tensión y peligro (Rojos/Sombras duras).
    
- **Zona C:** Apertura y escala industrial (Teal & Orange / Niebla volumétrica simulada).
    

## 2. Configuración de WorldEnvironment (Global)

El `WorldEnvironment` es el corazón de la atmósfera.

- **Background Mode:** `Canvas` o `Sky`.
    
- **Ambient Light:** - Color: `#1a202c` (Azul muy oscuro).
    
    - Energy: `0.6` (Para evitar negros puros y que Elias sea visible en las sombras).
        
- **Fog (Niebla):**
    
    - **Enabled:** True.
        
    - **Color:** `#7e94a8` (Gris azulado para simular profundidad atmosférica).
        
    - **Depth Begin:** `10.0` (Para que el primer plano sea nítido).
        
    - **Depth Curve:** `1.5` (Suavizado de la transición).
        

## 3. Tipos de Luces por Zona

### Zona A (Mantenimiento - 3D)

- **Tipo:** `OmniLight`.
    
- **Color:** `#ff0000` (Rojo puro).
    
- **Efecto:** "Alarm Pulse" (Script que varía la `energy` entre 0.2 y 1.5 usando una función `sin(time)`).
    
- **Sombras:** Activadas con `Shadow Color` oscuro para acentuar la claustrofobia.
    

### Zona C (Terraza - 2.5D)

- **Tipo:** `DirectionalLight` (El Sol).
    
- **Color:** `#ff9e47` (Naranja atardecer).
    
- **Energy:** `1.2`.
    
- **Shadow Mode:** `PCF5` (Sombras suaves para un look moderno).
    
- **Rim Lighting:** Añadir un `SpatialMaterial` a Elias con `Rim` activado (Color blanco, Energy 1.0) para que destaque contra el fondo oscuro.
    

## 4. Trucos de Rendimiento (GLES2)

- **Niebla de Suelo:** No usar partículas costosas. Usar un `MeshInstance` plano (Quad) con un shader de gradiente transparente que se mueva suavemente.
    
- **Light Bakes:** Para el blockout final, usar `BakedLightmap` en los nodos estáticos de Kenney para obtener rebotes de luz naranja en las paredes azules sin coste de CPU.
    

## 5. Parámetros de Post-Procesado

- **Bloom:** - Threshold: `0.8`.
    
    - Softness: `0.6`.
        
    - (Crucial para el destello al abrir la puerta de la Zona B).