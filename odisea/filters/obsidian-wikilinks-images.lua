function walk_obsidian_links(el)
  if el.t == "Str" then
    local s = el.text
    -- Wikilink de imagen: ![[imagen.png]]
    if s:match('^!%[%[.+%]%]$') then
      local img = s:match('^!%[%[(.+)%]%]$')
      if not img:match('^assets/') then
        img = 'assets/' .. img
      end
      return pandoc.Image({}, img)
    end
    -- Wikilink interno: [[Nota]] o [[Nota|Alias]]
    local link, alias = s:match('%[%[([^|%]]+)%|?([^%]]*)%]%]')
    if link then
      local text = alias ~= "" and alias or link
      -- Puedes personalizar la URL aquí si quieres .html, .md, etc.
      local url = link .. ".html"
      return pandoc.Link(text, url)
    end
  end
  return el
end

return {
  {Str = walk_obsidian_links}
}