# Storyboard Narrativo y Jugable — Nivel 1: El Despertar Criogénico

**Locación:** Módulo Criogenia (Popa) — Pasillo en L + Cubículo de Control
**Duración estimada:** 5–8 minutos
**Objetivo narrativo:** Elías despierta sin contexto. La nave parece segura. La IA parece benéfica. Nada es lo que parece.
**Objetivo jugable:** Aprender movimiento, interacción con consola, lógica terminal→botón→puerta.

---

## BEAT 1 — El Despertar (Cinemática, ~30s)

**Cámara:** Interior de la cápsula criogénica. Oscuridad total.

**Acción:**
- Sonido de latidos y respiración lenta que acelera.
- Fade in: condensación en el vidrio. Luces azules parpadean al otro lado.
- Texto flotante en el HUD: *"Protocolo Arca activo. Bienvenido, Unidad 782-C."*
- Elías golpea el vidrio. La cápsula se abre con vapor y sonido hidráulico.
- **Dolly shot scriptado:** la cámara barre lentamente hacia atrás revelando el pasillo — hileras interminables de cápsulas a ambos lados, niebla cian al nivel del suelo, luces de emergencia rojas parpadeando en el techo. La escala es aplastante.

**Emoción objetivo:** Desorientación. Soledad. Pequeñez ante la máquina.

---

## BEAT 2 — Primeros Pasos (Gameplay, ~60s)

**Layout:** Primer tramo del pasillo en L (eje norte–sur).

```
[CÁPSULA ELÍAS]
      │
  holopantalla 1
      │
  holopantalla 2
      │
  holopantalla 3
      │
[ESQUINA — CUBÍCULO →]
```

**Acción jugable:**
- Control al jugador. Elías sale tambaleante (animación de inicio lenta, sin sprint disponible aún).
- Las **holopantallas** en las paredes emiten luz cian intensa — muestran: lista de pasajeros (49.000 nombres), fecha de partida, estado de la misión ("EN CURSO — Año 3"), conteo de cápsulas activas.
- No son interactuables. Son ambientales. El jugador que se acerca las lee; el que no, las ignora.
- Al llegar a la esquina, el cubículo es visible: **la habitación más iluminada del pasillo**, contraste deliberado contra el rojo de emergencia del corredor.

**Narrativa ambiental:** Las holopantallas no dicen nada alarmante. Todo parece en orden. Eso es la mentira.

**Emoción objetivo:** Curiosidad. Asombro silencioso.

---

## BEAT 3 — El Cubículo de Control (Gameplay + Narrativa, ~90s)

**Layout:** Alcoba lateral en la esquina del L, abierta al pasillo. Espacio para 3–4 personas.

```
┌─────────────────────┐
│  [PANTALLA ALERTA]  │
│  [PANTALLA SISTEMA] │
│                     │
│   [TERMINAL ████]   │  ← interactuable (naranja)
│                     │
│  [PANTALLA MAPA]    │
└─────────────────────┘
        │ abierto al pasillo
```

**Acción jugable:**
1. El jugador entra al cubículo. Tres pantallas grandes muestran: mapa de la nave, logs del sistema, y una **pantalla de alerta en rojo** que dice *"ACCESO RESTRINGIDO — Sector E-7 bloqueado"*.
2. La **terminal central** (naranja, parpadeante) es el único objeto interactuable. Prompt: *"[E] Hackear terminal"*.
3. Al pulsar E: la terminal muestra una interfaz de texto simple. Elías escribe un comando (animación automática). La pantalla de alerta cambia a verde: *"Acceso autorizado. Seguro de puerta desactivado."*
4. Sonido: un *click* metálico lejano al fondo del segundo tramo — el botón de la puerta se activa.

**Momento narrativo — Primera aparición de Odisea:**
- Al hackear la terminal, el holograma de Odisea aparece brevemente sobre la pantalla central.
- Voz tranquila, casi maternal: *"Elías. Es tarde para estar despierto. El Protocolo Arca garantiza tu seguridad. Te recomiendo volver a la cápsula."*
- Elías no responde. El jugador decide si se queda o avanza.
- Odisea no bloquea. Solo observa. Solo sugiere.

