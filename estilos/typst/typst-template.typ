// =====================================================================
//  CÓDIGO ENTRÓPICO — plantilla de impresión (Typst)
//  Libro 17 × 24 cm, brutalista/dadaísta. La web usa estilos/tema.scss;
//  aquí vive la versión en papel. Cambia la paleta y las fuentes abajo.
// =====================================================================

// ---------- Paleta (igual que la web) ----------
#let papel    = rgb("#f2efe6")
#let tinta    = rgb("#111111")
#let rojo     = rgb("#e10600")
#let amarillo = rgb("#ffd400")
#let azul     = rgb("#0033ff")
#let verde    = rgb("#00a651")
#let naranja  = rgb("#ff6b00")
#let violeta  = rgb("#7a00ff")
#let gris     = rgb("#6b6b6b")
#let colores  = (rojo: rojo, azul: azul, amarillo: amarillo, verde: verde,
                 naranja: naranja, violeta: violeta, tinta: tinta)

// ---------- Fuentes (instaladas en Windows) ----------
#let f-titulo  = ("Arial",)                 // se usa con weight: "black" = Arial Black
#let f-texto   = ("Georgia",)
#let f-mono    = ("Cascadia Mono", "Consolas", "Courier New")
#let f-grito   = ("Impact", "Arial")
#let f-recorte = ("Bodoni MT", "Georgia")

// ---------- Geometría de la página ----------
#let ancho-pag = 17cm
#let alto-pag  = 24cm
#let m-dentro  = 2.3cm   // margen del lomo
#let m-fuera   = 1.9cm
#let m-arriba  = 2.3cm
#let m-abajo   = 2.5cm

// ---------- Estado del libro ----------
#let parte-actual = state("parte-actual", none)
#let parte-num    = counter("parte-num")
#let en-cuerpo    = state("en-cuerpo", false)

#let texto-plano(c) = {
  if c == none { "" }
  else if type(c) == str { c }
  else if c.has("text") { c.text }
  else if c.has("children") { c.children.map(texto-plano).join("") }
  else if c.has("body") { texto-plano(c.body) }
  else if c == [ ] { " " }
  else { "" }
}

// ---------- Estilo por capítulo ----------
// En el .qmd: ::: {.estilo-capitulo acento="azul" motivo="puntos" imagen="../imagenes/x.svg"}
#let estilo-capitulo(acento: "rojo", motivo: "rayas", imagen: none) = [#metadata((acento: acento, motivo: motivo, imagen: imagen)) <estilo-cap>]

#let estilo-de-capitulo(desde) = {
  let sig = query(heading.where(level: 1).after(desde, inclusive: false))
  let sel = selector(<estilo-cap>).after(desde)
  if sig.len() > 0 { sel = sel.before(sig.first().location(), inclusive: false) }
  let m = query(sel)
  if m.len() > 0 { m.first().value } else { none }
}
#let acento-de(est) = if est == none { rojo } else { colores.at(est.acento, default: rojo) }
#let acento-aqui() = {
  let caps = query(heading.where(level: 1).before(here()))
  if caps.len() == 0 { rojo } else { acento-de(estilo-de-capitulo(caps.last().location())) }
}

// Motivos gráficos para la banda de apertura
#let motivo-relleno(nombre, c) = {
  if nombre == "puntos" {
    tiling(size: (9pt, 9pt), place(dx: 2pt, dy: 2pt, circle(radius: 2.2pt, fill: c)))
  } else if nombre == "cuadricula" {
    tiling(size: (12pt, 12pt), {
      place(line(start: (0pt, 0pt), end: (12pt, 0pt), stroke: 1pt + c))
      place(line(start: (0pt, 0pt), end: (0pt, 12pt), stroke: 1pt + c))
    })
  } else if nombre == "ruido" {
    tiling(size: (16pt, 16pt), {
      place(dx: 1pt, dy: 3pt, rect(width: 5pt, height: 2pt, fill: c))
      place(dx: 9pt, dy: 10pt, rect(width: 3pt, height: 3pt, fill: c))
      place(dx: 4pt, dy: 12pt, rect(width: 2pt, height: 1pt, fill: tinta))
    })
  } else {
    tiling(size: (10pt, 10pt), place(line(start: (0pt, 10pt), end: (10pt, 0pt), stroke: 2.5pt + c)))
  }
}

