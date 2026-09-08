# VS Checklist — Vertical Slice: Domo Criogénico (Acto I)

> **Fecha:** 2026-09-08 · **Dueño:** Sebastián + Odiseo
> **Fuente canónica:** FD-289 (repo Odisea) · cambios de diseño 2026-09-01 ·
> Anexo_Logistica_Solidos_y_Fluidos (GDD-LOG-282)
> **Cómo se usa:** los ítems se marcan `[x]` con fecha al cerrar. Lo que emerge durante
> el trabajo y no cabe en el VS va directo a §8 Backlog, sin discusión. Meta: terminar
> el slice de 8 beats (10–16 min).

## 1. Motor de sistemas del domo (FD-289 T1–T2)

- [ ] T1 `DomeNetworkStatus` + `DomeEnvConfig` (.tres a mano) — 30-60 min
- [ ] T2 `DomeSystemDirector` (autoload, máquina de beats, snapshot-able) — 1-2 h

## 2. Compuerta + descenso (T3, T5)

- [ ] T3 `BlastDoorController` sobre `FloorHatch.tscn` a escala hangar + modelos nuevos
      (paneles, bisagras, sellos, luces de borde) — 3 h
- [ ] `HangarPlatform` (TOP/DESCENDING/BOTTOM, snapshot-able, grupo `replay_sync`)
- [ ] Rampa de servicio estática paralela en el pozo
- [ ] T5 `FusibleV2` (HoldInteractableV2 con socket, verbo extraer/insertar) — 1 h

## 3. Hangar (T4) + logística de sólidos

- [ ] T4 Blockout `Dome_Intro_Hangar.tscn` (2 niveles, spawn `from_dome_intro_platform`,
      esclusa de salida) — 2-3 h
- [ ] Puzzles físicos: `PushableBoxV2` (tapar respiradero, placa de presión, puente) +
      `Conveyor` (mover caja pesada, desplazar al jugador)
- [ ] Cajas Tipo S (1.2 m / 80 kg) y Tipo H (2.4 m / 250 kg) según Anexo GDD-LOG-282 §3
- [ ] Inyector `HangarSpawner` determinista (seed 42, matriz de clases §4) + test de
      frecuencias/probabilidades en replay

## 4. Cableado de redes al domo real (T6–T7)

- [ ] T6 Criocoolant + Plasma: fugas, tanque, válvulas, parches en el nivel de máquinas
      de `Dome_Intro`; señales → `DomeNetworkStatus` — 2-3 h
- [ ] T7 Energía + Aire: bus, paneles, bomba, purga, manómetros; bus → blast door — 2-3 h
- [ ] Bakes de luz `Dome_Intro_dark.lmbake` + `Dome_Intro_full.lmbake` (estados OSCURAS/BAJO/PLENO)

## 5. Integración y cierre (T8)

- [ ] T8 Test headless del ciclo completo beats 1→8 + snapshot/restore — 2 h
- [ ] Sin regresiones en los 133+ tests (`./runtest.sh -a ./core_v2/tests/`)
- [ ] Playtest del timeline completo: 10-16 min, legibilidad de la ruta crítica
- [ ] CREDITS.md: confirmar origen de música/SFX restantes

## 6. PRs y trabajo en curso (merge SOLO con OK de Sebastián)

- [ ] #315 FD-285 fixtures de luz (studs + vidrio sconce) — review por chunks
- [ ] #318 FD-288 TremorZoneV2 (DRAFT — necesaria para beats 6 y feedback)
- [ ] #308 Integración audio FD-275/277/278/279 — decidir destino
- [ ] Barrido de PRs stale (301, 303-307, 300, 297, 298...): cerrar, reactivar o archivar
- [ ] Sesiones Jules activas (FD-263/264/271/280): seguir hasta PR o cierre

## 7. Decisiones pendientes (bloquean o cambian scope)

- [ ] Walker DDC: entrenar con "Ana" vs waypoint+raycast (riesgo determinismo Core V2)
- [ ] OG tags PR #300: requiere re-export HTML5 para vivir en producción — ¿ahora o backlog?
- [ ] Validar valores del Anexo GDD-LOG-282 (probabilidades/frecuencias de cajas) contra
      el diseño de puzzles del hangar — es backlog de assets, no spec cerrada

## 8. Backlog (fuera del VS — no tocar)

- Sigilo + patrulla DDC · Cargol · Multi-tool (recortados 2026-09-01)
- Actos II–IV · modo 2.5D · cooperativo · cómic · trailer
- Ductos de vacío/metano y agua pesada como sistemas simulados (quedan como lore/ambientación)
