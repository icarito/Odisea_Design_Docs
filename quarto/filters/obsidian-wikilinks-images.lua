-- Convierte wikilinks de Obsidian en imágenes/enlaces de Pandoc.
-- Usa un mapa global del vault para resolver wikilinks con rutas absolutas correctas.

-- Mapa del vault actualizado para estructura Anexos/ + Archive/
local VAULT_MAP = {
  -- GDD principal
  ["GDD_v3"] = "/Odisea/GDD_v3.html",
  ["Master_Index"] = "/Odisea/Master_Index.html",

  -- Diseño - Mecánicas
  ["02_Mecanicas_Clave"] = "/Odisea/Diseno/Mecanicas/02_Mecanicas_Clave.html",
  ["02_Mecanicas_Indice"] = "/Odisea/Diseno/Mecanicas/02_Mecanicas_Indice.html",
  ["Mecanicas_Controlador_Elias"] = "/Odisea/Diseno/Mecanicas/Mecanicas_Controlador_Elias.html",
  ["Mecanicas_Dron_Cargol"] = "/Odisea/Diseno/Mecanicas/Mecanicas_Dron_Cargol.html",
  ["Enemigos_Drones_y_Sistemas"] = "/Odisea/Diseno/Mecanicas/Enemigos_Drones_y_Sistemas.html",
  ["Mecanicas_Herramienta_Mantenimiento"] = "/Odisea/Diseno/Mecanicas/Mecanicas_Herramienta_Mantenimiento.html",
  ["Input"] = "/Odisea/Diseno/Mecanicas/Input.html",

  -- Diseño - Narrativa
  ["Acto_I_La_Negacion"] = "/Odisea/Diseno/Narrativa/Acto_I_La_Negacion.html",
  ["Locacion_Criogenia"] = "/Odisea/Diseno/Narrativa/Locacion_Criogenia.html",
  ["Personaje_Elias"] = "/Odisea/Diseno/Narrativa/Personaje_Elias.html",
  ["Personaje_IA_Odisea"] = "/Odisea/Diseno/Narrativa/Personaje_IA_Odisea.html",
  ["Entidad_Cargol"] = "/Odisea/Diseno/Narrativa/Entidad_Cargol.html",

  -- Diseño - Level Design
  ["Level_Design_Document"] = "/Odisea/Diseno/LevelDesign/Level_Design_Document.html",
  ["Pipeline"] = "/Odisea/Diseno/LevelDesign/Pipeline.html",
  ["Screenplay_Nivel_1"] = "/Odisea/Diseno/LevelDesign/Screenplay_Nivel_1.html",
  ["Storyboard_Nivel_1"] = "/Odisea/Diseno/LevelDesign/Storyboard_Nivel_1.html",
  ["Deep_Research_Level_Design"] = "/Odisea/Diseno/LevelDesign/Deep_Research_Level_Design.html",

  -- Canon
  ["feature_interact"] = "/Odisea/Canon/feature_interact.html",
  ["feature_interactables"] = "/Odisea/Canon/feature_interactables.html",
  ["feature_odisea_script"] = "/Odisea/Canon/feature_odisea_script.html",
  ["feature_odyssey_script_replay"] = "/Odisea/Canon/feature_odyssey_script_replay.html",
  ["feature_odyssey_script_usage"] = "/Odisea/Canon/feature_odyssey_script_usage.html",
  ["feature_pushable_box"] = "/Odisea/Canon/feature_pushable_box.html",
  ["feature_refine_movement_gamefeel"] = "/Odisea/Canon/feature_refine_movement_gamefeel.html",

  -- Archive/MVP_Out
  ["Mecanicas_Gravedad_Variable"] = "/Archive/MVP_Out/Mecanicas_Gravedad_Variable.html",
  ["Mecanicas_Propulsor_0G"] = "/Archive/MVP_Out/Mecanicas_Propulsor_0G.html",
  ["Mecanicas_Vehiculo_4x4"] = "/Archive/MVP_Out/Mecanicas_Vehiculo_4x4.html",
  ["Mecanicas_Vehiculo_Aereo"] = "/Archive/MVP_Out/Mecanicas_Vehiculo_Aereo.html",
  ["03_Vehiculos"] = "/Archive/MVP_Out/03_Vehiculos.html",
  ["Locacion_BioGranjas_SCG"] = "/Archive/MVP_Out/Locacion_BioGranjas_SCG.html",
  ["Locacion_Laboratorio_Acuatico"] = "/Archive/MVP_Out/Locacion_Laboratorio_Acuatico.html",
  ["Locacion_Mantenimiento"] = "/Archive/MVP_Out/Locacion_Mantenimiento.html",
  ["Locacion_Modulos_Rotatorios"] = "/Archive/MVP_Out/Locacion_Modulos_Rotatorios.html",
  ["Locacion_Nave_General"] = "/Archive/MVP_Out/Locacion_Nave_General.html",
  ["Locacion_Nucleo_0G"] = "/Archive/MVP_Out/Locacion_Nucleo_0G.html",
  ["Locacion_Nucleo_IA"] = "/Archive/MVP_Out/Locacion_Nucleo_IA.html",
  ["Acto_II_El_Laberinto"] = "/Archive/MVP_Out/ACTO 2/Acto_II_El_Laberinto.html",
  ["Acto_III_El_Desafio"] = "/Archive/MVP_Out/ACTO 3/Acto_III_El_Desafio.html",
  ["Acto_IV_La_Decision"] = "/Archive/MVP_Out/ACTO 4/Acto_IV_La_Decision.html",
  ["Narrativa_Finales"] = "/Archive/MVP_Out/ACTO FINAL/Narrativa_Finales.html",
  ["Cuentos"] = "/Archive/MVP_Out/Cuentos.html",
  ["GIZMO"] = "/Archive/MVP_Out/GIZMO.html",
  ["Personaje_PP_fantasma"] = "/Archive/MVP_Out/Personaje_PP_fantasma.html",
  ["design_intent_tree"] = "/Archive/MVP_Out/design_intent_tree.html",
  ["feature_sidescroller_zone"] = "/Archive/MVP_Out/feature_sidescroller_zone.html",
  ["feature_test_battery"] = "/Archive/MVP_Out/feature_test_battery.html",
  ["feature_test_runner"] = "/Archive/MVP_Out/feature_test_runner.html",
  ["feature_replay_upload"] = "/Archive/MVP_Out/feature_replay_upload.html",

  -- Arquitectura
  ["Arquitectura de Subsistemas"] = "/Odisea/Arquitectura/Arquitectura de Subsistemas.html",
  ["Core_V2_Resumen"] = "/Odisea/Arquitectura/Core_V2_Resumen.html",
  ["Protocolo_Core_V2"] = "/Odisea/Arquitectura/Protocolo_Core_V2.html",
  ["Protocolo_Desarrollo"] = "/Odisea/Arquitectura/Protocolo_Desarrollo.html",

  -- Producción & Diseño
  ["Pilares"] = "/Odisea/Diseno/Pilares.html",
  ["Status_Report"] = "/Odisea/Produccion/Status_Report.html",
  ["Plan_Implementacion_MVP"] = "/Odisea/Produccion/Backlog/PRODUCTION/Plan_Implementacion_MVP.html",
  ["Ideas_Mecanicas"] = "/Archive/Pendientes/Produccion/Backlog/Ideas_Mecanicas.html",
  ["Motion Capture"] = "/Archive/Pendientes/Archivo/ARCHIVED/Motion Capture.html",
  ["REFACTOR PENDING"] = "/Archive/Pendientes/Archivo/ARCHIVED/REFACTOR PENDING.html",
  ["Manifiesto de carga"] = "/Archive/Pendientes/Manifiesto de carga.html",
  ["Multi-Tool"] = "/Archive/Pendientes/Multi-Tool.html",
}

local function make_image(target, alt)
  local img = target
  if target:match('^_ASSETS/') then
    local fmt = FORMAT or ''
    if fmt:match('html') then
      img = '/Odisea/' .. target
    else
      img = 'Odisea/' .. target
    end
  elseif not img:match('^/') and not img:match('^https?://') and not img:match('^data:') then
    local fmt = FORMAT or ''
    if fmt:match('html') then
      img = '/Odisea/_ASSETS/' .. img
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
    local mapped = VAULT_MAP[t]
    if mapped then
      url = mapped
    elseif t:match('/') then
      url = '/' .. t .. '.html'
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
