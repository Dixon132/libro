--[[
  libro.lua — traduce los recursos de "Código Entrópico" a cada formato.

  En el .qmd se escriben igual para web y papel:
    ::: {.pizarra} ::: {.grito} ::: {.recorte} ::: {.manifiesto} ::: {.ruido}
    ::: {.parte-intro}
    ::: {.figura-izq ancho="40%"}  imagen + texto que la rodea   :::
    ::: {.figura-der ancho="40%"}  texto + imagen al costado     :::
    ::: {.figura-pie lado="izq" ancho="60%"}  imagen anclada abajo de la hoja :::
    ::: {.estilo-capitulo acento="azul" motivo="puntos" imagen="../imagenes/x.svg"} :::
    [texto]{.tachado}  [texto]{.marcador}

  Web (HTML): las clases las pinta estilos/tema.scss.
  Papel (Typst): se convierten en funciones de estilos/typst/typst-template.typ.
]]

local es_typst = quarto.doc.is_format("typst")
local es_html  = quarto.doc.is_format("html") and not quarto.doc.is_format("epub")

local colores = {
  rojo = "#e10600", azul = "#0033ff", amarillo = "#ffd400", verde = "#00a651",
  naranja = "#ff6b00", violeta = "#7a00ff", tinta = "#111111",
}

local function crudo(s) return pandoc.RawBlock("typst", s) end

local function envolver(abrir, bloques, cerrar)
  local out = { crudo(abrir) }
  for _, b in ipairs(bloques) do table.insert(out, b) end
  table.insert(out, crudo(cerrar or "]"))
  return out
end

local function cadena_typst(s)
  return '"' .. s:gsub("\\", "\\\\"):gsub('"', '\\"') .. '"'
end

local function desde(lista, i)
  local out = pandoc.List()
  for k = i, #lista do out:insert(lista[k]) end
  return out
end

-- La figura es el PRIMER bloque del div (imagen, figura de Quarto o diagrama);
-- se deja intacta para que Quarto la numere y la pueda citar con @fig-...
local function separar_figura(div)
  local resto = pandoc.List()
  for k = 2, #div.content do resto:insert(div.content[k]) end
  return div.content[1], resto
end
local function concatenar(...)
  local out = {}
  for _, lista in ipairs({ ... }) do for _, b in ipairs(lista) do table.insert(out, b) end end
  return out
end

local function div_typst(div)
  local c = div.classes
  if c:includes("pizarra") then
    local bloques = div.content
    local primero = bloques[1]
    -- "**Pizarra del Inge**" al inicio se vuelve el título de la pizarra
    if primero and primero.t == "Para" and primero.content[1] and primero.content[1].t == "Strong" then
      local titulo = primero.content[1]
      local resto_para = desde(primero.content, 2)
      while #resto_para > 0 and (resto_para[1].t == "Space" or resto_para[1].t == "SoftBreak" or resto_para[1].t == "LineBreak") do
        resto_para = desde(resto_para, 2)
      end
      local cuerpo = desde(bloques, 2)
      if #resto_para > 0 then cuerpo:insert(1, pandoc.Para(resto_para)) end
      return concatenar({ crudo("#pizarra(titulo: ["), pandoc.Plain(titulo.content), crudo("])[") }, cuerpo, { crudo("]") })
    end
    return envolver("#pizarra[", bloques)
  end
  if c:includes("grito") then return envolver("#grito[", div.content) end
  if c:includes("recorte") then return envolver("#recorte[", div.content) end
  if c:includes("manifiesto") then return envolver("#manifiesto[", div.content) end
  if c:includes("ruido") then return envolver("#ruido[", div.content) end
  if c:includes("parte-intro") then return envolver("#parte-intro[", div.content) end

  if c:includes("estilo-capitulo") then
    local a = div.attributes
    local imagen = a["imagen"] and cadena_typst((a["imagen"]:gsub("^%.%./", ""))) or "none"
    return crudo(string.format('#estilo-capitulo(acento: %s, motivo: %s, imagen: %s)',
      cadena_typst(a["acento"] or "rojo"), cadena_typst(a["motivo"] or "rayas"), imagen))
  end

  if c:includes("figura-izq") or c:includes("figura-der") then
    local fig, resto = separar_figura(div)
    if fig == nil then return nil end
    local lado = c:includes("figura-izq") and "izq" or "der"
    local ancho = div.attributes["ancho"] or "42%"
    return concatenar(
      { crudo(string.format('#figura-lado(lado: "%s", ancho: %s, [', lado, ancho)) },
      { fig }, { crudo("], [") }, resto, { crudo("])") })
  end

  if c:includes("figura-pie") then
    local fig, resto = separar_figura(div)
    if fig == nil then return nil end
    local lado = div.attributes["lado"] or "izq"
    local ancho = div.attributes["ancho"] or "60%"
    return concatenar(resto,
      { crudo(string.format('#figura-pie(lado: "%s", ancho: %s, [', lado, ancho)) },
      { fig }, { crudo("])") })
  end

  return nil
end

local function div_html(div)
  local c = div.classes
  if c:includes("estilo-capitulo") then
    local a = div.attributes
    local color = colores[a["acento"] or "rojo"] or a["acento"] or colores.rojo
    local html = '<style>:root{--acento:' .. color .. ';}</style>'
    if a["imagen"] then
      html = html .. '<div class="apertura-capitulo motivo-' .. (a["motivo"] or "rayas") ..
        '"><img src="' .. a["imagen"] .. '" alt=""></div>'
    else
      html = html .. '<div class="apertura-capitulo motivo-' .. (a["motivo"] or "rayas") .. '"></div>'
    end
    return pandoc.RawBlock("html", html)
  end
  if c:includes("figura-izq") or c:includes("figura-der") or c:includes("figura-pie") then
    local ancho = div.attributes["ancho"]
    if ancho then div.attributes["style"] = "--ancho:" .. ancho .. ";" end
    return div
  end
  return nil
end

return {
  {
    Div = function(div)
      if es_typst then return div_typst(div) end
      if es_html then return div_html(div) end
      return nil
    end,
    Span = function(sp)
      if not es_typst then return nil end
      local nombre = sp.classes:includes("tachado") and "tachado" or (sp.classes:includes("marcador") and "marcador" or nil)
      if not nombre then return nil end
      local out = { pandoc.RawInline("typst", "#" .. nombre .. "[") }
      for _, i in ipairs(sp.content) do table.insert(out, i) end
      table.insert(out, pandoc.RawInline("typst", "]"))
      return out
    end,
    -- Quarto convierte ::: {.panel-tabset} en un nodo propio antes de este filtro
    Tabset = function(el)
      if not es_typst then return nil end
      local out = pandoc.Blocks({})
      for _, tab in ipairs(el.tabs) do
        out:insert(crudo("#etiqueta-pestana[" .. pandoc.utils.stringify(tab.title) .. "]"))
        if tab.content.t then
          -- el contenido viene envuelto en un Div: se desenvuelve
          if tab.content.t == "Div" then out:extend(tab.content.content) else out:insert(tab.content) end
        else
          out:extend(tab.content)
        end
      end
      return out
    end,
  },
}
