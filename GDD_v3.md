# GDD v3 — Odisea: El Arca Silenciosa

> Documento de Diseño de Juego. Minimalista. Solo decisiones confirmadas.
> Cosas sin decidir se marcan como `[DECIDIR]`.
> **Actualizado 2026-09-08:** alineado al canon del Vertical Slice del Domo Criogénico
> (FD-289 en el repo del juego + `Diseno/Narrativa/Acto_I_La_Negacion.md`).
> Tracking: icarito/Odisea#319 + `Produccion/VS_Checklist.md`.

---

## 1. Visión General

Odisea es un juego de plataformas 3D con exploración y narrativa ambiental. El jugador es Elías, un Oficial de Mantenimiento que despierta de criogenia en una nave intergaláctica controlada por una IA llamada Odisea. La nave ha sido saboteada. El jugador debe recorrer el entorno, evitar amenazas y descubrir la verdad sobre la misión.

**Género:** Plataformas 3D / Aventura
**Tono:** Suspenso, claustrofobia, melancolía, dilema moral
**Estilo visual:** Low-poly sci-fi retrofuturista. Iluminación de neón, niebla, metal industrial.

---

## 2. Pilares de Diseño

1. **Física visceral** — El movimiento se siente físico. Conservación de momentum, aceleración mecánica, inercia. El motor de física no es decoración, es mecánica.
2. **El espacio cuenta la historia** — Cada sala comunica narrativa a través de su geometría, iluminación y props. No se necesita diálogo para entender qué pasó.
3. **Amenaza ambiental, no combate** — El peligro viene de la nave y sus sistemas corrompidos. El jugador evade, no pelea.
4. **Un solo mundo coherente** — Todo lo que existe en el juego pertenece a la misma lógica interna. Nada es un "minijuego aislado".

---

## 3. Personajes

### Elías (jugable)
Oficial de Mantenimiento. Traje naranja. Ágil, capaz de correr y saltar. Despierta de criogenia sin recuerdos recientes.

### IA Odisea
Controla la nave. Comunica por voz y efectos ambientales. Aparenta ser benevolente. Sus intenciones reales son ambiguas.

### Cargol (NPC asistente)
Dron compañero. Se mueve por conductos de ventilación y zonas angostas. El jugador puede darle órdenes simples (ir a un punto, activar un interruptor). No es piloteable.
**Fuera del Vertical Slice** (recortado 2026-09-01): se encuentra en la sección de Transporte, después de salir de Criogenia.

### DDC (drone de seguridad)
Drone reprogramado por la IA. Patrulla zonas y detecta al jugador. **Fuera del Vertical Slice** (recortado 2026-09-01): vuelve en el backlog del Acto I, después del domo. [DECIDIR al retomar: forma final del modelo y comportamiento — waypoints+raycast vs IA entrenada "Ana" (riesgo de determinismo Core V2).]

---

## 4. Mecánicas del Jugador

### Movimiento
- Caminar, correr, saltar
- Interactuar con objetos del entorno (tecla E)
- Usar herramienta de mantenimiento

### Física y Momentum
- Conservación de momentum en movimiento
- Movimientos pendulares y aceleración mecánica
- [DECIDIR: ¿Se incluye gravedad variable en el VS? Posible combinación con momentum — gravedad fluctuante que amplifica la sensación física]

### Navegación y Observación
- El jugador avanza explorando y leyendo el entorno
- La narrativa es ambiental: props, iluminación, disposición del espacio
- Diálogo mínimo — voz de la IA Odisea como guía sutil, sin romper inmersión

### Sigilo (fuera del VS)
- Sin DDC en el slice: la tensión del Acto I es ambiental (SCRAM, fugas, plasma, frío)
- El sigilo (patrulla, detección, zona sellada) vuelve con el DDC en el backlog del Acto I
- No hay combate directo — pilar intacto

### Interacción
- Máquinas del domo con un verbo cada una (FD-289 §3.4): válvula, palanca, fusible, bomba, purga, parche, extractor, manómetro
- Objetos empujables **sí están en el VS** (decidido 2026-09-01): `PushableBoxV2` y cintas `Conveyor` en el hangar
- Plataforma móvil de descenso (`HangarPlatform`) + rampa de servicio
- Cargol: fuera del VS (ver Personajes)

---

## 5. Vertical Slice — Scope

### Lo que el VS debe demostrar (canon 2026-09-01: domo criogénico)
1. El jugador se mueve y se siente bien (momentum, inercia, game feel refinado, 3ra persona)
2. Domo Criogénico: restaurar las 4 redes (criocoolant → energía → plasma → aire) para abrir el blast door
3. Hangar de mantenimiento (escena separada): puzzles físicos con cajas y cintas
4. Timeline de 8 beats, 10–16 min, de la llegada a la esclusa exterior
5. Core V2 con determinismo y replay funcional (todo componente nuevo es snapshot-able)
6. Props del vocabulario de máquinas (LeverV2, PipeValve, FusibleV2, PressurePump, PurgeTuner, LeakPatchPoint...)
7. Bridge de telemetría y Dashboard web (live ops; no bloquea el slice)

