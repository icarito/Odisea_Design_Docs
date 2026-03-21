-- Convierte wikilinks de Obsidian en imágenes/enlaces de Pandoc.
-- Usa un mapa global del vault para resolver wikilinks con rutas absolutas correctas.

-- Mapa completo del vault: nombre de archivo → ruta absoluta HTML
local VAULT_MAP = {
  ["Apéndice_Imagenes_Huérfanas"] = "/Odisea_Design_Docs/Odisea/Apéndice_Imagenes_Huérfanas.html",
  ["Motion Capture"] = "/Odisea_Design_Docs/Odisea/Archivo/ARCHIVED/Motion Capture.html",
  ["REFACTOR PENDING"] = "/Odisea_Design_Docs/Odisea/Archivo/ARCHIVED/REFACTOR PENDING.html",
  ["DroidPad QR Spec"] = "/Odisea_Design_Docs/Odisea/Archivo/CONTROL/DroidPad QR Spec.html",
  ["DroidPad SPEC"] = "/Odisea_Design_Docs/Odisea/Archivo/CONTROL/DroidPad SPEC.html",
  ["DroidPad Virtual Joypad"] = "/Odisea_Design_Docs/Odisea/Archivo/CONTROL/DroidPad Virtual Joypad.html",
  ["Networked DroidPad"] = "/Odisea_Design_Docs/Odisea/Archivo/CONTROL/Networked DroidPad.html",
  ["Física"] = "/Odisea_Design_Docs/Odisea/Archivo/FISICA/Física.html",
  ["Arquitectura de Subsistemas"] = "/Odisea_Design_Docs/Odisea/Arquitectura/Arquitectura de Subsistemas.html",
  ["Core_V2_Resumen"] = "/Odisea_Design_Docs/Odisea/Arquitectura/Core_V2_Resumen.html",
  ["Protocolo_Core_V2"] = "/Odisea_Design_Docs/Odisea/Arquitectura/Protocolo_Core_V2.html",
  ["Protocolo_Desarrollo"] = "/Odisea_Design_Docs/Odisea/Arquitectura/Protocolo_Desarrollo.html",
  ["design_intent_tree"] = "/Odisea_Design_Docs/Odisea/Canon/design_intent_tree.html",
  ["feature_interact"] = "/Odisea_Design_Docs/Odisea/Canon/feature_interact.html",
  ["feature_interactables"] = "/Odisea_Design_Docs/Odisea/Canon/feature_interactables.html",
  ["feature_odisea_script"] = "/Odisea_Design_Docs/Odisea/Canon/feature_odisea_script.html",
  ["feature_odyssey_script_replay"] = "/Odisea_Design_Docs/Odisea/Canon/feature_odyssey_script_replay.html",
  ["feature_odyssey_script_usage"] = "/Odisea_Design_Docs/Odisea/Canon/feature_odyssey_script_usage.html",
  ["feature_pushable_box"] = "/Odisea_Design_Docs/Odisea/Canon/feature_pushable_box.html",
  ["feature_refine_movement_gamefeel"] = "/Odisea_Design_Docs/Odisea/Canon/feature_refine_movement_gamefeel.html",
  ["feature_sidescroller_zone"] = "/Odisea_Design_Docs/Odisea/Canon/feature_sidescroller_zone.html",
  ["feature_test_battery"] = "/Odisea_Design_Docs/Odisea/Canon/feature_test_battery.html",
  ["feature_test_runner"] = "/Odisea_Design_Docs/Odisea/Canon/feature_test_runner.html",
  ["Arte_Estilo_Visual"] = "/Odisea_Design_Docs/Odisea/Diseno/Arte/ARTE/Arte_Estilo_Visual.html",
  ["Arte_Prompts_Generativos"] = "/Odisea_Design_Docs/Odisea/Diseno/Arte/ARTE/Arte_Prompts_Generativos.html",
  ["Desglose_Estilos"] = "/Odisea_Design_Docs/Odisea/Diseno/Arte/ARTE/Desglose_Estilos.html",
  ["Guía de Estilo de Interfaz Humana"] = "/Odisea_Design_Docs/Odisea/Diseno/Arte/ARTE/Guía de Estilo de Interfaz Humana.html",
  ["Luces"] = "/Odisea_Design_Docs/Odisea/Diseno/Arte/ARTE/Luces.html",
  ["Música"] = "/Odisea_Design_Docs/Odisea/Diseno/Arte/ARTE/Música.html",
  ["Referencias_e_Inspiración"] = "/Odisea_Design_Docs/Odisea/Diseno/Arte/ARTE/Referencias_e_Inspiración.html",
  ["Deep_Research_Level_Design"] = "/Odisea_Design_Docs/Odisea/Diseno/LevelDesign/LEVEL DESIGN/Deep_Research_Level_Design.html",
  ["Level_Design_Document"] = "/Odisea_Design_Docs/Odisea/Diseno/LevelDesign/LEVEL DESIGN/Level_Design_Document.html",
  ["Pipeline"] = "/Odisea_Design_Docs/Odisea/Diseno/LevelDesign/LEVEL DESIGN/Pipeline.html",
  ["Screenplay_Nivel_1"] = "/Odisea_Design_Docs/Odisea/Diseno/LevelDesign/LEVEL DESIGN/Screenplay_Nivel_1.html",
  ["Storyboard_Nivel_1"] = "/Odisea_Design_Docs/Odisea/Diseno/LevelDesign/LEVEL DESIGN/Storyboard_Nivel_1.html",
  ["02_Mecanicas_Clave"] = "/Odisea_Design_Docs/Odisea/Diseno/Mecanicas/MECANICAS/02_Mecanicas_Clave.html",
  ["02_Mecanicas_Indice"] = "/Odisea_Design_Docs/Odisea/Diseno/Mecanicas/MECANICAS/02_Mecanicas_Indice.html",
  ["03_Vehiculos"] = "/Odisea_Design_Docs/Odisea/Diseno/Mecanicas/MECANICAS/03_Vehiculos.html",
  ["Enemigos_Drones_y_Sistemas"] = "/Odisea_Design_Docs/Odisea/Diseno/Mecanicas/MECANICAS/Enemigos_Drones_y_Sistemas.html",
  ["Input"] = "/Odisea_Design_Docs/Odisea/Diseno/Mecanicas/MECANICAS/Input.html",
  ["Mecanicas_Controlador_Elias"] = "/Odisea_Design_Docs/Odisea/Diseno/Mecanicas/MECANICAS/Mecanicas_Controlador_Elias.html",
  ["Mecanicas_Dron_Cargol"] = "/Odisea_Design_Docs/Odisea/Diseno/Mecanicas/MECANICAS/Mecanicas_Dron_Cargol.html",
  ["Mecanicas_Gravedad_Variable"] = "/Odisea_Design_Docs/Odisea/Diseno/Mecanicas/MECANICAS/Mecanicas_Gravedad_Variable.html",
  ["Mecanicas_Herramienta_Mantenimiento"] = "/Odisea_Design_Docs/Odisea/Diseno/Mecanicas/MECANICAS/Mecanicas_Herramienta_Mantenimiento.html",
  ["Mecanicas_Propulsor_0G"] = "/Odisea_Design_Docs/Odisea/Diseno/Mecanicas/MECANICAS/Mecanicas_Propulsor_0G.html",
  ["Mecanicas_Vehiculo_4x4"] = "/Odisea_Design_Docs/Odisea/Diseno/Mecanicas/MECANICAS/Mecanicas_Vehiculo_4x4.html",
  ["Mecanicas_Vehiculo_Aereo"] = "/Odisea_Design_Docs/Odisea/Diseno/Mecanicas/MECANICAS/Mecanicas_Vehiculo_Aereo.html",
  ["Locacion_BioGranjas_SCG"] = "/Odisea_Design_Docs/Odisea/Diseno/Narrativa/LUGARES/Locacion_BioGranjas_SCG.html",
  ["Locacion_Criogenia"] = "/Odisea_Design_Docs/Odisea/Diseno/Narrativa/LUGARES/Locacion_Criogenia.html",
  ["Locacion_Laboratorio_Acuatico"] = "/Odisea_Design_Docs/Odisea/Diseno/Narrativa/LUGARES/Locacion_Laboratorio_Acuatico.html",
  ["Locacion_Mantenimiento"] = "/Odisea_Design_Docs/Odisea/Diseno/Narrativa/LUGARES/Locacion_Mantenimiento.html",
  ["Locacion_Modulos_Rotatorios"] = "/Odisea_Design_Docs/Odisea/Diseno/Narrativa/LUGARES/Locacion_Modulos_Rotatorios.html",
  ["Locacion_Nave_General"] = "/Odisea_Design_Docs/Odisea/Diseno/Narrativa/LUGARES/Locacion_Nave_General.html",
  ["Locacion_Nucleo_0G"] = "/Odisea_Design_Docs/Odisea/Diseno/Narrativa/LUGARES/Locacion_Nucleo_0G.html",
  ["Locacion_Nucleo_IA"] = "/Odisea_Design_Docs/Odisea/Diseno/Narrativa/LUGARES/Locacion_Nucleo_IA.html",
  ["Acto_I_La_Negacion"] = "/Odisea_Design_Docs/Odisea/Diseno/Narrativa/NARRATIVA/ACTO 1/Acto_I_La_Negacion.html",
  ["Acto_II_El_Laberinto"] = "/Odisea_Design_Docs/Odisea/Diseno/Narrativa/NARRATIVA/ACTO 2/Acto_II_El_Laberinto.html",
  ["Acto_III_El_Desafio"] = "/Odisea_Design_Docs/Odisea/Diseno/Narrativa/NARRATIVA/ACTO 3/Acto_III_El_Desafio.html",
  ["Acto_IV_La_Decision"] = "/Odisea_Design_Docs/Odisea/Diseno/Narrativa/NARRATIVA/ACTO 4/Acto_IV_La_Decision.html",
  ["Narrativa_Finales"] = "/Odisea_Design_Docs/Odisea/Diseno/Narrativa/NARRATIVA/ACTO FINAL/Narrativa_Finales.html",
  ["Cuentos"] = "/Odisea_Design_Docs/Odisea/Diseno/Narrativa/NARRATIVA/Cuentos.html",
  ["Entidad_Cargol"] = "/Odisea_Design_Docs/Odisea/Diseno/Narrativa/PERSONAJES Y EQUIPOS/Entidad_Cargol.html",
  ["GIZMO"] = "/Odisea_Design_Docs/Odisea/Diseno/Narrativa/PERSONAJES Y EQUIPOS/GIZMO.html",
  ["Manifiesto de carga"] = "/Odisea_Design_Docs/Odisea/Diseno/Narrativa/PERSONAJES Y EQUIPOS/Manifiesto de carga.html",
  ["Multi-Tool"] = "/Odisea_Design_Docs/Odisea/Diseno/Narrativa/PERSONAJES Y EQUIPOS/Multi-Tool.html",
  ["Personaje_Elias"] = "/Odisea_Design_Docs/Odisea/Diseno/Narrativa/PERSONAJES Y EQUIPOS/Personaje_Elias.html",
  ["Personaje_IA_Odisea"] = "/Odisea_Design_Docs/Odisea/Diseno/Narrativa/PERSONAJES Y EQUIPOS/Personaje_IA_Odisea.html",
  ["Personaje_PP_fantasma"] = "/Odisea_Design_Docs/Odisea/Diseno/Narrativa/PERSONAJES Y EQUIPOS/Personaje_PP_fantasma.html",
  ["Pilares"] = "/Odisea_Design_Docs/Odisea/Diseno/Pilares.html",
  ["Master_Index"] = "/Odisea_Design_Docs/Odisea/Master_Index.html",
  ["Ideas_Mecanicas"] = "/Odisea_Design_Docs/Odisea/Produccion/Backlog/Ideas_Mecanicas.html",
  ["Automatización"] = "/Odisea_Design_Docs/Odisea/Produccion/Backlog/PRODUCTION/Automatización.html",
  ["DEVLOG 2025 12 05"] = "/Odisea_Design_Docs/Odisea/Produccion/Backlog/PRODUCTION/DEVLOG 2025 12 05.html",
  ["Plan_Implementacion_MVP"] = "/Odisea_Design_Docs/Odisea/Produccion/Backlog/PRODUCTION/Plan_Implementacion_MVP.html",
  ["QOL_Checklist"] = "/Odisea_Design_Docs/Odisea/Produccion/Backlog/QOL_Checklist.html",
  ["Status_Report"] = "/Odisea_Design_Docs/Odisea/Produccion/Status_Report.html"
}

