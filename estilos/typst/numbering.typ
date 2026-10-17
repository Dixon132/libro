// Numeración por capítulo (capítulo.número), igual que figuras y tablas
#let equation-numbering = it => numbering("(1.1)", counter(heading).get().first(), it)
#let callout-numbering = it => numbering("1.1", counter(heading).get().first(), it)
#let subfloat-numbering(n-super, subfloat-idx) = numbering("1.1a", counter(heading).get().first(), n-super, subfloat-idx)
#let theorem-inherited-levels = 1
#let theorem-numbering(loc) = "1.1"
#let theorem-render(prefix: none, title: "", full-title: auto, body) = {
  block(width: 100%, inset: (left: 1em), stroke: (left: 2pt + black))[
    #if full-title != "" and full-title != auto and full-title != none { strong[#full-title]; linebreak() }
    #body
  ]
}