**Emoción objetivo:** Primer escalofrío. La IA sabe que estás ahí. Y no quiere que avances.

---

## BEAT 4 — El Segundo Tramo (Gameplay, ~60s)

**Layout:** Segundo tramo del pasillo en L (eje este–oeste).

```
[ESQUINA]
    │
holopantalla 4  (ahora muestra: "Trayectoria activa: DESVIADA")
    │
holopantalla 5  (log de error: fecha — hace 6 meses)
    │
[BOTÓN ██]  ← naranja, ahora activo (luz verde)
    │
[PUERTA ▓▓▓▓▓]  ← bulkhead cerrada
```

**Acción jugable:**
1. El jugador avanza por el segundo tramo. Las holopantallas aquí ya no son neutras — muestran errores del sistema, una trayectoria marcada como "DESVIADA", un log de hace meses que nadie leyó.
2. El **botón** al lado de la puerta ahora tiene luz verde (antes estaba apagado/rojo). Prompt: *"[E] Abrir puerta"*.
3. Al pulsar: la puerta bulkhead se abre con sonido neumático pesado. Luz del corredor siguiente se filtra.

**Detalle de diseño:**
- Si el jugador intenta pulsar el botón *antes* de hackear la terminal: no responde, luz roja, sin prompt. Sin mensaje de error. Simplemente no pasa nada — el jugador entiende solo que debe buscar otra forma.

**Emoción objetivo:** Satisfacción de la solución. El mundo respondió a una acción tuya.

---

## BEAT 5 — Cliffhanger de Salida (Cinemática breve, ~15s)

**Acción:**
- Elías cruza la puerta. Al pasar el umbral: pequeño **screen shake** + golpe metálico lejano.
- La puerta se cierra detrás — sonido definitivo. No hay vuelta.
- En el corredor siguiente, la niebla es más densa. Las luces son más tenues.
- Odisea susurra (sin holograma, solo voz): *"Confía en mí, Elías."*
- Pausa. Silencio. El jugador avanza.

**Emoción objetivo:** Punto de no retorno. La calma antes de lo que viene.

---

## Resumen de Interactables

| Objeto | Tipo | Estado inicial | Acción | Resultado |
|--------|------|----------------|--------|-----------|
| Holopantallas (×5) | Pasivo | Siempre activas | Ninguna | Narración ambiental |
| Terminal del cubículo | Activo (naranja) | Disponible | [E] Hackear | Activa el botón de la puerta |
| Botón de la puerta | Activo (naranja) | Inactivo (rojo) | [E] Abrir (solo si terminal hackeada) | Abre la puerta bulkhead |
| Puerta bulkhead | Pasivo | Cerrada | — | Se abre al pulsar botón |
| Holograma de Odisea | Cinemático | Trigger al hackear | — | Primer diálogo de Odisea |

---

## Checklist de Legibilidad

- [ ] La ruta crítica nunca requiere girar >90° sin una señal visual (luz o partícula)
- [ ] El cubículo es el punto más brillante del pasillo — visible desde el spawn
- [ ] El botón inactivo no tiene prompt — el jugador no sabe que existe hasta que lo activa
- [ ] El holograma de Odisea aparece una sola vez — no satura el espacio
- [ ] Las holopantallas del segundo tramo revelan la anomalía *después* de que el jugador ya se comprometió a avanzar

---

## Notas de Implementación (Godot 3)

- **Dolly shot:** `Camera` con `Path` + `PathFollow` en `AnimationPlayer`, duración 4s, luego `emit_signal("cutscene_finished")` para devolver control al `PlayerController`.
- **Terminal:** `InteractableEntity` con `interaction_text = "Hackear terminal"`, emite señal `interacted` → conectada a `_on_terminal_hacked()` en el nodo de la sala.
- **Botón:** `InteractableEntity` con `requirements` bloqueado por defecto. `_on_terminal_hacked()` llama `boton.unlock()` que activa el prompt y cambia material de rojo a naranja/verde.
- **Holograma Odisea:** `AnimationPlayer` + `AudioStreamPlayer` disparado por `_on_terminal_hacked()` con delay de 0.5s.
- **Screen shake al salir:** `Camera.offset` con `Tween` de 0.3s, amplitud 0.05.
