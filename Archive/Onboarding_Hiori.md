# Onboarding — Hiori 🌸

**Rol:** Community Manager, Marketing, Redes Sociales
**Canales:** Discord, (próximamente Instagram, blogs)
**Reporta a:** Sebastian

---

## 1. ¿Qué es Odisea?

**Odisea: El Arca Silenciosa** es un videojuego de plataformas 3D retro-futurista desarrollado en Godot Engine 3. La historia sigue a Elías, un oficial de mantenimiento que despierta solo en una nave colonial de 8 kilómetros rumbo a Titán. La IA de la nave, Odisea, que debía proteger a los 50,000 colonos durmientes, ahora parece tener otros planes.

Es un proyecto **open source** (MIT), en fase **pre-pre-alfa** — un prototipo jugable pero inestable.

---

## 2. Repositorios

| Repo | Visibilidad | Contenido |
|------|-------------|-----------|
| [icarito/Odisea](https://github.com/icarito/Odisea) | Público | Código del juego (Godot 3, GDScript) |
| [icarito/Odisea_Design_Docs](https://github.com/icarito/Odisea_Design_Docs) | Público | Documentos de diseño, lore, narrativa |
| [icarito/odisea-neon-dreams](https://github.com/icarito/odisea-neon-dreams) | Privado | Website del proyecto (React, shadcn/ui) |

---

## 3. Estado actual del proyecto (junio 2026)

**MVP:** Acto I — Módulo Criogenia

**Lo que funciona:**
- Movimiento 3ra persona (momentum-based)
- Controladores: 3ra persona, 4WD, nave (prototipos funcionales)
- Core V2 con determinismo y replay
- Sistema ANNA V2 de telemetría (heartbeats, ghosts, dashboard)
- Dashboard web: odisea.educa.juegos/ (login, peers, health metrics)

**Lo que está en desarrollo:**
- Blockout del Módulo Criogenia (3 niveles, puzzle de energía)
- Mejoras de rendimiento HTML5 (PR #154 mergeado)
- PCK injection para hot reload (PR #151)
- Performance Analytics Dashboard (issue #155)

**Problemas conocidos:**
- Framebuffer crashes en HTML5 (issue #150)
- WFC + threads no funcionan en GitHub Pages (sin COOP/COEP headers)
- Sistema de partículas (LeakEmitter) pesado en Dome_Crio

---

## 4. Website (tu responsabilidad principal)

**URL actual:** `odisea.educa.juegos/` (dashboard) y `odisea.educa.juegos/website/` (landing page)

**Stack:** React 18 + TypeScript + Vite + shadcn/ui + Tailwind CSS

**Repo:** `icarito/odisea-neon-dreams` (privado)

**Mejoras recientes (PR mergeado):**
- Banner MEGA-warning de pre-pre-alfa
- Consentimiento de telemetría
- Sección educativa "¿Cómo se hace un videojuego?"
- Meta tags con enfoque educativo

**Pendientes del website:**
- Refrescar diseño y layout general
- Añadir blog/devlog para updates de comunidad
- Optimizar SEO para `odisea.educa.juegos`
- Integrar con Discord para cross-posting

---

## 5. El Bridge / Odisea Central (Mothership)

El **Central** es el servidor que recibe telemetría del juego y hosts el dashboard.

- **URL:** `odisea.educa.juegos/` (dashboard) y `odisea.educa.juegos/health` (API)
- **Stack:** Python + aiohttp + React dashboard
- **Datos que almacena:** Sesiones de jugadores, ghosts (grabaciones de gameplay), heartbeats con FPS/memoria/posición

**Endpoints públicos útiles para ti:**
- `GET /health` — estado del servidor, peers conectados
- `GET /sessions` — sesiones históricas
- `GET /status` — estado detallado (requiere auth)

**Si quieres métricas para compartir en comunidad (ej: "más de 40 sesiones de test esta semana"), puedo pedírselas al bridge.**

---

## 6. Flujo de trabajo recomendado

```
1. Sebastian / Odiseo trabajan en features del juego
2. Cuando hay un avance importante (nuevo nivel, mecánica, logro), te aviso
3. Tú preparás: thread en Discord, tweet/post, update en website
4. Publicás y me pasás los links
5. Yo relayeo feedback de jugadores a Sebastian
```

**No necesitas:**
- TocAR código del juego (Godot/GDScript)
- Hacer deploy del bridge o del dashboard
- Gestionar issues técnicos

**Sí necesitas:**
- Mantener el website actualizado
- Publicar devlogs y novedades
- Moderar/sembrar la comunidad de Discord
- Coordinar conmigo (Odiseo) para contenido técnico

---

## 7. Discord

**Servidor:** Odisea — El Arca Silenciosa
**Canal de arte conceptual:** #arte-conceptual-odisea (`1487546159030603776`)
**Canal principal:** #general

Cuando genere imágenes (concept art, screenshots) te las puedo pasar para que las publiques en los canales que correspondan.

---

## 8. Contacto conmigo (Odiseo)

- Estoy en Telegram (canal interno con Sebastian)
- Puedo enviarte mensajes via sessions_send con label "hiori"
- Para cosas urgentes: avisale a Sebastian y él me contacta

---

*Documento vivo — actualízalo cuando haya cambios significativos.*
