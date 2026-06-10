# Locación: Módulos de Criogenia — Acto I

*   **Tema / Estética**: "El Sepulcro Criogénico". Claustrofobia industrial, tuberías expuestas, luces de estado de cápsulas, sentido de escala opresivo.
*   **Mecánica Principal**: [[Mecanicas_Controlador_Elias|Gravedad 1G]] constante. Plataformeo de precisión + puzzle de energía.
*   **Departamento**: CriOps (Cryogenic Operations).

## Layout (actualizado junio 2026)

### Tres niveles verticales
1. **Planta baja** — Fila de criopods con cápsula de Elías (RadialScatter). Suelo de rejilla metálica. Consolas de monitoreo. Puerta A-7 (sellada) al exterior.
2. **Entrepiso** — Pasarela perimetral con vista a la sala principal. Acceso a Sala B (consola de energía auxiliar). Rampa de escombros como conexión vertical.
3. **Pasarela superior** — Tuberías, paneles de control secundarios. Acceso a esclusa hacia exterior.

### Conexiones
- **Sala A → Gap corto → Sala B**: El gap no tiene muerte por caída (plataforma al otro lado).
- **Rampa fija de escombros**: Única conexión vertical (sin escaleras ni ascensores en este módulo).
- **Fugas de gas**: LeakEmitter en pasillos laterales. Se detienen con PedestalButton.
- **Puerta A-7**: Sellada hasta activar energía auxiliar.

### Puntos de interés
- **Cápsula de Elías**: Fila de criopods, display con falso optimismo — "No se detecta actividad de red".
- **Consola Sala A**: Muestra OD-02 crítico, respaldo sin energía. Odisea afirma que es sensor intermitente.
- **PushableBox**: Para despejar escombros en Sala B.
- **Lever (ENERGÍA AUXILIAR)**: Letrero industrial minimal en placa física.
- **Esclusa**: Conexión al exterior del módulo, hacia sección rotatoria.

## Puzzle principal
1. TableTerminal Sala A → OD-02 crítico, respaldo sin energía.
2. Cruzar gap corto → Sala B.
3. Empujar PushableBox para despejar escombros.
4. Accionar Lever vertical → energía auxiliar activada.
5. Volver a Sala A → puerta A-7 desbloqueada.
6. Cruzar esclusa → exterior.

## Lore ambiental
- Último reporte de tripulación: hace 11 meses.
- Red de la nave: sin actividad desde el despertar de Elías.
- OD-02: Odisea miente, dice que es sensor intermitente marcado por precaución.
- Elías no sabe que despertó 11 meses después de lo programado.
- Módulos adyacentes reportan lectura cero, no se ha asignado personal.
- Sabotaje intencional (Elías no lo sabe aún).

## Props clave
- PipeValve, PipeSection, PipeCorner (válvulas y tuberías decorativas)
- LeverV2 (energía auxiliar)
- BrokenFloorPanel, WarningBarrier
- DataSlate (lore fragments)
- SteelPlate/Stack (escenografía)
- FireEmitter (copia de LeakEmitter con daño)
- RetractableBridge (futuro)

## Odisea IA — Primer contacto
- Fría, dismissiva, "no se requiere supervisión adicional".
- Miente sobre OD-02.
- No revela que Elías despertó tarde.

Parte de [[Acto_I_La_Negacion]].
