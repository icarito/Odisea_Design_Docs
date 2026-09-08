# El Subdomo Autosuficiente — Decisión de diseño (2026-09-08)

> **Estado:** canon propuesto por Sebastián (adoptado en GDD_v3 §6). Reconciliación
> técnica pendiente en FD-289 (ver "Deuda de reconciliación"). Assets derivados:
> icarito/Odisea#321 · licencias: #322 · tracker VS: #319.

## La decisión

**El reactor principal NO está en el centro del Domo Criogénico.** Colocar un reactor
de fusión en el centro geométrico de miles de colonos dormidos es pésima práctica
industrial (incluso con Helio-3 limpio) y genera desconfianza psicológica injustificada
en el diseño de la nave.

- El reactor vive en el **núcleo profundo de la nave (Z = 4,000 m)**.
- Cada domo es un **subdomo autosuficiente**: plantilla estanca que puede cerrarse y
  sobrevivir independiente si otra sección colapsa ("minimizar puntos de falla únicos").
- Lo que hay en el centro del domo es una **Subestación de Distribución Térmica y
  Eléctrica**: canaliza y regula localmente el Criocoolant (cian) y la Energía (verde)
  que llegan por las arterias desde el núcleo profundo.

**El gameplay no cambia:** las 4 redes (coolant → energía → plasma → aire), el SCRAM
por falta de refrigeración y el blast door siguen siendo el corazón del slice. Lo que
cambia es la justificación física: la subestación *distribuye y regula*, no *genera*.

## La Zona de Guardia (área civil del subdomo)

Contraste emocional deliberado: del cian clínico monumental de los anillos de criopods
a la calidez utilitaria tungsteno del área de guardia abandonada. Inventario de áreas:

1. **Bunks de guardia** — literas empotradas estilo submarino + taquillas con efectos
   personales. Narrativa ambiental del abandono (tazas a medio tomar, pertenencias).
2. **Med Bay / cabinas de estabilización post-criogénica** — cunas de reanimación
   inclinadas, lámparas infrarrojas, dispensador de electrolitos.
3. **Dispensadores de nutrientes** — consolas empotradas de raciones.
4. **Duchas de descontaminación húmeda** — cubículos hermeticos, transición traje
   sucio (Criocoolant) → zonas limpias.
5. **Maquinaria local** — depuradoras de condensación de ciclo cerrado, absorbedores
   de CO₂ (hidróxido de litio), compresores de vacío/alivio de presión.
6. **Mantenimiento** — armario de suministros (jaula naranja, racks de fusibles),
   scrap chute al hangar [DECIDIR].

Assets completos con prioridad VS/DRESS: **#321**.

## Uso narrativo: la voz de Odisea en la Zona de Guardia

El espacio humano vacío es el lienzo para la primera maniobra psicológica real:
Odisea usa los altavoces de los Bunks con voz suave — *"no hay necesidad de ir al
hangar… las raciones están listas, puede tomar un descanso eterno en un bunk seguro"*.
Contraste voz cálida / lugar fantasmal = la semilla de duda (compone con OD-02).

## Deuda de reconciliación

- [ ] **FD-289** (repo juego): la "columna del reactor" central del domo pasa a ser la
      Subestación de Distribución. Actualizar spec antes de T6/T7 (el wiring de señales
      no cambia, sí la descripción del nivel y los modelos).
- [ ] `Diseno/Narrativa/Locacion_Criogenia.md` §"Reactor central" → "Subestación de
      Distribución" (layout vertical, ítem 3).
- [ ] Anexo_Logistica_Solidos_y_Fluidos: confirmar que el rig de cajas/cintas del
      hangar no asume el reactor arriba.
