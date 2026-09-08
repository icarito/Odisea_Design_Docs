# Anexo: Especificaciones Logísticas y Red de Fluidos (GDD-LOG-282)

> **Importado al vault:** 2026-09-08 (documento dictado por Sebastián).
> **ID original:** GDD-LOG-282 · Módulo: Acto I (Domo Criogénico y Hangar Subterráneo)
> **Parent:** FD-255 (Maestro de Sistemas) → hoy absorbido por **FD-289** (repo Odisea,
> `docs/features/FD-289_dome_systems_canon.md`), que es el plano canónico del domo.
> **Nota de reconciliación:** la tabla de ductos (§2) incluye 2 líneas extra que FD-289
> no contempla para el rig del VS (Línea de Vacío/Metano, Agua Pesada). Quedan como
> lore/asset de ambientación, no como sistemas simulados del vertical slice.
> Los marcadores numéricos [n] son citas del documento fuente (Marco Mercurial Dyson).

---

Este documento establece las especificaciones físicas, semánticas y de balance de juego
para las dos grandes redes logísticas de la **Odisea**: la **Red Logística de Sólidos**
(cajas y cintas) y la **Red Logística de Fluidos** (ductos y tuberías), bajo el marco de
ingeniería de autoreplicación **Mercurial Dyson**. Sirve como directiva canónica para la
creación e importación de assets en el backlog de arte y programación en Godot 3.

## 1. Reseña del Sistema Mercurial Dyson aplicado a la Odisea

El diseño industrial de la nave se basa en los principios de desensamblaje y expansión
exponencial de **Mercurial Dyson**. La nave funciona como una **Semilla Industrial**
(Industrial Seed) de ~50,000 toneladas (excluyendo la masa de los colonos).

```
[ SEMILLA INDUSTRIAL (50k toneladas) ]
                 │
     ┌───────────┴────────────────────┐
     ▼                                ▼
[ RECURSOS DE TRÁNSITO ]    [ CAPACIDAD LOCAL EN TITÁN ]
suficientes para el viaje   requiere bootstrapping exponencial
```

**Premisa fundamental:** *"la luz solar de Mercurio es suficiente para arrancar el
proyecto, pero no para terminarlo"* → los recursos del Arca son suficientes para llegar
a Titán y arrancar la primera fase, pero insuficientes para completar la colonización
industrial sin expansión y autoreplicación basada en materiales locales.

### Las 5 restricciones termodinámicas a bordo

1. **Complejidad de Manufactura:** restringe la cadena de replicación espacial. La nave
   prioriza talleres de ensamblaje 3D modulares en el Sector S2 (Logística) para producir
   repuestos estandarizados antes que maquinaria compleja.
2. **Disponibilidad de Energía:** a 9.5 UA la energía solar es insignificante; toda la
   nave depende del reactor de fusión central alimentado por Helio-3.
3. **Infraestructura de Transporte:** distribución interna dividida entre la **Red
   Helicoidal de Cintas de 24 km** y el **Eje de Elevación Gravitacional** en el núcleo
   de vacío.
4. **Área / Volumen:** optimización milimétrica. Altura de 8,000 m en 300 plataformas;
   los subdomos son plantillas industriales repetibles y compactas.
5. **Disipación de Calor:** el vacío es un aislante despiadado. La nave depende de
   masivos **radiadores externos de alta temperatura (heat dumps)** para evitar el
   colapso térmico.

## 2. Inventario de Ductos de Circulación Ambiental (Subdomos)

Cada subdomo (pocas centenas de personas en criosueño) cuenta con líneas de ductos
independientes que atraviesan mamparos y alimentan la física determinista de `Room3D`:

| Tipo de ducto | Diámetro | Color de señalización | Fluido / recurso | Lógica de simulación (Room3D) |
|---|---|---|---|---|
| Riser de Criocoolant | 0.4 m | Cian | Helio químico licuado de alta densidad | Escribe delta térmico negativo (`temperature -=`). Su rotura inunda la sala de niebla cian fría (≤ −150 °C) |
| Retorno Atmosférico (HVAC) | 1.2 m | Blanco con franjas rojas | Aire reciclado, nitrógeno y oxígeno local | Escribe delta de contaminación negativo (`contamination -=`) y regula la presión local |
| Línea de Vacío y Metano | 0.6 m | Gris con franjas amarillas | Presión negativa de recolección exterior | Actúa como sumidero. Diseñada para succionar e importar hidrocarburos de Titán tras el descenso |
| Conducto Eléctrico de Emergencia | 0.2 m | Verde | Cables lógicos blindados de la red auxiliar | Sostiene el bus eléctrico. Sus cables (`CircuitCable`) son destructibles por daño físico o cortocircuito criogénico |
| Suministro de Agua Pesada | 0.5 m | Azul marino | Agua pura desmineralizada para soporte vital | Proviene de la reserva crítica basal de 40,000,000 L (Sector S0); escudo antirradiación |

### Directivas de assets para el backlog

- **Modularidad estricta:** piezas componibles (`PipeSection`, `PipeCorner`, `PipeTee`)
  en la capa 7 (Prop), para no interferir con la colisión de cámara en tercera persona.
