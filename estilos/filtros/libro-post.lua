--[[
  libro-post.lua — corre después de Quarto, solo para papel (Typst).
  Ajusta el tamaño de los diagramas mermaid para que quepan en la página de 17 × 24 cm.
]]

if not quarto.doc.is_format("typst") then return {} end

local MAX_ANCHO = 4.9   -- pulgadas (≈ ancho de la caja de texto)
local MAX_ALTO  = 6.0   -- pulgadas

local function pulgadas(v)
  if not v then return nil end
  local n, u = v:match("^([%d%.]+)%s*(%a*)$")
  n = tonumber(n)
  if not n then return nil end
  if u == "" or u == "in" then return n end
  if u == "cm" then return n / 2.54 end
  if u == "mm" then return n / 25.4 end
  if u == "pt" then return n / 72 end
  if u == "px" then return n / 96 end
  return nil
end

return {
  {
    Image = function(img)
      if not img.src:match("mermaid%-figure") then return nil end
      local w, h = pulgadas(img.attributes["width"]), pulgadas(img.attributes["height"])
      if not (w and h) then return nil end
      local escala = math.min(1, MAX_ANCHO / w, MAX_ALTO / h)
      img.attributes["width"]  = string.format("%.2fin", w * escala)
      img.attributes["height"] = string.format("%.2fin", h * escala)
      return img
    end,
  },
}
