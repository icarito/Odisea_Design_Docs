![[vehiculo_aereo_modelo.png]]
# Mecánicas del Vehículo Flotante/Aéreo

![[vehiculo_aereo_secundario.png]]

El vehículo aéreo es una herramienta de exploración avanzada que otorga a Elías la capacidad de navegar por grandes cámaras verticales o inundadas y zonas de gravedad cero sin depender de su propulsor personal.

## Descripción Funcional

*   **Vuelo con Inercia**: Similar al Propulsor 0G, el control se basa en la gestión de la inercia. Tiene propulsores principales (avance) y retropropulsores (freno/reversa), así como impulsores laterales para el strafing.
*   **Control de Vuelo Sofisticado**: Requiere más habilidad que el 4x4. El jugador debe gestionar la velocidad y la dirección para no chocar. Es el "Camino Indirecto/Sofisticado".
*   **Modo Acuático y Aéreo**: El vehículo funciona tanto en el aire de grandes cámaras como bajo el agua en el Laboratorio Acuático, manteniendo físicas similares.
*   **Vulnerabilidad a PEM**: Es especialmente vulnerable a los pulsos electromagnéticos que la IA genera, los cuales pueden apagar temporalmente los motores y hacer que el jugador pierda el control.

## Usos en el Juego

1.  **Navegación Vertical**: Indispensable para explorar los enormes pozos verticales del Cuerpo Central o las cámaras inundadas del Laboratorio Acuático.
2.  **Rutas de Alto Riesgo/Alta Recompensa**: Permite al jugador tomar atajos a través de zonas muy peligrosas, pero requiere un dominio preciso del control para esquivar obstáculos.
3.  **Puzzles de Entorno**: Algunas secciones pueden requerir el uso del vehículo para transportar un objeto o activar interruptores en lugares altos e inaccesibles.

---

### Nota de Diseño: Implementación y Referencias

La clave es que el vehículo se sienta potente pero requiera habilidad, recompensando a los jugadores que invierten tiempo en dominarlo.

*   **Sugerencia de Implementación**: Utilizar un `Rigidbody` y aplicar fuerzas (`AddForce`) para cada uno de los propulsores. Esto dará una sensación de inercia natural. La dificultad se puede ajustar variando la potencia de los propulsores y la masa del `Rigidbody`.

*   **Referencias de Juegos (Control de Vuelo/Submarino):**
    *   **Star Fox 64 (Modo All-Range)**: Un gran ejemplo de control de vuelo arcade en 360 grados dentro de una arena. La sensación de impulso y freno es una buena referencia.
    *   **Subnautica (Seamoth)**: Referencia perfecta para la sensación de exploración submarina en un vehículo pequeño y ágil. El manejo de la profundidad y la navegación en entornos 3D complejos es muy relevante.
    *   **Forspoken**: Aunque es un parkour mágico, el concepto de fluir por el aire a gran velocidad y mantener el momentum puede ser una inspiración para la sensación de movimiento del vehículo aéreo.