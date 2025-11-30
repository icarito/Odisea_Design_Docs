# Mecánicas del Propulsor 0G (6DOF)

El Propulsor 0G es una mecánica de movimiento clave para la exploración en las secciones de gravedad cero de la Odisea, principalmente en el **Acto III: El Desafío**. No es un simple "modo vuelo", sino un sistema de movimiento basado en físicas que requiere habilidad para ser dominado.

## Descripción Funcional

*   **Movimiento 6DOF (Seis Grados de Libertad)**: Elías puede impulsarse en cualquier dirección (adelante/atrás, arriba/abajo, izquierda/derecha) y rotar sobre sus ejes (guiñada, cabeceo, alabeo). Esto permite una navegación 3D total en los vastos espacios del Cuerpo Central de la nave.
*   **Modelo de Inercia**: El movimiento se basa en la inercia. Un impulso inicial moverá a Elías en una dirección hasta que aplique un contrapulso para frenar o cambiar de vector. Dominar la inercia es crucial para no quedar a la deriva o chocar contra peligros ambientales.
*   **Combustible Limitado**: El uso del propulsor consume un recurso (combustible/energía) que se regenera lentamente o en puntos de recarga específicos. Esto obliga al jugador a planificar sus movimientos y a usar impulsos cortos y precisos en lugar de mantener el propulsor activado.
*   **Autoestabilización**: Para reducir la frustración, el propulsor cuenta con un sistema de autoestabilización suave que detiene la rotación de Elías cuando el jugador no está aplicando ningún control, permitiéndole orientarse.

## Usos en el Juego

1.  **Navegación y Plataformas 3D**: Es la herramienta principal para atravesar las secciones de gravedad cero, moviéndose entre maquinaria flotante, esquivando arcos voltaicos y navegando por laberintos de tuberías.
2.  **Resolución de Puzzles**: Algunos puzzles requerirán que Elías se posicione en ángulos específicos en el espacio para activar terminales o redirigir energía.
3.  **Herramienta de "Combate"**: En el Acto III, el propulsor puede ser sobrecargado para generar un **pulso IEM de corto alcance**. Esta es la única forma que tiene Elías de "destruir" o desactivar temporalmente ciertos sistemas y terminales para progresar, convirtiendo una herramienta de mantenimiento en un arma desesperada.

---

### Nota de Diseño: Implementación y Rendimiento

El cálculo de físicas para un movimiento 6DOF con inercia puede ser **costoso para la CPU**, especialmente en entornos complejos. Se debe prestar atención a la optimización.

*   **Sugerencia de Implementación**: En lugar de una simulación física pura y compleja, se puede optar por un modelo **Kinemático con físicas aplicadas**. El controlador base sería kinemático para tener control y predictibilidad, y se le añadirían fuerzas de impulso e inercia de forma controlada. Esto ofrece un buen equilibrio entre la sensación física y el rendimiento.

*   **Referencias de Juegos (Tercera Persona 0G):**
    *   **Dead Space 2 & 3**: Es el referente principal para el movimiento 0G en tercera persona. Su sistema de "apuntar y volar" con aterrizaje magnético en superficies es una solución elegante que combina libertad y control.
    *   **Gravity Rush / Gravity Rush 2**: Aunque su mecánica es de "caída controlada" en lugar de propulsión, es un excelente ejemplo de movimiento 3D ágil y legible en tercera persona que rompe con la gravedad tradicional.
    *   **Astro Bot Rescue Mission**: Su control del propulsor, aunque más simple, es un gran ejemplo de precisión, inercia suave y sensación de control satisfactoria en un entorno 3D.

*   **Referencias (Primera Persona, para la sensación física):**
    *   **Hardspace: Shipbreaker**: Su simulación de inercia, agarre y movimiento con propulsores es de las mejores. Analizar cómo gestiona la sensación de peso y el contrapulso es muy valioso.
    *   **Prey (2017)**: Sus secciones de gravedad cero son un buen ejemplo de diseño de niveles no lineal en un entorno 3D completo.