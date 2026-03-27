# GDD v3 — Odisea: El Arca Silenciosa

> Documento de Diseño de Juego. Minimalista. Solo decisiones confirmadas.
> Cosas sin decidir se marcan como `[DECIDIR]`.

---

## 1. Visión General

Odisea es un juego de plataformas 3D con puzzles y exploración. El jugador es Elías, un Oficial de Mantenimiento que despierta de criogenia en una nave intergaláctica controlada por una IA llamada Odisea. La nave ha sido saboteada. El jugador debe reparar sistemas, evitar amenazas y descubrir la verdad sobre la misión.

**Género:** Plataformas 3D / Aventura / Puzzles
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
Oficial de Mantenimiento. Traje naranja. Ágil, capaz de correr, saltar y usar herramientas. Despierta de criogenia sin recuerdos recientes.

### IA Odisea
Controla la nave. Comunica por voz, mensajes y efectos ambientales. Aparenta ser benevolente. Sus intenciones reales son ambiguas.

### Cargol (NPC asistente)
Dron compañero. Se mueve por conductos de ventilación y zonas angostas. El jugador puede darle órdenes simples (ir a un punto, activar un interruptor). No es piloteable.

### DDC — Drone de Diagnóstico Corrupto
Drone de seguridad reprogramado por la IA. Patrulla zonas y detecta al jugador. [DECIDIR: Forma final del modelo — disco hover por plasma, cuerpo compacto, sensor óptico. Ver concept art generados.]

---

## 4. Mecánicas del Jugador

### Movimiento
- Caminar, correr, saltar, doble salto
- Interactuar con objetos del entorno (tecla E)
- Usar herramienta de mantenimiento (puzzle de reparación)

### Física y Momentum
- Conservación de momentum en movimiento
- Movimientos pendulares y aceleración mecánica
- [DECIDIR: ¿Se incluye gravedad variable en el VS? Posible combinación con momentum — gravedad fluctuante que amplifica la sensación física]

### Sigilo
- Zonas patrulladas por DDC
- Detección → alarma → zona sellada → puzzle de realineación bajo tiempo
- No hay combate directo

### Puzzles
- Activación de consolas en secuencia
- Uso de Cargol para zonas inaccesibles (órdenes simples)
- Objetos empujables / plataformas móviles
- [DECIDIR: Complejidad del puzzle de reparación — minijuego vs secuencia simple]

---

## 5. Vertical Slice — Scope

### Lo que el VS debe demostrar
1. El jugador se mueve y se siente bien (momentum, inercia, game feel)
2. Una sala con historia ambiental legible
3. Interacción básica (consolas, objetos)
4. Una zona de sigilo con DDC
5. Uso de Cargol como asistente
6. Al menos un puzzle
7. La voz de la IA Odisea manipulando al jugador

### Lo que NO está en el VS
- Actos II, III, IV
- Cargol piloteable
- Vehículos (4WD, nave)
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
- Paneles de reparación (puntos de puzzle)
- Conductos de ventilación (acceso Cargol)
- Zonas patrulladas por DDC

---

## 7. Amenazas (Acto I)

Todas son sistemas de la nave reprogramados por la IA, no enemigos "vivos".

| Amenaza | Comportamiento | Notas |
|---------|---------------|-------|
| DDC | Patrulla, detecta, sella zona | Enemigo principal del VS |
| Brazos robóticos | Lentos, predecibles, aplastan | Ambiental, no requiere sigilo |
| Torres de purga | Estáticas, gas frío, retienen | Trampa de área |

[DECIDIR: ¿Cuántas amenazas están en el VS? Probablemente solo DDC + una ambiental.]

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
| 2 | DDC — modelo final | Concept art listo. Falta decidir versión y complejidad |
| 3 | Puzzle de reparación | Minijuego vs secuencia simple |
| 4 | Amenazas en VS | ¿Solo DDC? ¿DDC + 1 ambiental? ¿3? |
| 5 | Punto final del VS | ¿Hasta dónde llega la demo? |
| 6 | Resolución visual objetivo | Polígonos, shader, nivel de detalle |
| 7 | Alcance de la física | ¿Cuántas mecánicas dependen del motor de física? |

---

## 10. Qué NO es este juego (restricciones)

- No es un shooter
- No es un juego de combate
- No es un roguelike
- No tiene sistema de inventario complejo
- No tiene multiplayer
- No tiene árboles de habilidades / RPG progression
