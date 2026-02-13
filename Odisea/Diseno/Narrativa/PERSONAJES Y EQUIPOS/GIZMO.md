# Gizmo NAV-COMPAS: Modelo 3D Nave + Brújula Orientación

## Descripción General

Holograma flotante semitransparente (cyan #00FFFF, 85% opacidad) que muestra modelo low-poly de la nave Odisea completa (8km escala comprimida). Siempre visible en esquina superior derecha del visor de Elías. Doble función: **navegación espacial** + **brújula gravitacional/orientación**.odisea_wiki.json​

## Apariencia y Estructura



```
┌─────────────────────┐
│  [Odisea Modelo]    │ ← Nave entera girando lentamente
│                     │ 
│  ● PROA  ←■■■← NÚCLEO ←■■■← CRIOS ← POPA ● 
│     ^ Jugador (naranja) ↑ Gravedad Local 
│                     │ 
│  [Vector Gravedad]  │ ← Flecha cyan rotatoria 
│  [Mini-Mapa Sector] │ ← Sector actual expandido 
└─────────────────────┘
   ```


- **Tamaño:** 20% esquina superior derecha (no obstruye gameplay).
    
- **Rotación:** Nave gira suavemente (1 rotación/10s) para referencia espacial.
    
- **Punto Naranja:** Posición exacta de Elías (pulsante, trail cuando se mueve).
    

## Funciones de Brújula 3D

## 1. Orientación Gravitacional (Siempre Activa)

```
[ Flecha Cyan Gruesa ] → Indica "ABAJO" local (vector gravedad)
[ Rotación Dinámica ] → UI gira con gravedad variable (nunca patas arriba)
[ Icono Estabilizador ] → Si gravedad = 0G, muestra último vector conocido
```

## 2. Navegación por Nave

- **Líneas Cyan Pulsantes:** Ruta óptima al objetivo actual (ej: "Núcleo IA").
    
- **Sectores Iluminados:**
    
    - 🟢 Accesible (ruta despejada)
        
    - 🟡 Bloqueado (IA selló acceso)
        
    - 🔴 Peligroso (radiación/drones)
        
- **Tap Interactivo:** Expande sector tocado → mini-mapa detallado con plataformas.
    

## 3. Indicadores Contextuales

text

```
[PROP: 62%] Barra vertical junto modelo (combustible propulsor) 
[CARGOL] Icono dron orbitando modelo (si activo) 
[IA-ALERTA] Parpadeo rojo en núcleo si IA activa sabotaje cercano
```

## Interacciones Táctiles Simples

- **Swipe Izq/Der:** Rotar vista modelo nave 90° (Proa→Popa).
    
- **Pinch:** Zoom sector actual (ver plataformas detalladas).
    
- **Tap Prolongado:** Toggle modo "Ruta Automática" (líneas guían saltos).
    
- **Swipe Abajo:** Minimizar a icono cyan flotante.
    

## Adaptación Dinámica


```
Gravedad 1G Normal:    [Modelo horizontal, flecha abajo] 
Gravedad Variable:     [Modelo rota 90°, flecha reorienta] 
0G Completo:          [Modelo libre, estabilizador gyro] 
Emergencia:           [Modelo +50% tamaño, todo naranja]
```

## Integración Estética

- **Low-Poly Perfecto:** Misma poligonización que nave en juego.
    
- **Glow Cyan Suave:** Bordes bloom integrados con niebla volumétrica.
    
- **Transparencia Dinámica:** 95% opacidad en sectores vacíos, 70% en áreas críticas.
    
- **Sonido:** Zumbido sutil al rotar, "beep" al alcanzar nodo objetivo.odisea_wiki.json​
    

**Nota Lore:** Gizmo hereda diseño de Programadora Principal. IA lo manipula sutilmente (ruta falsa ocasional) para generar duda en Elías sobre su fiabilidad.