- **Shader de flujo unificado:** el material (`pipe_coolant.shader`) debe muestrear ruido
  en **coordenadas de mundo**, para que el fluido fluya continuo a través de uniones y
  codos sin costuras UV ni costo extra en GLES2.

## 3. Contenedores y Cajas de Carga (Red de Cintas)

Para los puzles de interacción cinética del **Hangar de Mantenimiento Subterráneo**
(`Dome_Intro_Hangar.tscn`), dos tamaños físicos estandarizados:

### A. Caja de Suministros Clase "Standard" (Tipo S)

- **Dimensiones:** cubo perfecto de 1.2 × 1.2 × 1.2 m.
- **Física:** `PushableBoxV2`, modo híbrido — **RigidBody** en movimiento y **Kinematic**
  en reposo (snap a la rejilla para evitar drift de coma flotante en el replay).
- **Masa:** 80 kg. Elías puede empujarla e interactuar manualmente.

### B. Contenedor Clase "Heavy" (Tipo H)

- **Dimensiones:** 2.4 × 1.2 × 1.2 m.
- **Física:** rígido/pesado. Solo se desplaza mediante `Conveyor` o grúas.
- **Masa:** 250 kg. Barrera física insalvable a pie.

## 4. Matriz de Distribución de Contenedores por Cintas (Hangar)

Inyector determinista con semilla fija (`RandomNumberGenerator`, seed = 42):

```
[ Inyector automático ] ──(frecuencia: 45 s)──> [ Cinta Transportadora ] ──> [ Zona de Clasificación ]
                                                        │
                                                  (fuerza de ráfaga)
                                                        ▼
                                                  [ WindZone ]
```

| Clase | Ítem embalado | Tamaño | Probabilidad | Frecuencia | Comportamiento físico en puzles |
|---|---|---|---|---|---|
| M-2 (Metalurgía) | Placas de aleación y filamento de grafeno para impresoras 3D del Sector S2 | S | 35 % | cada 128.5 s | Masa nominal; tapar abismos, contrapeso básico |
| F-0 (Filtros) | Cartuchos cerámicos para purificadores de agua de reactores | S | 20 % | cada 225.0 s | Baja densidad; las ráfagas (WindZone) la arrastran con violencia |
| C-1 (Criogenia) | Repuestos térmicos y componentes de disipación para criopods del Sector S1 | H | 15 % | cada 300.0 s | Extremadamente pesada; obstáculo móvil que bloquea el paso de drones |
| E-9 (Energía) | Baterías de estado sólido de grafeno para la red verde auxiliar | S | 15 % | cada 300.0 s | Altamente conductora; sobre pasarela mojada por condensación propaga arcos eléctricos letales |
| H-4 (Hábitat) | Módulos colapsados de Kevlar estructural para despliegue de domos en Titán | H | 10 % | cada 450.0 s | Gran volumen y masa; la única que resiste corrientes pesadas — la "Caja Tapón" para obstruir rejillas de viento |
| S-X (Scrap) | Chatarra, engranajes dañados y componentes deformados para fundición | S | 5 % | cada 900.0 s | Centro de masa desplazado; oscila caóticamente en las cintas |

**Nota técnica (GLES2):** las cajas Tipo S comparten la misma malla básica; las variantes
(textura, logos de clase) se aplican con un único material compartido y `use_custom_data`
para no disparar las draw calls del hangar.

## 5. Flujos de Materiales y Energía de la Nave

```
[ S5: Tanques de Helio-3 ] (apical)
            │
            ▼
[ Red de Criocoolant (cian) ] ──> [ REACTOR CENTRAL (Z=4000) ] ──> [ Red de Plasma (ámbar) ]
            ▲                              │                              │
            │                              ▼                              ▼
     (evita SCRAM)              [ Radiadores Externos ]          (columna vertebral)
```

- **Combustible nuclear (Helio-3):** fluye desde los tanques esféricos del Sector S5
  (apical) hacia los reactores de fusión del núcleo central.
- **Red de Plasma (energía térmica — ámbar):** conducida por la columna vertebral
  magnética a lo largo de los 8 km de la nave para alimentar radiadores de pared de
  emergencia y subestaciones. **Licencia creativa de gameplay:** el plasma viaja
  confinado magnéticamente por el centro del ducto; si hay fuga, el campo colapsa y la
  tubería brilla al rojo vivo antes de estallar en una barrera física de daño térmico.
- **Red de Criocoolant (refrigeración — cian):** corre adyacente a los pods criogénicos
  (Sector S1) para disipar el calor metabólico de las 50,000 almas. Su caudal regresa
  continuo para enfriar el núcleo del reactor. Si se interrumpe → **SCRAM** → cae el bus
  eléctrico de la nave.
- **Escudo biológico (agua pesada):** 40,000,000 L en el Sector S0 (basal) como lastre y
  escudo físico contra rayos cósmicos. Circula por bombeo vertical vía el Eje de
  Elevación Gravitacional para enfriamiento secundario y bio-granjas.
- **Carga biótica (crópods):** los 50,000 colonos dormidos representan el "feedstock
  vivo" final; serán trasladados en cápsulas automáticas Clase C-1 por la red helicoidal
  de cintas y el pozo de carga central hacia la superficie de Titán.
