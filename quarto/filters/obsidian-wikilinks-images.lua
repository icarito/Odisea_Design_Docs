-- Convierte wikilinks de Obsidian en imágenes/enlaces de Pandoc.
-- Soporta múltiples ocurrencias por token, p.ej.:
--   ![[a.png]]![[b.png]] y [[Nota|Alias]] dentro del mismo Str

local function make_image(target, alt)
  local img = target
  if not img:match('^assets/') and not img:match('^https?://') and not img:match('^data:') then
    img = 'assets/' .. img
  end
  if alt and alt ~= '' then
    return pandoc.Image(alt, img)
  else
    return pandoc.Image({}, img)
  end
end

local function make_link(target, alias)
  local text = (alias and alias ~= '' and alias) or target
  if target:match('^https?://') then
    url = target
  elseif target:match("/") then
    url = target .. ".html"
  else
    -- Obtener la subcarpeta del archivo actual
    local input_file = PANDOC_STATE and PANDOC_STATE.input_files and PANDOC_STATE.input_files[1] or nil
    local subfolder = input_file and input_file:match("vault/([^/]+)/") or nil
    if subfolder then
      url = subfolder .. "/" .. target .. ".html"
    else
      url = target .. ".html" -- fallback
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

    -- Elegir la próxima coincidencia (imagen o enlace) más cercana
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
  if el.t ~= 'Str' then
    return el
  end

  local nodes = split_wikilinks(el.text)
  -- Si no se detectaron wikilinks, mantener el token original
  if #nodes == 1 and nodes[1].t == 'Str' and nodes[1].text == el.text then
    return el
  end
  return nodes
end

return {
  { Str = walk_obsidian_links }
}