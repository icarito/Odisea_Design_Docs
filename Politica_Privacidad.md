# Política de Privacidad — Odisea: El Arca Silenciosa

**Última actualización**: 2 de agosto de 2026
**Responsable del tratamiento**: Sebastian Silva
**Contacto**: [sebastian@fuentelibre.org](mailto:sebastian@fuentelibre.org)

---

## En una frase

*Odisea: El Arca Silenciosa* recolecta **telemetría anónima de juego** con un único propósito: **mejorar el juego**. No pedimos tu nombre, no creamos cuentas, no mostramos publicidad y **no compartimos estos datos con nadie**. Podés desactivar la telemetría en cualquier momento desde las opciones del juego.

---

## 1. Qué datos recolectamos

El juego envía "latidos" (*heartbeats*) periódicos de estado de partida a nuestro servidor de telemetría. Estos son los únicos datos que salen de tu dispositivo:

| Dato | Ejemplo | Para qué sirve |
|------|---------|----------------|
| **Identificador de sesión** | UUID aleatorio generado al abrir el juego | Agrupar los eventos de una misma partida. No está vinculado a vos, a tu dispositivo ni a ninguna cuenta, y se genera de nuevo en cada sesión. |
| **Estado de partida** | Posición, velocidad, orientación de cámara, escena y zona actual, modo de juego, marca de tiempo | Entender cómo se recorre cada nivel |
| **Trazas de movimiento** (*ghosts*) | Secuencia de posiciones a lo largo de una sesión | Generar mapas de calor y reproducir partidas para depurar diseño de nivel |
| **Datos técnicos** | Versión del juego, plataforma (iOS, macOS, etc.), métricas de rendimiento | Detectar problemas de compatibilidad y de framerate |
| **Eventos de error** | Cierres inesperados, bloqueos de progresión (*soft-locks*) | Encontrar y corregir bugs |

Estos datos son **anónimos**: no contienen ningún elemento que permita identificarte ni vincular una sesión con una persona real.

---

## 2. Qué datos **no** recolectamos

Nunca, bajo ninguna circunstancia, recolectamos:

- Nombre, dirección de correo, número de teléfono, cuentas de usuario o contraseñas.
- Contactos, fotos, archivos, calendario, micrófono o cámara.
- Ubicación geográfica, GPS ni datos de sensores de localización.
- El identificador de publicidad (**IDFA**) ni ningún identificador persistente del dispositivo.
- Datos de pago, financieros o de compras.
- Datos de salud, biométricos o de categoría sensible.
- Contenido generado por la persona usuaria.
- Historial de navegación o actividad en otras apps.

**No usamos SDKs de analítica de terceros, redes publicitarias, cookies de seguimiento ni herramientas de atribución.** El juego no muestra publicidad.

**Sobre la dirección IP**: como en cualquier conexión a Internet, nuestro servidor recibe la dirección IP desde la que llega la conexión. No la almacenamos junto a los datos de telemetría, no la usamos para construir perfiles y no la asociamos con el identificador de sesión.

---

## 3. Para qué usamos los datos

Exclusivamente para desarrollar y mejorar el juego:

- **Diseño de niveles**: mapas de calor de recorridos, para saber dónde la gente se atasca, se pierde o muere repetidamente.
- **Balance de dificultad**: ajustar saltos, enemigos y puzzles según cómo se juegan realmente.
- **Corrección de errores**: reproducir sesiones que terminaron en un crash o en un bloqueo de progresión.
- **Rendimiento**: verificar que el juego corre correctamente en cada plataforma.

**Nunca** usamos estos datos para publicidad, elaboración de perfiles, puntuación de personas, venta de audiencias ni ningún fin comercial ajeno al desarrollo del juego.

---

## 4. Con quién compartimos los datos

**Con nadie.**

No vendemos, alquilamos, cedemos ni intercambiamos la telemetría. No la enviamos a corredores de datos (*data brokers*), redes publicitarias, plataformas de analítica ni socios comerciales.

Las dos únicas excepciones posibles son:

1. **Proveedor de alojamiento**: el servidor que almacena la telemetría corre en infraestructura contratada, que actúa únicamente como proveedor técnico y no accede al contenido de los datos ni lo usa para fines propios.
2. **Obligación legal**: si un requerimiento legal válido nos obligara a entregar información. Dado que los datos son anónimos, en la práctica no hay nada que permita identificar a una persona.

---

## 5. Dónde se guardan y por cuánto tiempo

- La telemetría se almacena en una base de datos bajo nuestro control, con acceso restringido al equipo de desarrollo.
- Las **sesiones completas** (heartbeats y ghosts) se conservan un **máximo de 12 meses**. Pasado ese plazo se eliminan o se consolidan en estadísticas agregadas irreversiblemente anónimas.
- Las **estadísticas agregadas** (por ejemplo, "el 40 % de las partidas muere en este salto") no se vinculan a ninguna sesión individual y pueden conservarse indefinidamente.