// ---------- Recursos del libro ----------
#let pizarra(titulo: none, cuerpo) = block(
  width: 100%, breakable: true, fill: rgb("#1f3b2d"),
  stroke: 5pt + rgb("#6b4a2b"), inset: (x: 13pt, y: 12pt), above: 1.5em, below: 1.5em,
)[
  #set text(font: f-mono, size: 8.4pt, fill: rgb("#f4f1e8"))
  #set par(justify: false, leading: 0.72em, spacing: 0.9em)
  #show strong: set text(fill: white, weight: "bold")
  #show emph: set text(fill: rgb("#b8e0c8"))
  #show raw: set text(fill: amarillo)
  #set list(marker: text(fill: amarillo)[▪])
  #if titulo != none {
    block(below: 0.9em, text(fill: amarillo, weight: "bold", tracking: 0.08em, upper(titulo)))
  }
  #cuerpo
]

#let grito(cuerpo) = context {
  let a = acento-aqui()
  block(width: 100%, above: 1.8em, below: 1.8em, breakable: false,
    rotate(-2deg, reflow: true, {
      set text(font: f-grito, size: 30pt, fill: a, hyphenate: false)
      set par(leading: 0.3em, justify: false, spacing: 0.3em)
      upper(cuerpo)
    }))
}

#let recorte(cuerpo) = block(width: 100%, inset: (left: 4%, right: 8%), above: 2em, below: 2em, breakable: false,
  rotate(1.2deg, reflow: true,
    block(fill: white, stroke: 0.6pt + tinta, inset: (x: 14pt, y: 13pt), width: 100%, {
      place(top + center, dy: -21pt, rotate(-4deg, rect(width: 2.4cm, height: 0.55cm, fill: amarillo.transparentize(15%))))
      set text(font: f-recorte, style: "italic", size: 11.5pt)
      set par(justify: false, leading: 0.6em)
      cuerpo
    })))

#let manifiesto(cuerpo) = context {
  let a = acento-aqui()
  block(width: 100%, fill: tinta, stroke: (left: 9pt + a), inset: (x: 14pt, y: 12pt), above: 1.5em, below: 1.5em, breakable: false, {
    set text(font: f-mono, size: 8.2pt, fill: papel, tracking: 0.02em)
    set par(justify: false, leading: 0.7em)
    set enum(numbering: n => text(fill: a, weight: "bold")[#n.], spacing: 0.9em)
    upper(cuerpo)
  })
}

#let ruido(cuerpo) = block(above: 1.2em, below: 1.2em, {
  set text(font: f-mono, size: 9pt, tracking: 0.18em, fill: tinta.transparentize(15%))
  set par(justify: false)
  cuerpo
})

#let tachado(c) = strike(stroke: 1.6pt + rojo, c)
#let marcador(c) = highlight(fill: amarillo, top-edge: "x-height", bottom-edge: -2pt, c)

#let etiqueta-pestana(t) = block(above: 1.1em, below: 0.4em, sticky: true,
  box(stroke: 1.2pt + tinta, inset: (x: 6pt, y: 3pt),
    text(font: f-mono, size: 7.5pt, weight: "bold", tracking: 0.08em)[▸ #upper(t)]))

// Imagen al costado: el texto queda al lado (la imagen "repele" al texto)
#let figura-lado(lado: "izq", ancho: 42%, fig, cuerpo) = {
  let cols  = if lado == "izq" { (ancho, 1fr) } else { (1fr, ancho) }
  let celdas = if lado == "izq" { (fig, cuerpo) } else { (cuerpo, fig) }
  block(above: 1.3em, below: 1.3em,
    grid(columns: cols, column-gutter: 15pt, align: top, ..celdas))
}

// Imagen anclada abajo de la hoja, debajo del texto
#let figura-pie(lado: "izq", ancho: 60%, fig) = {
  let al = if lado == "der" { bottom + right } else if lado == "centro" { bottom + center } else { bottom + left }
  place(al, float: true, clearance: 1.4em, box(width: ancho, fig))
}

