![[dron_cargol_modelo.png]]
# Mecánicas del Dron Cargol (Asistente Remoto)

![[dron_cargol_secundario.png]]

Cargol no es solo una herramienta, sino el compañero de Elías y un elemento central de la narrativa. Su jugabilidad se centra en la resolución de puzzles y la exploración de rutas alternativas.

## Descripción Funcional

*   **Control Remoto**: Elías puede detenerse y tomar el control directo de Cargol. La vista cambia a una cámara en tercera persona que sigue al dron.
*   **Vuelo y Acceso**: Cargol puede volar libremente (de forma similar al Propulsor 0G de Elías, pero más lento y ágil) y pasar por conductos de ventilación pequeños o grietas inaccesibles para el protagonista.
*   **Interacción a Distancia**: Equipado con brazos articulados, Cargol puede conectarse a paneles para hackearlos, activar interruptores o recoger objetos pequeños.
*   **Vulnerabilidad**: Cargol es vulnerable a ciertos peligros ambientales como la radiación o los pulsos electromagnéticos, lo que crea puzzles de tiempo donde debe completar una tarea antes de ser desactivado.

## Usos en el Juego

1.  **Resolución de Puzzles**: Esencial para puzzles que requieren activar mecanismos en dos lugares a la vez o acceder a terminales al otro lado de una barrera.
2.  **Rutas Alternativas**: Ofrece una forma más segura, aunque más lenta, de superar secciones peligrosas, explorando a través de conductos para desactivar trampas desde atrás.
3.  **Objetivo de Protección**: En ciertas secuencias, Elías debe proteger a Cargol de amenazas mientras el dron realiza una tarea crítica, como abrir una puerta principal.
4.  **Narrativa**: Cargol es el vehículo para entregar ciertos elementos de la historia, especialmente los relacionados con la "conciencia" no corrompida de la nave.

---

### Nota de Diseño: Implementación y Referencias

La transición entre el control de Elías y Cargol debe ser fluida e instantánea. El control de Cargol debe sentirse ligero y preciso.

*   **Sugerencia de Implementación**: Crear un "estado de control" para el jugador que pueda cambiar entre `PlayerController_Elias` y `PlayerController_Cargol`. Cuando se controla a Cargol, el modelo de Elías queda en estado de espera.

*   **Referencias de Juegos (Control de Compañero/Dron):**
    *   **Star Wars Jedi: Fallen Order / Survivor**: La interacción con BD-1 para hackear, escanear y resolver puzzles es una referencia directa y excelente.
    *   **The Legend of Zelda: The Wind Waker / Spirit Tracks**: El concepto de controlar a un segundo personaje (estatuas, Phantoms) para resolver puzzles cooperativos en solitario.
    *   **Ratchet & Clank: Rift Apart**: Las secciones de puzzle de Clank y los "glitches" de Rivet son buenos ejemplos de jugabilidad a pequeña escala que complementa la acción principal.