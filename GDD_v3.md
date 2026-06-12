# GDD v3 — Odisea: El Arca Silenciosa

> Documento de Diseño de Juego. Minimalista. Solo decisiones confirmadas.
> Cosas sin decidir se marcan como `[DECIDIR]`.

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

### DD
Drone de seguridad reprogramado por la IA. Patrulla zonas y detecta al jugador. [DECIDIR: Forma final del modelo — disco hover por plasma, cuerpo compacto, sensor óptico. Ver concept art generados.]

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

### Sigilo
- Zonas patrulladas por DD
- Detección → alarma → zona sellada
- No hay combate directo

### Interacción
- Activación de consolas y objetos del entorno
- Uso de Cargol para zonas inaccesibles (órdenes simples)
- [DECIDIR: Objetos empujables / plataformas móviles — ¿en el VS?]

---

## 5. Vertical Slice — Scope

### Lo que el VS debe demostrar
1. El jugador se mueve y se siente bien (momentum, inercia, game feel refinado)
2. Tres controladores funcionales: 3ra persona, 4WD, 0G (ZeroGravityController)
3. Módulo Criogenia: blockout completo (3 niveles, puzzle energía auxiliar, esclusa)
4. Bridge central de telemetría y Dashboard web (live tracking, heatmaps 3D)
5. Core V2 con determinismo y replay funcional
6. Props interactuables (LeverV2, PipeValve, DataSlate, etc.)

### Pendiente para el VS (En Desarrollo)
- Implementar sigilo con DD (patrulla, detección, zona sellada)
- Implementar Cargol como dron asistente
- Implementar multi-tool
- Puzzle de reparación
- Diálogos IA Odisea
- Level design final de salas post-criogenia

### Lo que NO está en el VS
- Actos II, III, IV
- Cargol piloteable
- Modo 2.5D
- Cooperativo
- Cómic / trailer
- Medidor de integridad moral

### [DECIDIR: Punto final del VS]
- Opción A: Restaurar energía + clímax de la IA (revelación del Mando Final)
- Opción B: Solo la primera sala funcional como demo técnica
- Opción C: [definir]

---

## 6. Entorno — Módulo Criogenia

**Ubicación:** Popa de la nave Odisea
**Estética:** Claustrofóbico. Pasillos estrechos. Miles de cápsulas criogénicas emitiendo luz azul cian. Metal gris oscuro. Niebla criogénica densa. Traje naranja de Elías como único punto cálido.

**Elementos clave:**
- Cápsulas criogénicas (props + iluminación)
- Consolas de datos (interactuables)
- Conductos de ventilación (acceso Cargol)
- Zonas patrulladas por DD

---

## 7. Amenazas (Acto I)

Todas son sistemas de la nave reprogramados por la IA, no enemigos "vivos".

| Amenaza | Comportamiento | Notas |
|---------|---------------|-------|
| DD | Patrulla, detecta, sella zona | Enemigo principal del VS |
| Brazos robóticos | Lentos, predecibles, aplastan | Ambiental, no requiere sigilo |

[DECIDIR: ¿Cuántas amenazas están en el VS? Probablemente solo DD + una ambiental.]

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
| 1 | Gravedad variable en VS | Dirección: momentum + física visceral. ¿Se suma gravedad fluctuante? |
| 2 | DD — modelo final | Concept art listo. Falta decidir versión y complejidad |
| 3 | Amenazas en VS | ¿Solo DD? ¿DD + 1 ambiental? ¿3? |
| 4 | Punto final del VS | ¿Hasta dónde llega la demo? |
| 5 | Resolución visual objetivo | Polígonos, shader, nivel de detalle |
| 6 | Alcance de la física | ¿Cuántas mecánicas dependen del motor de física? |
| 7 | Interacción narrativa | ¿Voz de Odisea? ¿Textos? ¿Cuánto diálogo es demasiado? |

---

## 10. Qué NO es este juego (restricciones)

- No es un shooter
- No es un juego de combate
- No es un roguelike
- No tiene puzzles de reparación / minijuegos
- No tiene sistema de inventario complejo
- No tiene multiplayer
- No tiene árboles de habilidades / RPG progression