// Introducción de una parte (texto sobre la página negra)
#let parte-intro(cuerpo) = block(width: 75%, {
  set text(font: f-mono, size: 9.5pt, fill: papel)
  set par(justify: false, leading: 0.75em)
  cuerpo
})

// ---------- Callouts de Quarto, rediseñados ----------
#let callout(body: [], title: "Callout", background_color: rgb("#dddddd"), icon: none, icon_color: black, body_background_color: white) = {
  let mapa = ("#cc1914": rojo, "#00a047": azul, "#eb9113": amarillo, "#fc5300": naranja, "#0758e5": tinta)
  let barra = mapa.at(icon_color.to-hex(), default: tinta)
  block(breakable: true, width: 100%, fill: white, above: 1.4em, below: 1.4em,
    stroke: (left: 7pt + barra, rest: 1.2pt + tinta), inset: 0pt,
    block(width: 100%, below: 0pt, block(width: 100%, fill: papel, inset: (x: 10pt, y: 6pt),
        stroke: (bottom: 1pt + tinta),
        text(font: f-mono, size: 8pt, weight: "bold", tracking: 0.06em)[#upper(title)])) +
    if body != [] {
      block(width: 100%, inset: (x: 11pt, y: 9pt), body)
    })
}

// ---------- Código (bloques de Skylighting) ----------
#let Skylighting(fill: none, number: false, start: 1, sourcelines) = {
  let lineas = []
  let n = start - 1
  for ln in sourcelines {
    if number {
      n = n + 1
      lineas = lineas + box(width: 18pt, text(fill: gris, size: 6.5pt)[#n])
    }
    lineas = lineas + ln + EndLine()
  }
  block(fill: white, width: 100%, inset: (x: 10pt, y: 9pt), breakable: true, above: 1em, below: 1.3em,
    stroke: (left: 1.2pt + tinta, top: 1.2pt + tinta, right: 4pt + tinta, bottom: 4pt + tinta),
    { set text(size: 7.6pt); set par(justify: false, leading: 0.55em); lineas })
}
#let KeywordTok(s)     = text(weight: "bold", fill: tinta, raw(s))
#let ControlFlowTok(s) = text(weight: "bold", fill: rojo, raw(s))
#let StringTok(s)      = text(fill: azul, raw(s))
#let DecValTok(s)      = text(fill: rojo, raw(s))
#let CommentTok(s)     = text(style: "italic", fill: gris, raw(s))
#let BuiltInTok(s)     = text(weight: "bold", fill: azul, raw(s))
#let VariableTok(s)    = text(fill: rojo, raw(s))
#let OperatorTok(s)    = text(fill: tinta, raw(s))
#let FunctionTok(s)    = text(fill: azul, raw(s))
#let NormalTok(s)      = text(fill: tinta, raw(s))

// ---------- Partes ----------
#let part(titulo) = {
  [#metadata(none) <fin-cap>]
  pagebreak(to: "odd", weak: true)
  parte-num.step()
  parte-actual.update(titulo)
  [#metadata(titulo) <parte-marca>]
  [#metadata(none) <apertura>]
  let s = texto-plano(titulo)
  let trozos = s.split(":")
  let nombre = if trozos.len() > 1 { trozos.slice(1).join(":").trim() } else { s }
  place(top + left, dx: -m-dentro, dy: -m-arriba, rect(width: ancho-pag, height: alto-pag, fill: tinta))
  place(top + left, dx: -m-dentro, dy: alto-pag - m-arriba - 3.2cm,
    rect(width: ancho-pag, height: 1.1cm, fill: motivo-relleno("rayas", rojo)))
  context {
    let num = parte-num.get().first()
    block(height: 6.5cm, {
      place(top + left, text(font: f-mono, size: 10pt, fill: papel, tracking: 0.3em)[PARTE])
      place(top + left, dy: 0.4cm, text(font: f-titulo, weight: "black", size: 150pt, fill: rojo, numbering("I", num)))
    })
  }
  block(width: 100%, {
    set par(justify: false, leading: 0.35em)
    let partes = nombre.split("—")
    text(font: f-titulo, weight: "black", size: 28pt, fill: papel, upper(partes.first().trim()))
    if partes.len() > 1 {
      v(0.5em)
      text(font: f-mono, size: 11pt, fill: amarillo, upper(partes.slice(1).join("—").trim()))
    }
  })
  v(1cm)
}
#let chapter(title, image: none, l: none) = heading(level: 1, title)
#let appendices(title, doc, hide-parent: false) = doc

// ---------- Índice ----------
#let indice() = {
  block(width: 100%, fill: tinta, inset: (x: 7pt, y: 5pt), below: 0pt,
    text(font: f-mono, size: 7.5pt, fill: papel, tracking: 0.15em)[CÓDIGO ENTRÓPICO #h(1fr) MAPA DEL LIBRO])
  block(width: 100%, height: 1.3cm, below: 0pt, rect(width: 100%, height: 100%, fill: motivo-relleno("cuadricula", rojo), stroke: (x: 1.5pt + tinta)))
  v(0.4cm)
  text(font: f-titulo, weight: "black", size: 28pt)[ÍNDICE]
  v(0.2cm)
  line(length: 100%, stroke: 4pt + tinta)
  v(0.4cm)
  context {
    let items = query(selector(<parte-marca>).or(heading.where(level: 1)))
    for it in items {
      if it.func() == metadata {
        let s = texto-plano(it.value)
        let pn = parte-num.at(it.location()).first()
        block(above: 1.3em, below: 0.6em, width: 100%, fill: tinta, inset: (x: 7pt, y: 5pt),
          text(font: f-titulo, weight: "black", size: 9pt, fill: papel)[#text(fill: rojo)[#numbering("I", pn)] #h(6pt) #upper(s.split(":").slice(1).join(":").trim())])
      } else if it.outlined {
        let aps = query(selector(<apertura>).after(it.location()))
        let destino = if aps.len() > 0 { aps.first().location() } else { it.location() }
        let pag = counter(page).at(destino).first()
        let numerado = it.numbering != none
        let n = if numerado { counter(heading).at(it.location()).first() }
        link(destino, block(above: 0.35em, below: 0.35em, width: 100%,
          grid(columns: (1.1cm, 1fr, 1cm), column-gutter: 6pt, align: (left + top, left + top, right + top),
            text(font: f-mono, size: 8.5pt, weight: "bold")[#if numerado { if n < 10 { "0" + str(n) } else { str(n) } } else { "—" }],
            { set par(justify: false); text(size: 9.3pt, hyphenate: false, it.body) },
            text(font: f-mono, size: 8.5pt, weight: "bold")[#pag])))
      }
    }
  }
}

// ---------- El libro ----------
#let libro(
  title: none, subtitle: none, autor: none, fecha: none, descripcion: none,
  portada: none, lang: "es", doc,
) = {
  set document(title: title, author: if autor != none { autor } else { () })
  set text(font: f-texto, size: 10pt, lang: lang, region: "BO", hyphenate: true, fill: tinta)
  set par(justify: true, leading: 0.68em, spacing: 1.05em, first-line-indent: 0pt)
  show raw: set text(font: f-mono, size: 1em)
  set list(marker: ([▪], [–]), indent: 0.4em)
  set enum(indent: 0.2em)
  set bibliography(title: none)

  set page(
    width: ancho-pag, height: alto-pag,
    margin: (inside: m-dentro, outside: m-fuera, top: m-arriba, bottom: m-abajo),
    header: context {
      let p = here().page()
      let blanca = query(<fin-cap>).any(f => f.location().page() == p - 1) and query(<apertura>).any(a => a.location().page() == p + 1)
      let apertura = query(<apertura>).any(a => a.location().page() == p)
      if en-cuerpo.get() and not blanca and not apertura {
      let a = acento-aqui()
      set text(font: f-mono, size: 6.8pt, tracking: 0.1em)
      let par-pag = calc.even(counter(page).get().first())
      let caps = query(heading.where(level: 1).before(here()))
      let cap = if caps.len() > 0 { caps.last() } else { none }
      let izq = if par-pag {
        let pt = parte-actual.get()
        [CÓDIGO ENTRÓPICO #if pt != none [#h(4pt) · #h(4pt) #upper(texto-plano(pt).split(":").first())]]
      } else if cap != none {
        let t = texto-plano(cap.body).split(":").first()
        [#if cap.numbering != none [CAP. #counter(heading).at(cap.location()).first() #h(4pt) · #h(4pt)]#upper(t)]
      }
      block(width: 100%, stroke: (bottom: 0.8pt + tinta), inset: (bottom: 4pt),
        if par-pag { [#box(fill: a, width: 5pt, height: 5pt) #h(5pt) #izq] }
        else { align(right)[#izq #h(5pt) #box(fill: a, width: 5pt, height: 5pt)] })
      }
    },
    footer: context {
      let p = here().page()
      let blanca = query(<fin-cap>).any(f => f.location().page() == p - 1) and query(<apertura>).any(a => a.location().page() == p + 1)
      if en-cuerpo.get() and not blanca {
        let n = counter(page).get().first()
        let caja = box(fill: tinta, inset: (x: 6pt, y: 4pt), text(font: f-mono, size: 8pt, weight: "bold", fill: white)[#n])
        if calc.even(n) { align(left, caja) } else { align(right, caja) }
      }
    },
  )

  // Numeración: capítulo.número
  set heading(numbering: "1.1")
  set figure(numbering: n => {
    let c = counter(heading).get().first()
    if c == 0 { numbering("1", n) } else { numbering("1.1", c, n) }
  })
  show figure: set block(breakable: false)
  show figure.caption: it => context {
    set text(font: f-mono, size: 7.4pt)
    set par(justify: false)
    if it.numbering != none {
      text(weight: "bold", fill: acento-aqui())[#upper(it.supplement) #it.counter.display(it.numbering)]
      [ — ]
    }
    it.body
  }

  // Tablas: rejilla expuesta
  set table(stroke: 0.6pt + tinta, inset: (x: 5pt, y: 4.5pt), fill: (x, y) => if y == 0 { tinta })
  show table.cell.where(y: 0): set text(fill: white, font: f-mono, size: 7pt, weight: "bold")
  show table: set text(size: 8.4pt)
  show table: set par(justify: false, leading: 0.55em)

  // Citas en bloque
  show quote.where(block: true): it => context block(width: 100%, inset: (left: 12pt, y: 4pt),
    stroke: (left: 3pt + acento-aqui()), text(style: "italic", it.body))

  // Notas de código (anotaciones numeradas)
  show terms.item: it => block(above: 0.5em, below: 0.5em, grid(columns: (auto, 1fr), column-gutter: 7pt,
    box(fill: tinta, inset: (x: 4pt, y: 2.5pt), text(fill: white, font: f-mono, size: 6.8pt, weight: "bold", upper(it.term))),
    text(size: 9pt, it.description)))

  show link: set text(fill: tinta)
  show ref: set text(fill: tinta)

  // ---- Títulos ----
  show heading.where(level: 1): it => {
    [#metadata(none) <fin-cap>]
    pagebreak(to: "odd", weak: true)
    [#metadata(none) <apertura>]
    context {
      let est = estilo-de-capitulo(here())
      let a = acento-de(est)
      let numerado = it.numbering != none
      let n = counter(heading).get().first()
      let pt = parte-actual.get()
      set par(justify: false)
      // Banda superior
      block(width: 100%, fill: tinta, inset: (x: 7pt, y: 5pt), below: 0pt,
        text(font: f-mono, size: 7.5pt, fill: papel, tracking: 0.15em)[
          #if numerado [CAPÍTULO #if n < 10 [0]#n] else [CÓDIGO ENTRÓPICO]
          #h(1fr)
          #if pt != none and numerado { upper(texto-plano(pt).split(":").first()) }
        ])
      // Imagen o motivo
      if est != none and est.imagen != none {
        block(width: 100%, height: 5.2cm, clip: true, stroke: 1.5pt + tinta, below: 0pt,
          image(est.imagen, width: 100%, height: 5.2cm, fit: "cover"))
      } else {
        block(width: 100%, height: 1.3cm, below: 0pt, stroke: (x: 1.5pt + tinta),
          rect(width: 100%, height: 100%, fill: motivo-relleno(if est != none { est.motivo } else { "rayas" }, a), stroke: none))
      }
      v(0.4cm)
      if numerado {
        grid(columns: (auto, 1fr), column-gutter: 12pt, align: (left + bottom, left + bottom),
          rotate(-4deg, reflow: true, text(font: f-titulo, weight: "black", size: 92pt, fill: a)[#if n < 10 [0]#n]),
          block(text(font: f-titulo, weight: "black", size: 19pt, hyphenate: false, upper(it.body))))
      } else {
        block(text(font: f-titulo, weight: "black", size: 28pt, hyphenate: false, upper(it.body)))
      }
      v(0.25cm)
      line(length: 100%, stroke: 4pt + tinta)
      v(0.9cm)
    }
  }

  show heading.where(level: 2): it => context {
    let a = acento-aqui()
    v(1.5em, weak: true)
    block(width: 100%, fill: tinta, inset: (x: 8pt, y: 6pt), below: 1em, sticky: true, {
      set text(font: f-titulo, weight: "black", size: 11.5pt, fill: white, hyphenate: false)
      set par(justify: false)
      if it.numbering != none { text(fill: a)[#counter(heading).display(it.numbering)]; h(9pt) }
      upper(it.body)
    })
  }

  show heading.where(level: 3): it => context {
    let a = acento-aqui()
    v(1.2em, weak: true)
    block(below: 0.75em, sticky: true, {
      set text(font: f-titulo, weight: "black", size: 10.5pt, hyphenate: false)
      set par(justify: false)
      box(fill: a, width: 7pt, height: 7pt)
      h(6pt)
      if it.numbering != none { text(font: f-mono, weight: "regular", size: 8.5pt, fill: gris)[#counter(heading).display(it.numbering)]; h(5pt) }
      it.body
    })
  }

  show heading.where(level: 4): it => block(above: 1em, below: 0.6em, sticky: true,
    text(font: f-titulo, weight: "bold", size: 9.5pt, it.body))

  // ---- Portada ----
  if portada != none {
    page(margin: 0pt, header: none, footer: none, image(portada, width: 100%, height: 100%, fit: "cover"))
    page(header: none, footer: none)[]
  }

  // ---- Portadilla ----
  page(header: none, footer: none, {
    set par(justify: false)
    v(2cm)
    block(width: 100%, stroke: (bottom: 6pt + tinta), inset: (bottom: 10pt),
      text(font: f-titulo, weight: "black", size: 34pt, hyphenate: false, upper(title)))
    if subtitle != none {
      v(0.4cm)
      text(font: f-mono, size: 11pt, subtitle)
    }
    v(1fr)
    if autor != none { text(font: f-titulo, weight: "black", size: 14pt, fill: rojo, upper(autor)) }
    v(0.3cm)
    line(length: 100%, stroke: 1pt + tinta)
    v(0.2cm)
    if descripcion != none { text(font: f-mono, size: 7.5pt, descripcion) }
  })

  // ---- Créditos ----
  page(header: none, footer: none, {
    set text(font: f-mono, size: 7.2pt)
    set par(justify: false)
    v(1fr)
    [#upper(title) #linebreak() #subtitle]
    v(0.6em)
    if autor != none [© #autor. #fecha]
    v(0.6em)
    if descripcion != none { descripcion }
    v(0.6em)
    [Compuesto con Quarto y Typst. Formato 17 × 24 cm.]
  })

  // ---- Índice ----
  page(header: none, footer: none, indice())

  // ---- Cuerpo ----
  pagebreak(to: "odd", weak: true)
  counter(page).update(1)
  en-cuerpo.update(true)
  doc
}
