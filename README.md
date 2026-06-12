# Odisea Game — Documentación

Este repositorio contiene únicamente la documentación, diseño y pipeline de producción para el proyecto Odisea: El Arca Silenciosa.

## ¿Qué contiene este repo?
- Documentación completa de diseño, narrativa, mecánicas y arte.
- Planes de producción, status reports y backlog priorizado.
- Índices de assets y galería de imágenes del proyecto.
- Protocolos de desarrollo, pruebas y especificaciones técnicas de Core V2.
- Scripts de automatización para la generación de documentación.

## ¿Qué NO contiene?
- No incluye el código fuente ejecutable del motor Godot.
- No contiene el proyecto de Godot principal (escenas, scripts .gd del juego).
- No contiene los assets binarios finales optimizados para el motor.

## ¿Cómo compilar/publicar la documentación?

1. Instala Quarto: https://quarto.org/docs/get-started/
2. Desde la raíz del repo, ejecuta:

```sh
quarto render
quarto preview
```

3. El sitio generado estará en `outputs/index.html`.

## Contribuir
Lee CONTRIBUTING.md para normas de edición, frontmatter y convenciones de nombres.

---

> Para dudas sobre el código Godot, consulta el repositorio principal o contacta a los responsables listados en AGENTS.md.
