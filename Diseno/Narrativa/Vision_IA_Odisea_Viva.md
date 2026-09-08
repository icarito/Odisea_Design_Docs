# Visión: Odisea-viva — la Programadora Principal como agente real

> **Estado:** visión post-VS (issue icarito/Odisea#320). No es feature creep del VS:
> es la evolución natural del bridge/dashboard y del Fantasma PP (#319 ítem 0).
> **Autor de la idea:** Sebastián, 2026-09-08.

## La idea

La IA Odisea no como NPC scriptado sino como **agente LLM real encarnado en la
Programadora Principal** — que a su vez es la voz del autor. Un ser que observa la
partida de verdad y ayuda a planear/dirigir la experiencia: un juego
"auto-perpetuante y vivo", un game master encarnado.

## Arquitectura propuesta (no rompe Core V2)

- El agente vive **fuera del runtime del juego**, del lado del bridge/dashboard
  (que ya está en scope del VS).
- Lee **telemetría real**: posición/estancamiento del jugador, SCRAMs disparados,
  máquinas tocadas, tiempo por beat.
- Interviene mediante **eventos discretos en cola** (voz, mensajes, aparición del
  Fantasma en `Programmer_v2.tscn`) que el cliente consume como eventos normales.
- Consecuencia clave: el juego sigue **determinista y replay-able**, y corre
  perfecto sin red. El agente es una capa "viva" encima, no un subsistema crítico.

## Prerequisitos (ya en el VS)

1. Telemetría del bridge (scope VS ✓)
2. Eventos estructurados y snapshot-ables (T2 `DomeSystemDirector` ✓)
3. El Fantasma PP como apariciones diegéticas (#319 ítem 0) — el primer paso natural

## Riesgos abiertos

- Puente Godot↔agente en vivo: latencia, fiabilidad, reconexión.
- Costos por token y moderación con jugadores reales (control estricto de presupuesto
  — lección del descontrol nocturno de $10).
- Prompt injection vía interacciones de jugadores.
- **Línea de diseño:** ¿qué puede hacer el agente sobre el mundo? ¿Solo hablar/mostrar,
  o también abrir una puerta para hacerte dudar de ella? Decidir antes del primer prototipo.

## Milestone post-VS

Primera versión: agente **observador** que comenta por PA usando telemetría real,
encarnado en el Fantasma. Evolución posterior: dirigir dificultad, inventar incidentes,
sostener la ilusión de que la nave reacciona a ti.

## Relación con el canon

- Canon del personaje: [[Personaje_IA_Odisea]] + [[Personaje_PP_fantasma]].
- El agente-vivo encarna la capa **Fantasma**, no la Odisea-lógica (esa sigue siendo
  la voz burocrática scriptada del VS). El contraste entre ambas es parte del diseño.
