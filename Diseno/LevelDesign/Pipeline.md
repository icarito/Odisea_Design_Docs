# Odisea - GDD: Pipeline de Diseño Iterativo

La transición de los cálculos métricos a un nivel jugable requiere un proceso disciplinado.

## 1. Conceptualización y Narrativa del Nivel
Cada nivel debe tratarse como una "mini-historia" autocontenida:
1.  Inicio.
2.  Desarrollo (tensión creciente).
3.  Resolución.

**Antes de abrir el editor:** Bocetar conceptos de diseño (thumbnails) etiquetando la ubicación estratégica de obstáculos, enemigos y recompensas.

## 2. Fase de Gray Box (Caja Gris / Bloqueo)
Esta es la etapa crucial donde validamos el diseño usando geometría sin texturas.



**Objetivos del Gray Box:**
* Validar la funcionalidad antes de comprometer recursos de arte.
* Probar físicamente el $D_{max}$ (Distancia Máxima de Salto).
* Asegurar que los saltos críticos son desafiantes pero posibles.

**Pasos de la Metodología:**
1.  **Estructura Inicial:** Paredes, suelos y obstáculos clave con formas simples.
2.  **Mapeo del Flujo:** Trazar la navegación del jugador.
3.  **Colocación de Elementos:** Objetivos y enemigos.

> **Nota:** Si un salto se siente raro en la fase de Gray Box, la métrica o la colocación están mal. Iterar aquí es barato; iterar con arte final es costoso.

## 3. Curva de Aprendizaje (Estructura de Enseñanza)
El diseño del nivel es el instructor. Utilizaremos el **Patrón de 4 Pasos** (popularizado por *Super Mario Galaxy 2*):

1.  **Introducción (Espacio Seguro):** Presentar la mecánica sin amenaza de muerte.
2.  **Desarrollo:** Variaciones y repetición con dificultad creciente.
3.  **El Giro (The Twist):** Un uso inesperado de la habilidad aprendida. Requiere dominio reflexivo.
4.  **Conclusión:** Prueba final o síntesis.

## 4. Diseño para la Maestría (High-Skill)
Para los jugadores expertos, diseñaremos contenido opcional que pruebe los límites absolutos de las restricciones métricas ($V_x$, $H_{max}$).
* *Ejemplo:* Pruebas contrarreloj o coleccionables en rutas alternativas.
* Esto proporciona una recompensa intrínseca de alto valor: la validación de la maestría del jugador.