local function make_image(target, alt)
  local img = target
  if not img:match('^_ASSETS/') and not img:match('^/') and not img:match('^https?://') and not img:match('^data:') then
    -- Para HTML (GitHub Pages): ruta absoluta con base del repo
    -- Para PDF/LaTeX: ruta relativa desde la raíz del proyecto
    local fmt = FORMAT or ''
    if fmt:match('html') then
      img = '/Odisea_Design_Docs/Odisea/_ASSETS/' .. img
    else
      img = 'Odisea/_ASSETS/' .. img
    end
  end
  if alt and alt ~= '' then
    return pandoc.Image(alt, img)
  else
    return pandoc.Image({}, img)
  end
end

local function make_link(target, alias)
  local text = (alias and alias ~= '' and alias) or target
  if target:match('^#') then
    return pandoc.Link(text, target)
  end
  local t = target:gsub('%.md$', '')
  local url
  if t:match('^https?://') then
    url = t
  else
    -- Buscar en el mapa del vault primero
    local mapped = VAULT_MAP[t]
    if mapped then
      url = mapped
    elseif t:match('/') then
      url = '/Odisea_Design_Docs/' .. t .. '.html'
    else
      url = t .. '.html'
    end
  end
  return pandoc.Link(text, url)
end

local function split_wikilinks(s)
  local res = {}
  local i = 1
  while true do
    local i_img_start, i_img_end = s:find("!%[%[[^%]]+%]%]", i)
    local i_link_start, i_link_end = s:find("%[%[[^%]]+%]%]", i)
    local next_start, next_end, kind
    if i_img_start and (not i_link_start or i_img_start < i_link_start) then
      next_start, next_end, kind = i_img_start, i_img_end, 'image'
    elseif i_link_start then
      next_start, next_end, kind = i_link_start, i_link_end, 'link'
    else
      break
    end
    if next_start > i then
      table.insert(res, pandoc.Str(s:sub(i, next_start - 1)))
    end
    local chunk = s:sub(next_start, next_end)
    if kind == 'image' then
      local inner = chunk:match("!%[%[([^%]]+)%]%]")
      local target, alt = inner:match("([^|]+)|?(.*)")
      table.insert(res, make_image(target, alt))
    else
      local inner = chunk:match("%[%[([^%]]+)%]%]")
      local target, alias = inner:match("([^|]+)|?(.*)")
      table.insert(res, make_link(target, alias))
    end
    i = next_end + 1
  end
  if i <= #s then
    table.insert(res, pandoc.Str(s:sub(i)))
  end
  return res
end

function walk_obsidian_links(el)
  if el.t ~= 'Str' then return el end
  local nodes = split_wikilinks(el.text)
  if #nodes == 1 and nodes[1].t == 'Str' and nodes[1].text == el.text then
    return el
  end
  return nodes
end

return {
  { Str = walk_obsidian_links }
}