### Pendiente para el VS (En Desarrollo)
- T1–T8 de FD-289 (issue #319): DomeSystemDirector, BlastDoorController, HangarPlatform, cableado de redes, bakes de luz, test headless
- Diálogo IA Odisea mínimo (burocrática y evasiva; semilla OD-02)
- Level design final del hangar

### Lo que NO está en el VS
- Sigilo con DDC (recortado 2026-09-01 → backlog del Acto I, post-domo)
- Cargol (aparece en Transporte) · Multi-tool (se obtiene después de la esclusa)
- Actos II, III, IV · Cargol piloteable · Modo 2.5D · Cooperativo · Cómic / trailer · Medidor de integridad moral

### Punto final del VS (decidido 2026-09-01)
Elías restaura las 4 redes, el blast door se abre, desciende al hangar, resuelve los puzzles físicos y cruza la esclusa hacia el anillo exterior (`ScaffoldOrbit` / `OdiseaExterior`). Odisea no revela su agenda — solo se muestra burocrática y evasiva; la semilla de desconfianza (OD-02) queda plantada.

---

## 6. Entorno — Domo Criogénico (Departamento CriOps)

**Ubicación:** Popa de la nave.
**Estética:** "El Sepulcro Criogénico" — domo inmenso y oscuro, claustrofobia industrial, miles de criopods en anillos concéntricos alrededor de la Subestación de Distribución, niebla cian, metal industrial. El traje naranja de Elías como único punto cálido.

**Estructura vertical (canon FD-289):**
1. **Anillo superior** — entrada + criopods; se ve el domo entero y el blast door abajo
2. **Nivel de máquinas** — las 4 redes se cruzan a la vista (cian/ámbar/blanco-rojo/verde)
3. **Subestación de Distribución Térmica y Eléctrica** — columna central del domo; regula coolant/energía/plasma/aire que llegan por arterias desde el reactor principal (núcleo profundo, Z=4,000 m — ver `Diseno/Narrativa/Subdomo_Autosuficiente.md`); SCRAM local si falta refrigeración
4. **Blast door** — trampilla de piso (no corredera vertical); su luz de borde es el semáforo de progreso (rojo → ámbar → verde)
5. **Hangar de mantenimiento** (escena separada, `change_scene`) — cajas empujables + cintas transportadoras
6. **Esclusa exterior** — única frontera presurizado→vacío

Detalle completo: `Diseno/Narrativa/Locacion_Criogenia.md` + FD-289 (repo del juego). `Dome_Crio.tscn` es legacy — no se reutiliza.

---

## 7. Amenazas (Acto I)

Todas son sistemas de la nave reprogramados por la IA, no enemigos "vivos". **En el Vertical Slice no hay enemigo activo** (decidido 2026-09-01): la amenaza es ambiental.

| Amenaza | Comportamiento | Notas |
|---------|---------------|-------|
| SCRAM de la subestación | Sin coolant → bus cae → domo a oscuras | Presión del timeline, no daña |
| Fugas (coolant/plasma/gas) | Niebla ciega, chorro térmico, arcos eléctricos (cajas E-9 mojadas) | Se reparan con el vocabulario de máquinas |
| Blowout de presión | Apaga extractores, humo, visibilidad reducida | `TremorZoneV2` + `WindTunnelV2` |
| DDC | Patrulla, detecta, sella zona | Backlog post-slice (resto del Acto I) |
| Brazos robóticos | Lentos, predecibles, aplastan | Ambiental, módulos posteriores |

---

## 8. Estilo Visual

- Low-poly con flat shading, geometría visible
- Paleta: azul cian (cápsulas), gris oscuro (metal), naranja (Elías), rojo (amenazas)
- Niebla como herramienta de diseño (reduce visibilidad, crea tensión)
- Luces volumétricas y god rays como guías de navegación
- [DECIDIR: Resolución/polígono objetivo — PS1/N64, Switch, o intermedio]

---

## 9. Decisiones Pendientes

| # | Decisión | Contexto |
|---|----------|---------|
| 1 | Gravedad variable en VS | Dirección: momentum + física visceral. No bloquea el domo (gravedad 1G canónica en CriOps) |
| 2 | DDC — modelo y comportamiento | Solo al retomar el DDC (backlog): waypoints+raycast vs IA entrenada "Ana" (riesgo determinismo Core V2) |
| 3 | Resolución visual objetivo | Polígonos, shader, nivel de detalle |
| 4 | Alcance de la física | ¿Cuántas mecánicas dependen del motor de física? |
| 5 | Interacción narrativa | ¿Voz de Odisea? ¿Textos? ¿Cuánto diálogo es demasiado? |
| 6 | OG tags HTML5 (PR #300) | Requiere re-export para vivir en producción — ¿ahora o backlog? |
| 7 | Valores del Anexo GDD-LOG-282 | Probabilidades/frecuencias de cajas vs diseño de puzzles del hangar |

---

## 10. Qué NO es este juego (restricciones)

- No es un shooter
- No es un juego de combate
- No es un roguelike
- No tiene minijuegos aislados — los puzzles de reparación son diegéticos: máquinas reales del domo, un verbo por máquina (FD-289 §3.4)
- No tiene sistema de inventario complejo
- No tiene multiplayer
- No tiene árboles de habilidades / RPG progression
