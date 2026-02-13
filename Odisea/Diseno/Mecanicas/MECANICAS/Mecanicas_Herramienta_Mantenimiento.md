# Mecánicas de la Herramienta de Mantenimiento

La Herramienta de Mantenimiento es la multi-herramienta de Elías y su principal forma de interactuar con los puzzles de la nave. Refuerza la fantasía de ser un técnico y no un soldado.

## Descripción Funcional

*   **Modo de Interacción**: Al apuntar con la herramienta, los objetos interactivos del entorno se resaltan. La herramienta tiene varios "modos" que se activan contextualmente.
*   **Soldadura / Corte**: Se usa para reparar tuberías rotas (puzzles de redirección de flujo) o para cortar paneles de acceso y abrir atajos. Se manifiesta como un rayo de energía concentrado.
*   **Hackeo / Sobrecarga**: Permite a Elías interactuar con terminales para resolver minijuegos de hackeo (ej: puzzles de lógica o ritmo) para abrir puertas o desactivar sistemas de seguridad. También puede sobrecargar nodos de energía.
*   **Redirección de Energía**: En ciertos paneles, la herramienta puede "coger" un flujo de energía y "dispararlo" a otro conector, completando un circuito.

## Usos en el Juego

1.  **Resolución de Puzzles de Sistemas**: Es la mecánica central para todos los puzzles de ingeniería, como los de redireccionamiento de energía en Mantenimiento o los de presión en el Laboratorio Acuático.
2.  **Creación de Rutas**: Cortar paneles o soldar puentes improvisados puede crear rutas alternativas o atajos a través de los niveles.
3.  **Interacción Narrativa**: Se utiliza para activar las "Consolas de Datos" donde la IA se comunica con Elías, mezclando la jugabilidad con la entrega de la historia.

---

### Nota de Diseño: Implementación y Referencias

La clave es que los puzzles de la herramienta se sientan como una extensión natural del mundo y no como minijuegos desconectados.

*   **Sugerencia de Implementación**: Crear un sistema de interfaces (`IInteractable`, `IHackable`, `IWeldable`) que los objetos del mundo puedan implementar. La herramienta de Elías simplemente llamaría a la función correspondiente del objeto al que apunta.

*   **Referencias de Juegos (Herramientas de Interacción):**
    *   **Dead Space**: La Kinesis y el Stasis son ejemplos perfectos de herramientas industriales convertidas en mecánicas de juego para puzzles y combate. El proceso de reparar sistemas bajo presión es una gran inspiración.
    *   **Metroid Prime**: El sistema de visores (Escaneo, Térmico) es una excelente referencia para el modo en que una herramienta puede cambiar la percepción del mundo y revelar puntos de interacción.
    *   **BioShock**: El minijuego de hackeo (el puzzle de tuberías) es un ejemplo clásico de una mecánica de herramienta recurrente.