# Mecánicas del Controlador de Elías (Plataformas 3D)

El controlador de Elías es la base de la jugabilidad. Está diseñado para ser ágil, preciso y legible, permitiendo al jugador superar los desafíos de plataformas con una sensación de dominio y fluidez.

## Descripción Funcional

*   **Movimiento Ágil**: Elías se mueve con la agilidad de un plataformero clásico, con aceleración y desaceleración predecibles.
*   **Salto y Doble Salto**: El salto es la acción principal. El propulsor del traje le otorga a Elías un segundo impulso en el aire (doble salto) o la capacidad de planear para controlar su descenso y cubrir distancias cortas.
*   **Agarre de Bordes**: Elías puede agarrarse automáticamente a los bordes de las plataformas, lo que da un margen de error al jugador en saltos ajustados y permite la exploración vertical. (CUESTIONABLE; COMPLEJO...)
*   **Interacción Contextual**: Elías puede interactuar con objetos del entorno, como terminales, válvulas y su dron Cargol, usando un único botón de acción cuando está cerca de ellos.

## Usos en el Juego

1.  **Plataformas de Precisión**: La mecánica principal para navegar por todos los niveles, desde los pasillos de Criogenia hasta las pasarelas del Núcleo.
2.  **Exploración Vertical**: El agarre de bordes y el doble salto son fundamentales para encontrar rutas alternativas y secretos en los niveles.
3.  **Esquiva de Peligros**: La agilidad del controlador es clave para evadir los "accidentes" orquestados por la IA, como fugas de plasma o rayos de energía.

---

### Nota de Diseño: Implementación y Referencias

El "feel" del personaje es crucial. Se debe buscar un equilibrio entre el peso del personaje y la respuesta inmediata de los controles.

*   **Sugerencia de Implementación**: Utilizar un `Character Controller` basado en físicas, pero con fuerzas muy controladas y personalizadas para los saltos y el movimiento, en lugar de una simulación de `Rigidbody` pura que puede ser impredecible. El agarre de bordes puede implementarse con un sistema de `Raycast` o `Spherecast` desde el personaje.

*   **Referencias de Juegos (Control en Tercera Persona):**
    *   **Super Mario 64 / Super Mario Odyssey**: El estándar de oro para el control de plataformas 3D. Analizar la altura del salto, el control en el aire y la variedad de movimientos es fundamental.
    *   **Astro Bot Rescue Mission / Astro's Playroom**: Excelente ejemplo de un control de plataformas 3D moderno, preciso y extremadamente satisfactorio. Su uso del planeo con propulsores es una gran referencia.
    *   **The Legend of Zelda (Breath of the Wild / Tears of the Kingdom)**: Referencia clave para el sistema de agarre y escalada (aunque en Odisea sería más limitado al agarre de bordes) y la sensación general de exploración.