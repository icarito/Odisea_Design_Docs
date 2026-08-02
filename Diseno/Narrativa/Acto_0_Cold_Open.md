---
title: "Acto 0: El Cold Open — La Fuga"
status: draft
acto: "0 — Prólogo / Flash-forward"
relacionado: [Pilares, Acto_I_La_Negacion, feature_sidescroller_zone, Personaje_Elias, Personaje_IA_Odisea]
convencion: "Las decisiones abiertas se marcan como [DECIDIR], igual que el resto del GDD."
---

# Acto 0: El Cold Open — La Fuga

**Título de la Escena:** [DECIDIR] — candidatos: "La Fuga", "El Pasillo en Llamas", "Despertar Forzado".
**Locación:** Bahía de mantenimiento / pasillo de servicio (sección no especificada de la nave).
**Duración objetivo:** ~2–3 minutos.

> Prólogo jugable de alta tensión. Rompe el arranque atmosférico tradicional y establece el conflicto central *por experiencia, no por exposición*. Termina en fundido a negro y empalma con el despertar criogénico del Acto I.

## Objetivo Narrativo

Enganchar al jugador con una secuencia puramente cinética que entregue la **promesa de género honesta** de los Pilares: tensión, claustrofobia y sistemas hostiles — **no** un run-and-gun. El jugador *experimenta* que la nave es un entorno mortal antes de que el juego baje el ritmo en el Acto I.

**Ambigüedad preservada (crítico).** Odisea **no aparece** en esta escena como causa visible del desastre. El jugador ve catástrofe y huida, pero no quién o qué la provoca. Esto protege el motor del Acto I (la IA *parece* benéfica y se gana la confianza antes del reveal) y permite que el Cold Open se **recontextualice** más tarde.

**Gancho de continuidad.** Al despertar en el Acto I, Odisea puede insinuar el evento sin confirmarlo — p. ej.: *"Detecté que estuviste activo de nuevo."* Deja abierto si fue un flash-forward, un sueño, o un evento real que ella causó/monitoreó.

## Formato y Jugabilidad

Runner 2.5D en **cámara desde atrás** (tercera persona, persecución). **No** es side-scroller lateral y **no** es estilo Zaxxon (sin vuelo axonométrico, sin disparo).

Elías ya está en movimiento; el jugador no recibe tutorial — las acciones son mínimas y se aprenden en el acto.

El control alterna entre **dos modos**, disparado por el estado de gravedad del entorno:

### Modo 1 — Carrera (gravedad normal)

- Elías corre hacia adelante en automático.
- Jugador controla: **salto** y **esquive** (2 grados de libertad).
- Amenazas: geometría colapsante, fugas de gas, explosiones a su espalda.

### Modo 2 — Flotación con jetpack (gravedad caída)

- Al cruzar una zona sin gravedad, Elías flota y activa el jetpack automáticamente.
- Jugador controla la navegación en el aire, **limitada a 2 ejes** (no son los 6 grados de libertad completos del controlador). Esquivar, no piruetear.
- La transición de vuelta a gravedad normal devuelve a Modo 1.

> **Nota técnica para implementación.** El Modo 1 mapea bien al sistema 2.5D existente (`feature_sidescroller_zone`: restricción a plano, determinista, integrado a snapshot/replay). El **Modo 2 (jetpack 0G, 2 ejes libres) es neto-nuevo**: el spec actual restringe a un plano 2D, no contempla navegación volumétrica libre. Tratar como feature aparte, no asumir que sale del sidescroller existente.

**Contexto sin exposición.** Anuncios de sistema durante la corrida dan el porqué del cambio de modo: *"Fallo de gravedad detectado"*, *"Mecanismos de gravedad comprometidos"*. La voz es de sistema, **no** de Odisea (mantener ambigüedad).

## Estética y Efectos

Coherente con el Acto I: look retro-futurista low-poly, `flipbook_particles`.

- Fugas de gas / plasma (cian denso, chispas).
- Explosiones y distorsión a espaldas del jugador.
- Alarmas fijas y luces de emergencia (neón/niebla, on-brand con los Pilares).
- En 0G: partículas y debris flotando, para vender el cambio de gravedad.

## Estructura de la Secuencia

Segmentación propuesta (sujeta a `[DECIDIR]` de checkpoints):

1. **Carrera inicial** — gravedad normal, esquivar fugas de gas y escombros.
2. **Colapso de estructura** — la gravedad falla; transición a jetpack.
3. **Navegación aérea** — esquivar debris flotante en 0G (Modo 2).
4. **Clímax: la esclusa** — ver abajo.

## Clímax del Acto

Elías se desliza por una esclusa de aire **justo antes de que se selle**, escapando de una explosión en la bahía. En el momento de máximo pulso, **corte a negro** y aparece el título. Le sigue el **silencio absoluto** del Sepulcro Criogénico (empalme directo con el Acto I).

El contraste de ritmo es deliberado: la quietud del Acto I no debe leerse como falta de contenido, sino como **tensión por quietud acumulada** tras el caos del prólogo.

## Decisiones Abiertas

| # | Decisión | Opciones | Inclinación |
|---|----------|----------|-------------|
| 1 | Esquema de checkpoints / muerte | **A:** una sola corrida, muerte = reinicio total (puro castigo, "Odisea quiere que mueras aquí"). **B:** checkpoints por segmento, reintentás solo el tramo (aprendizaje progresivo). | [DECIDIR] |
| 2 | ~~Topología del pasillo~~ | **DECIDIDO: lineal, sin ramificación.** Una sola ruta, puro cinético. | ✅ Cerrado |
| 3 | Título de la escena | "La Fuga" / "El Pasillo en Llamas" / "Despertar Forzado" | [DECIDIR] |
| 4 | Ubicación temporal del flash-forward | ¿Qué tan adelante en la línea temporal ocurre? Define el pagaré narrativo (el jugador esperará jugar hasta/más allá de este momento). | [DECIDIR] |
| 5 | Modo 2 (jetpack 0G) como feature | Confirmar que se trata como feature neto-nuevo con su propia spec, no como extensión del side-scroller 2.5D. | [DECIDIR] |

## Edición relacionada (fuera de este archivo)

En `Acto_I_La_Negacion` (o el doc del despertar criogénico): agregar la línea de Odisea que insinúa el evento del Cold Open sin confirmarlo (gancho de continuidad). Ubicación sugerida: primer diálogo de la IA al despertar Elías.
