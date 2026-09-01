# Anexo: Blockout del Módulo Criogenia

> ⚠️ **SUPERSEDED (2026-09-01).** Ver [[Locacion_Criogenia]] (domo + hangar). Se conserva
> por historial.

---

**Fecha**: Junio 2026  
**Estado**: Pendiente de greybox  
**Propósito**: Especificación dimensional para blockout en Godot

---

## 1. Dimensiones generales

| Zona | Ancho (m) | Largo (m) | Alto (m) |
|------|-----------|-----------|----------|
| Sala A (criopods) | 20 | 30 | 12 |
| Sala B (energía auxiliar) | 12 | 15 | 8 |
| Pasillo conexión | 4 | 10 | 4 |
| Esclusa exterior | 3 | 5 | 3 |
| Total módulo | 24 | 40 | 12 |

---

## 2. Niveles verticales

| Nivel | Altura suelo (m) | Cobertura |
|-------|------------------|-----------|
| Planta baja | 0 | Sala A completa, Sala B, esclusa |
| Entrepiso | 5 | Pasarela perimetral Sala A (2m ancho) |
| Pasarela superior | 9 | Tuberías, paneles secundarios |

**Conexión vertical**: Rampa fija de escombros (ángulo ~30°, 3m subida, 5m horizontal).

---

## 3. Ruta crítica (flow)

```
Cápsula Elías [0,0,0]
  → Consola Sala A [0,10,0]  (OD-02 crítico)
  → Gap corto (1.5m) [10,0,0]
  → PushableBox + escombros [14,0,0]
  → Lever energía auxiliar [16,0,0]
  → Volver por Sala A
  → Puerta A-7 [-5,0,0]
  → Esclusa [-8,0,0]
  → Exterior
```

**Tiempo estimado**: 6-8 minutos (primera partida).

---

## 4. Props por ubicación

| Prop | Ubicación | Función |
|------|-----------|---------|
| Criopod (x24) | Sala A, fila radial | Escenografía + lore |
| TableTerminal | Sala A, centro | Diagnóstico OD-02 |
| PedestalButton (x2) | Pasillos laterales | Detener fugas de gas |
| LeakEmitter (x3) | Pasillos laterales | Obstáculo ambiental |
| PushableBox | Sala B, entrada | Despejar escombros |
| LeverV2 | Sala B, pared fondo | Activar energía auxiliar |
| PipeValve (x4) | Pasarela superior | Decoración + lore |
| DataSlate (x2) | Sala A + pasillo | Lore fragments |
| WarningBarrier | Bordes de entrepiso | Seguridad visual |
| BrokenFloorPanel | Sala A, cerca consola | Decoración |

---

## 5. Iluminación y ambiente

- **Luz principal**: Azul cian de criopods (point lights, radius 3m)
- **Luz secundaria**: Tiras LED rojas en el piso (ruta crítica)
- **Niebla**: Criogénica baja (altura 1.5m, density 0.01)
- **Paredes**: Metal oscuro con paneles removibles
- **Suelo**: Rejilla metálica (textura procedural)
- **Techo**: Tuberías expuestas, conductos

---

## 6. Readability checklist

- [ ] Ruta crítica visible sin mapa (luces LED rojas + contraste)
- [ ] Gap identificable (borde iluminado, viento/fogonazos)
- [ ] Lever contrasta con entorno (naranja sobre gris/azul)
- [ ] PushableBox se distingue de escombros fijos
- [ ] Puerta A-7 destacada (marco luminoso, letrero EXIT)

---

## 7. Performance targets

- **Polígonos**: < 50K tris por sala
- **Luces**: < 8 real-time point lights
- **Draw calls**: < 200
- **Texturas**: 512x512 atlas comprimido

---

## 8. Pendientes

- [ ] Greybox en Godot (branch level_work)
- [ ] Validar altura de rampa (3m puede ser mucho para salto sin impulso)
- [ ] Decidir si gap tiene hint visual o tutorial
- [ ] Decidir estado de ocupantes de criopods (vacíos, esqueletos, intactos)
