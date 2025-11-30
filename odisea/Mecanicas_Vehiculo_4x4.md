# Mecánicas del Vehículo 4x4 (Terrestre)

El vehículo 4x4 es la solución de Elías para atravesar las enormes distancias a nivel de "suelo" en secciones como las Bio-Granjas (Acto II), donde caminar sería demasiado lento.

## Descripción Funcional

*   **Conducción Arcade**: El control es estable y fácil de manejar, no una simulación realista. Tiene buena tracción y un botón de turbo para impulsos de velocidad.
*   **Adaptable a la Gravedad**: El vehículo está diseñado para adherirse a las superficies, permitiendo conducir por las paredes o techos de los módulos rotatorios cuando la gravedad cambia.
*   **Salto Vehicular**: El turbo también puede usarse para realizar pequeños saltos, permitiendo superar huecos y participar en secuencias de plataformas ligeras.
*   **Fragilidad**: El vehículo no es indestructible. Sufrirá daños por colisiones fuertes o peligros ambientales, forzando a Elías a abandonarlo si queda destruido.

## Usos en el Juego

1.  **Exploración a Gran Escala**: Su uso principal es cubrir rápidamente las vastas áreas de los Módulos Rotatorios y las salas de mantenimiento más grandes.
2.  **Secuencias de Escape**: La IA puede provocar derrumbes o activar amenazas, iniciando secuencias de escape donde Elías debe conducir a toda velocidad, realizando saltos precisos para no ser atrapado.
3.  **Ruta Directa y Peligrosa**: El camino diseñado para el 4x4 suele ser el más rápido, pero también el que la IA vigila más, llenándolo de obstáculos móviles y trampas.

---

### Nota de Diseño: Implementación y Referencias

El vehículo debe sentirse como una extensión del movimiento de Elías, no como un modo de juego completamente separado. La transición entre entrar y salir del vehículo debe ser instantánea.

*   **Sugerencia de Implementación**: Usar el sistema `WheelCollider` de Unity o un sistema de físicas de vehículos similar, pero con parámetros muy "arcade" (alta adherencia, mucho torque). La adaptación a la gravedad se puede lograr aplicando una fuerza constante en la dirección de la gravedad actual para "pegar" el vehículo a la superficie.

*   **Referencias de Juegos (Vehículos en Plataformeros):**
    *   **Halo: Combat Evolved (El Warthog)**: El estándar de oro para la sensación de un vehículo arcade divertido y con físicas satisfactorias. La sensación de derrape y salto del Warthog es icónica.
    *   **Uncharted 4 / The Lost Legacy**: Sus secuencias de conducción con el 4x4 son una referencia perfecta para integrar la exploración en vehículo con secciones a pie y secuencias de acción cinemáticas.
    *   **Jak 3**: Ofrecía una gran variedad de vehículos en un mundo abierto, con un excelente equilibrio entre exploración y combate vehicular.