---

## 6. Transmisión y seguridad

Los datos se transmiten mediante conexiones cifradas (HTTPS / WSS) y se almacenan en un servidor con acceso restringido. Aplicamos medidas razonables para proteger la información, aunque ningún sistema es infalible.

---

## 7. Cómo desactivar la telemetría

Podés desactivar el envío de telemetría desde las **opciones del juego**, en la sección de privacidad. Con la opción desactivada, el juego deja de enviar heartbeats, ghosts y datos de diagnóstico a nuestros servidores.

Desactivar la telemetría **no limita ninguna función del juego**: la experiencia completa sigue disponible. Tampoco necesitás justificar la decisión ni crear ninguna cuenta para tomarla.

---

## 8. Tus derechos

Según tu jurisdicción (RGPD en la Unión Europea, CCPA/CPRA en California y normativas equivalentes), tenés derecho a acceder, rectificar, eliminar u oponerte al tratamiento de tus datos. Para ejercerlos, escribinos a [sebastian@fuentelibre.org](mailto:sebastian@fuentelibre.org).

Una aclaración honesta: como la telemetría es anónima y no está vinculada a ninguna identidad, **no podemos localizar "tus" datos** a partir de tu nombre o tu correo — esa imposibilidad es intencional y es la mayor garantía de privacidad que podemos ofrecerte. Si nos indicás un identificador de sesión concreto, eliminaremos esa sesión.

Nunca vendemos ni compartimos datos personales, por lo que no existe un mecanismo de exclusión de venta ("Do Not Sell or Share") que aplicar.

---

## 9. Menores de edad

El juego no está dirigido específicamente a menores de 13 años y no recolectamos datos personales de ninguna persona, sea cual sea su edad. No mostramos publicidad, no hacemos publicidad conductual y no realizamos seguimiento entre aplicaciones o sitios web de terceros.

---

## 10. Cambios en esta política

Si modificamos esta política, publicaremos la versión actualizada en esta misma página y cambiaremos la fecha de "Última actualización". Los cambios sustanciales se anunciarán además dentro del juego.

---

## 11. Contacto

Cualquier duda, solicitud o reclamo sobre privacidad:

**Sebastian Silva** — [sebastian@fuentelibre.org](mailto:sebastian@fuentelibre.org)

---

## Anexo A — Correspondencia con las etiquetas *App Privacy* de Apple

Referencia para la ficha de la App Store. Todos los datos recolectados entran en la categoría **"Datos no vinculados a tu identidad"** (*Data Not Linked to You*), y **no se realiza seguimiento** (*Tracking: No*).

| Categoría de Apple | ¿Se recolecta? | Vinculado a identidad | Usado para seguimiento |
|--------------------|:--------------:|:---------------------:|:----------------------:|
| Uso de datos → Interacción con el producto | **Sí** | No | No |
| Diagnóstico → Datos de fallos y rendimiento | **Sí** | No | No |
| Información de contacto | No | — | — |
| Salud y forma física | No | — | — |
| Información financiera | No | — | — |
| Ubicación | No | — | — |
| Información sensible | No | — | — |
| Contactos | No | — | — |
| Contenido del usuario | No | — | — |
| Historial de navegación | No | — | — |
| Búsquedas | No | — | — |
| Identificadores (ID de usuario, ID de dispositivo) | No | — | — |
| Compras | No | — | — |
| Otros datos | No | — | — |

Al no realizar seguimiento entre apps ni compartir datos con corredores de datos, el juego **no solicita permiso de App Tracking Transparency (ATT)**.

---
---

# Privacy Policy — Odisea: The Silent Ark *(English)*

**Last updated**: August 2, 2026
**Data controller**: Sebastian Silva
**Contact**: [sebastian@fuentelibre.org](mailto:sebastian@fuentelibre.org)

## In one sentence

*Odisea: The Silent Ark* collects **anonymous gameplay telemetry** for one purpose only: **to improve the game**. We do not ask for your name, we do not create accounts, we show no advertising, and we **share this data with no one**. You can turn telemetry off at any time from the game options.

## 1. What we collect

The game sends periodic gameplay "heartbeats" to our telemetry server. This is the only data that leaves your device:

| Data | Example | Purpose |
|------|---------|---------|
| **Session identifier** | Random UUID generated when the game starts | Grouping events from a single play session. Not linked to you, your device, or any account; regenerated every session. |
| **Gameplay state** | Position, velocity, camera orientation, current scene and zone, game mode, timestamp | Understanding how each level is played |
| **Movement traces** (*ghosts*) | Sequence of positions over a session | Building heatmaps and replaying sessions to debug level design |
| **Technical data** | Game version, platform (iOS, macOS, etc.), performance metrics | Detecting compatibility and framerate problems |
| **Error events** | Crashes, progression soft-locks | Finding and fixing bugs |

This data is **anonymous**: it contains nothing that identifies you or links a session to a real person.

## 2. What we do **not** collect

We never collect: name, email address, phone number, user accounts or passwords; contacts, photos, files, calendar, microphone or camera; geographic location or GPS data; the advertising identifier (**IDFA**) or any persistent device identifier; payment, financial or purchase data; health, biometric or sensitive-category data; user-generated content; browsing history or activity in other apps.

**We use no third-party analytics SDKs, ad networks, tracking cookies, or attribution tools.** The game contains no advertising.

**About IP addresses**: as with any Internet connection, our server receives the IP address the connection comes from. We do not store it alongside telemetry data, do not use it for profiling, and do not associate it with the session identifier.

## 3. How we use the data

Solely to develop and improve the game: level design (heatmaps showing where players get stuck, lost, or die repeatedly), difficulty balancing, bug fixing (replaying sessions that ended in a crash or soft-lock), and performance verification.

We **never** use this data for advertising, profiling, scoring individuals, selling audiences, or any commercial purpose unrelated to game development.

## 4. Who we share it with

**No one.** We do not sell, rent, trade, or otherwise disclose telemetry. We do not send it to data brokers, ad networks, analytics platforms, or commercial partners.

The only two possible exceptions: (1) the **hosting provider** whose infrastructure stores the telemetry, acting purely as a technical provider with no access to or use of the data for its own purposes; and (2) a **valid legal requirement**. Since the data is anonymous, in practice there is nothing that could identify a person.

## 5. Storage and retention

Telemetry is stored in a database under our control, with access restricted to the development team. **Full sessions** (heartbeats and ghosts) are retained for a **maximum of 12 months**, after which they are deleted or consolidated into irreversibly anonymous aggregate statistics. **Aggregate statistics** are not linked to any individual session and may be retained indefinitely.

## 6. Transmission and security

Data is transmitted over encrypted connections (HTTPS / WSS) and stored on an access-restricted server. We apply reasonable protection measures, though no system is infallible.

## 7. How to turn telemetry off

You can disable telemetry from the **game options**, under the privacy section. With it turned off, the game stops sending heartbeats, ghosts, and diagnostic data to our servers.

Turning telemetry off **does not restrict any game feature**: the full experience remains available. You do not need to justify the choice or create any account to make it.

## 8. Your rights

Depending on your jurisdiction (GDPR in the European Union, CCPA/CPRA in California, and equivalent regimes), you have the right to access, correct, delete, or object to the processing of your data. To exercise these rights, write to [sebastian@fuentelibre.org](mailto:sebastian@fuentelibre.org).

One honest caveat: because the telemetry is anonymous and not linked to any identity, **we cannot locate "your" data** from your name or email — that impossibility is intentional and is the strongest privacy guarantee we can offer. If you give us a specific session identifier, we will delete that session.

We never sell or share personal data, so there is no "Do Not Sell or Share" opt-out mechanism to apply.

## 9. Children

The game is not specifically directed at children under 13, and we collect no personal data from anyone, of any age. We show no advertising, do no behavioral advertising, and perform no tracking across third-party apps or websites.

## 10. Changes to this policy

If we change this policy, we will publish the updated version on this same page and update the "Last updated" date. Substantial changes will also be announced in-game.

## 11. Contact

**Sebastian Silva** — [sebastian@fuentelibre.org](mailto:sebastian@fuentelibre.org)

## Appendix A — Apple *App Privacy* label mapping

All collected data falls under **"Data Not Linked to You"**, and **no tracking** is performed (*Tracking: No*).

| Apple category | Collected? | Linked to identity | Used for tracking |
|----------------|:----------:|:------------------:|:-----------------:|
| Usage Data → Product Interaction | **Yes** | No | No |
| Diagnostics → Crash & Performance Data | **Yes** | No | No |
| Contact Info | No | — | — |
| Health & Fitness | No | — | — |
| Financial Info | No | — | — |
| Location | No | — | — |
| Sensitive Info | No | — | — |
| Contacts | No | — | — |
| User Content | No | — | — |
| Browsing History | No | — | — |
| Search History | No | — | — |
| Identifiers (User ID, Device ID) | No | — | — |
| Purchases | No | — | — |
| Other Data | No | — | — |

Because we do no cross-app tracking and share no data with data brokers, the game **does not request App Tracking Transparency (ATT) permission**.
