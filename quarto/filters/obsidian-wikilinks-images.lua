-- Convierte wikilinks de Obsidian en imágenes/enlaces de Pandoc.
--
-- El mapa del vault lo genera scripts/generate_quarto_config.py a partir del
-- árbol real (quarto/filters/vault_map.lua). No se mantiene a mano: antes se
-- desincronizaba en cada reorganización.
--
-- Las URLs se emiten con "/" inicial, es decir relativas a la RAIZ DEL PROYECTO.
-- Quarto las reescribe a rutas relativas al documento en la salida, con lo que
-- el sitio funciona servido desde un subdirectorio, que es el caso de GitHub
-- Pages (icarito.github.io/Odisea_Design_Docs/). Calcular los "../" a mano no
-- sirve: pandoc recibe una ruta temporal, no la del proyecto.

-- Carga el mapa generado. Si falta, se degrada a resolucion por nombre.
local VAULT_MAP = {}
do
  local dirs = { "quarto/filters/vault_map.lua", "vault_map.lua" }
  for _, d in ipairs(dirs) do
    local ok, res = pcall(dofile, d)
    if ok and type(res) == "table" then VAULT_MAP = res break end
  end
end

local function make_image(target, alt)
  local img = "/_ASSETS/" .. target:gsub("^_ASSETS/", "")
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
  if t:match('^https?://') then
    return pandoc.Link(text, t)
  end
  local mapped = VAULT_MAP[t] or VAULT_MAP[t:match('([^/]+)$') or t]
  if mapped then
    return pandoc.Link(text, "/" .. mapped)
  end
  -- Sin destino publicado: texto en cursiva en vez de un enlace muerto.
  return pandoc.Emph(pandoc.Str(text))
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
