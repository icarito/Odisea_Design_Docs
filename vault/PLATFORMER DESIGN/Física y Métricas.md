# Odisea - GDD: Física Fundamental y Métricas del Personaje

El diseño de niveles de plataformas es, fundamentalmente, un ejercicio de ingeniería de sistemas. Los niveles más efectivos funcionan como sistemas meticulosamente elaborados que modulan el desafío y la habilidad.

## 1. Restricciones Métricas y Precisión Cinemática
La geometría del nivel no es arbitraria; es la manifestación física del espacio negativo definido por las limitaciones de movimiento del protagonista.

### 1.1 Definición de las "Hard Rules" (Reglas Inmutables)
Debemos realizar pruebas rigurosas para determinar el alcance absoluto de las habilidades del jugador. Estos valores definen la "gramática" de *Odisea*:

* **Velocidad de Movimiento ($V_x$):** Define el ritmo general.
* **Altura Máxima de Salto ($H_{max}$):** Límite vertical.
* **Distancia Máxima de Salto ($D_{max}$):** Límite horizontal.



### 1.2 Aplicación de las Restricciones para el Control del Nivel
Utilizamos estos conocimientos no solo para medir, sino para **controlar**:

> **Regla de Diseño:** Si queremos evitar que el jugador se salte un segmento (sequence break), el hueco debe ser estrictamente mayor que $D_{max}$.

Esto asegura que la precisión métrica fuerce la narrativa y la progresión estructural prevista, impidiendo que los jugadores se salten capítulos de la "mini-historia" del nivel.

### 1.3 Fidelidad Cinemática y Pendientes
La forma de un arco de salto no es un triángulo, sino una **parábola** determinada por la aceleración horizontal y el modelo gravitatorio.

**Nota sobre Terrenos Inclinados:**
Si el desplazamiento por gravedad no se calcula correctamente en relación con la velocidad horizontal en una pendiente, el personaje "rebotará" en lugar de descender suavemente.
* **Consecuencia:** Movimiento de baja fidelidad que rompe la inmersión.
* **Requisito:** La precisión del motor de física es un prerrequisito necesario para el "Flow" psicológico.

## 2. Tabla de Especificaciones de Métricas
| Métrica de Restricción | Variable Física | Aplicación de Diseño | Importancia Arquitectónica |
| :--- | :--- | :--- | :--- |
| **Altura Máx. Salto ($H_{max}$)** | Velocidad Vertical y Gravedad | Define alturas de muros y plataformas. | Impone progresión vertical y *gating* de mecánicas (ej. Doble Salto). |
| **Distancia Máx. Salto ($D_{max}$)** | Velocidad Horizontal y Control Aéreo | Establece el tamaño mínimo de huecos. | Previene atajos y fuerza la interacción con obstáculos intermedios. |
| **Velocidad de Personaje ($V_x$)** | Aceleración (Horizontal) | Define el ritmo (pacing). | Crítica para desafíos contrarreloj y la percepción de fluidez. |

## 3. Fidelidad del Control (Game Feel)
El diseño se basa en la capacidad del jugador para dominar el movimiento.
* **Plataformas 2D simples:** Priorizan velocidad instantánea (input directo).
* **Odisea (Avanzado):** Incorporar mecánicas de aceleración/desaceleración para permitir un control granular y un techo de habilidad más alto.

**Para Entornos 3D:**
La percepción de profundidad es crítica. Se deben usar señales visuales (ej. la sombra del personaje en *Super Mario 64*) para telegrafiar con precisión el aterrizaje.