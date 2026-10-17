# Código Entrópico

*La evolución del desarrollo de software frente al ojo de la IA* — libro en Quarto: web, PDF para imprimir (Typst) y ePub, todo desde los mismos archivos `.qmd`.

## Requisitos

1. Quarto 1.10 o superior: `winget install --id Posit.Quarto`. Ya trae Typst, así que **no hace falta LaTeX ni TinyTeX**.
2. Recomendado: la extensión **Quarto** de VS Code.

## Comandos

| Acción | Comando |
|---|---|
| **Generar todo** (web + PDF + ePub) | `.\construir.ps1` |
| Solo el PDF impreso (conserva la web) | `.\construir.ps1 -Solo pdf` |
| Solo la web | `.\construir.ps1 -Solo web` |
| Ver el libro (sin volver a generar) | `quarto preview --no-render` |
| **Hojear el PDF como libro** | abrir `http://localhost:4848/hojear.html` con la vista previa activa |

Todo queda en `_book/`: `index.html` (web), `codigo-entropico.pdf` (impreso), `codigo-entropico.epub` y `hojear.html`.

> No uses `quarto render --to typst` solo: borra la web de `_book/`. Para eso existe `construir.ps1`.

## El libro impreso

| | |
|---|---|
| Formato | 17 × 24 cm (libro técnico o académico), a una columna |
| Márgenes | lomo 2,3 cm · exterior 1,9 cm · arriba 2,3 cm · abajo 2,5 cm |
| Fuentes | títulos Arial Black · texto Georgia 10 pt · código Cascadia Mono |
| Estructura | portada → portadilla → créditos → índice → partes en página negra → capítulos que abren en página impar |
| Numeración | capítulos 01–47; secciones 1.1, 1.1.1; Figura/Tabla/Código 1.1 por capítulo; páginas en caja negra |
| Citas | APA (autor, año), con la bibliografía al final |

## Estructura

```
_quarto.yml               configuración, orden de capítulos y formatos
index.qmd                 prefacio
introduccion.qmd          ¿para qué aprender si la IA ya programa?
ciclo-entropico.qmd       patrón de enseñanza
partes/                   portadas de cada parte
capitulos/                47 capítulos (01-...qmd a 47-...qmd)
epilogo.qmd · referencias.qmd · references.bib
imagenes/capNN/           ilustraciones de cada capítulo
portada/                  portada (17:24)
estilos/tema.scss         diseño web
estilos/typst/            diseño impreso
estilos/filtros/          traduce los recursos del libro a web y papel
hojear.html               visor para hojear el PDF
.claude/skills/capitulo/  skill /capitulo + AVANCE.md (memoria entre sesiones)
```

## Recursos del libro (funcionan igual en web y papel)

```markdown
::: {.estilo-capitulo acento="azul" motivo="puntos" imagen="../imagenes/capNN/apertura.svg"}
:::
::: {.pizarra}    **Pizarra del Inge** ...  :::
::: {.grito}      ...  :::     ::: {.recorte} ... :::     ::: {.manifiesto} ... :::
::: {.figura-der ancho="44%"}  ![Pie](img.svg){#fig-cNN-x}  texto al costado  :::
::: {.figura-pie lado="izq" ancho="60%"}  ![Pie](img.svg){#fig-cNN-x}  :::
[tachado]{.tachado}   [resaltado]{.marcador}
```

## Flujo de trabajo

- Escribe los capítulos con la skill `/capitulo NN borrador`. La skill lee y actualiza `.claude/skills/capitulo/AVANCE.md`.
- Cada capítulo tiene en su encabezado `estado: pendiente | borrador | revision | listo`.
- Citas: agrega la fuente en `references.bib` y cítala con `[@clave]`.
- Para sacar un capítulo temporalmente, coméntalo en `_quarto.yml` con `#`.
