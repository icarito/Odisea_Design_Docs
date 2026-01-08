# Mecánicas de Gravedad Variable

La Gravedad Variable es una de las mecánicas centrales y un pilar de diseño de "Odisea". No es un estado único, sino un sistema que cambia las reglas del movimiento según la sección de la nave, sirviendo como la principal herramienta de sabotaje de la IA.

## Descripción Funcional

*   **Gravedad 1G (Estándar)**: Presente en los Módulos de Criogenia y los Módulos Rotatorios. Generada por fuerza centrífuga. El movimiento es el de un plataformero 3D tradicional.
*   **Gravedad Cero (0G / 6DOF)**: Presente en el Cuerpo Central. Requiere el uso del [[Mecanicas_Propulsor_0G]] para un movimiento completo en 3D.
*   **Gravedad Fluctuante**: Principalmente en las Bio-Granjas (Acto II). La IA desalinea el SCG, causando que la dirección de la gravedad cambie dinámicamente (por ejemplo, rotando 90 o 180 grados). Esto convierte paredes en suelos y techos en abismos.
*   **Gravedad Lineal**: En el Núcleo de la IA (Acto III), durante la Maniobra de Desvío. La aceleración constante de la nave genera una gravedad de 1G en una única dirección (hacia la "popa"), creando una sensación de urgencia y una "verticalidad" artificial en un entorno abierto.

## Usos en el Juego

1.  **Diseño de Puzzles**: Los puzzles de rotación en las Bio-Granjas se basan en manipular la gravedad para alinear plataformas y abrir nuevos caminos.
2.  **Desafío de Plataformas Dinámico**: La gravedad fluctuante crea secuencias de plataformas donde el jugador debe saltar y adaptarse a los cambios de "abajo" en mitad del aire.
3.  **Narrativa Ambiental**: Los cambios de gravedad son la manifestación más clara del control de la IA sobre el entorno. Un cambio brusco de gravedad es un acto de sabotaje directo.

---

### Nota de Diseño: Implementación y Referencias

El desafío técnico es hacer que el controlador del personaje se adapte de forma robusta y fluida a los cambios en el vector de gravedad.

*   **Sugerencia de Implementación**: El controlador de Elías no debe tener la gravedad "hardcodeada" hacia abajo (Vector3.down). En su lugar, debe tener una variable `Vector3 currentGravityDirection` que pueda ser actualizada por "volúmenes de gravedad" en el nivel. Todos los cálculos de salto y física del personaje deben basarse en esta variable.

*   **Referencias de Juegos (Manipulación de Gravedad):**
    *   **Super Mario Galaxy 1 & 2**: La obra maestra en diseño de niveles con gravedad variable y plataformas esféricas. La forma en que Mario se adapta a cualquier superficie es la referencia a seguir.
    *   **Gravity Rush 1 & 2**: Aunque el jugador controla la dirección de la gravedad, es un excelente estudio sobre cómo diseñar niveles y orientar al jugador en entornos donde "abajo" es relativo.
    *   **Portal 2**: Sus "embudos de luz" y geles son una forma de manipular la física y la trayectoria del jugador, similar a cómo la IA podría usar la gravedad en Odisea.