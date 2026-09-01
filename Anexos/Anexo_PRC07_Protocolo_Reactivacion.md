# PRC-07 — Protocolo de Reactivación Post-Criogénica

> ⚠️ **SUPERSEDED (2026-09-01).** Este protocolo describe la secuencia del módulo
> criogénico **plano** (consola Sala A → gap → push box → lever → esclusa), un diseño
> anterior. El canon actual es la restauración de las **4 redes del domo** + el descenso
> al **hangar** como escena separada. Ver [[Locacion_Criogenia]] y
> `docs/features/FD-289_dome_systems_canon.md` (repo del juego). Se conserva por historial.

---

**Fecha**: Junio 2026  
**Estado**: Spec completa  
**Propósito**: Secuencia guía para los primeros ~6-8 minutos del Vertical Slice

---

## 1. Resumen

Elías despierta en su cápsula criogénica dentro del Módulo Criogenia (CriOps). Sin multi-tool aún. El tutorial enseña: confirmar UI, moverse, leer el entorno, interactuar con consolas, saltar, trepar, empujar objetos.

La multi-tool se encuentra después de salir del módulo Criogenia.

---

## 2. Secuencia paso a paso

### Fase 1: Despertar (0:00 - 0:30)
1. **Cápsula se abre** — transición de negro a pantalla de estado.
2. **UI tutorial**: "Presiona [WASD] para moverte" + "Presiona [E] para interactuar".
3. Elías sale de la cápsula. La sala está en penumbra, solo iluminada por criopods.
4. **Lore beat**: Display de cápsula muestra "No se detecta actividad de red. Último reporte: hace 11 meses."
5. Odisea IA (primer contacto) — fría, dismissiva: "No se requiere supervisión adicional. Proceda con la reactivación estándar."

### Fase 2: Diagnóstico (0:30 - 2:00)
1. Elías camina hacia la **Consola Sala A** (TableTerminal).
2. Tutorial: "[E] para interactuar". Pantalla muestra OD-02 en estado crítico, respaldo sin energía.
3. Odisea interrumpe: "El sensor OD-02 es intermitente. Marcado por precaución. No es prioritario."
4. **Decisión de diseño**: Odisea miente. El jugador no lo sabe aún.
5. Consola indica: activar energía auxiliar en Sala B.
6. Puerta A-7 (salida) está sellada: "BLOQUEO DE SEGURIDAD — ENERGÍA AUXILIAR REQUERIDA".

### Fase 3: Gap + Sala B (2:00 - 4:00)
1. Elías cruza hacia Sala B por un **gap corto** (1.5m de ancho). Sin muerte por caída.
2. Tutorial salto: "[SPACE] para saltar". Plataforma al otro lado.
3. **Checkpoint #1**: Al llegar a Sala B.
4. Sala B parcialmente bloqueada por **escombros** con una caja metálica encajada.
5. Tutorial empujar: "[E] + mover para empujar". Elías mueve la PushableBox.
6. Escombros despejados, revelando un **Lever vertical** con letrero: "ENERGÍA AUXILIAR".
7. Tutorial: "[E] para accionar". Sonido industrial, luces parpadean, la sala se energiza.

### Fase 4: Retorno + Escape (4:00 - 6:00)
1. Elías vuelve a Sala A. Los sistemas están parcialmente activos.
2. **Fugas de gas** aparecen en pasillos laterales (LeakEmitter) — obstáculo ambiental, no dañino.
3. Opcional: Elías puede detener las fugas con PedestalButton (si decide explorar).
4. Puerta A-7 ahora desbloqueada. Letrero "SALIDA" iluminado.
5. **Checkpoint #2**: Antes de la esclusa.
6. Esclusa se abre. Transición a exterior.
7. **Pantalla de carga / fade out**: "Módulo Criogenia — Sistemas reactivados. Próximo destino: Sección de Transporte."

---

## 3. Mecánicas enseñadas en orden

| Orden | Mecánica | Cómo se enseña |
|-------|----------|----------------|
| 1 | Moverse (WASD) | Tutorial UI al despertar |
| 2 | Interactuar (E) | Consola Sala A |
| 3 | Saltar (Space) | Gap a Sala B |
| 4 | Empujar objetos (E+mover) | PushableBox en Sala B |
| 5 | Accionar palanca (E) | Lever energía auxiliar |
| 6 | (Opcional) Botón de pie (E) | PedestalButton en fugas de gas |

---

## 4. Lore beats durante la secuencia

| Momento | Beat |
|---------|------|
| Display cápsula | "No se detecta actividad de red. Último reporte: hace 11 meses." |
| Primer contacto Odisea | "No se requiere supervisión adicional." (fría, dismissiva) |
| Consola OD-02 | Odisea lo descarta como sensor intermitente |
| Lever activado | Letrero industrial minimal: "ENERGÍA AUXILIAR" |
| Esclusa | Sonido de despresurización, luces rojas → verdes |

---

## 5. Notas de diseño

- Sin multi-tool en todo el módulo. Se obtiene después.
- Cargol no aparece aún. Primer encuentro en sección de transporte.
- Sin DDC en esta sección. La tensión es ambiental, no de combate/sigilo.
- La mentira de Odisea sobre OD-02 es la primera semilla de desconfianza.
- El jugador no sabe que despertó 11 meses después de lo programado.
