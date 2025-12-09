local stringify = (require "pandoc.utils").stringify

function BlockQuote(el)
  local start = el.content[1]
  if (start and start.t == "Para" and start.content[1] and start.content[1].t == "Str" and start.content[1].text:match("^%[!%w+%][-+]?%]")) then
    local firstline = stringify(start.content[1])
    local _, _, ctype = firstline:find("%[!(%w+)%]")
    local titlevar = stringify(start.content):match("^%[!%w+%](.-)$")
    el.content:remove(1)
    return quarto.Callout({
      type = ctype:lower(),
      title = titlevar,
      content = el.content
    })
  else
    return el
  end
end