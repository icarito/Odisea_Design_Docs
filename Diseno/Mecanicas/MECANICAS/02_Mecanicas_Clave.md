# Mecánicas Clave

## Controlador de Elías (Tercera Persona)

Movimiento ágil de tercera persona con precisión de plataformas, propulsor para doble salto y herramienta de mantenimiento para puzzles. Ver [[Mecanicas_Controlador_Elias]] para detalles.
![[mecanica_gravedad_variable.jpeg]]
## Dron Cargol (Asistente Remoto)

Dron controlable para rutas alternativas y reparaciones a distancia. Su movimiento es ahora **determinista** para integrarse con el sistema de replay. Ver [[Mecanicas_Dron_Cargol]] para detalles.

## Gravedad Variable

Mecánica central que cambia la jugabilidad entre 1G, 0G y fluctuante. Los cambios de gravedad se procesan de forma síncrona con el sistema de replay. Ver [[Mecanicas_Gravedad_Variable]] para detalles.

## Objetos Dinámicos Deterministas (Pushable Boxes)

Todos los objetos interactivos, como las **Cajas Empujables**, han sido migrados a la arquitectura **Core_V2**. Esto significa que su movimiento, colisión y posición son parte del estado capturado por el sistema de replay, permitiendo puzzles físicos complejos que son 100% reproducibles.

![[mecanica_herramienta_mantenimiento.jpeg]]


# Powerups

Al principio Elías está un poco débil y mal equipado porque acaba de despertar de _estasis_. De todas maneras es un tipo ágil y ya puede correr.
