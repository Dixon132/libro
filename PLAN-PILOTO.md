# Plan del piloto — Código Entrópico

**Meta del piloto:** un libro corto que ya *se vea* como el libro final y demuestre el Ciclo Entrópico
en las cuatro partes. No son 47 capítulos: son **4 capítulos completos + todo lo que los rodea**.

## Qué entra en el piloto

| Pieza | Archivo | Estado meta |
|---|---|---|
| Portada | `portada/portada.svg` (luego PNG del collage final) | lista |
| Prefacio | `index.qmd` | revisión |
| El Ciclo Entrópico | `ciclo-entropico.qmd` | lista |
| Parte I → Cap. 1 Pensar antes de programar | `capitulos/01-...qmd` | **borrador hecho** (nacen el mercado, el Inge y Caserita) |
| Parte I → Cap. 14 Git (modelo) | `capitulos/14-...qmd` | listo |
| Parte II → Cap. 23 Comunicarse con la máquina | `capitulos/23-...qmd` | borrador |
| Parte III → Cap. 31 RAG | `capitulos/31-rag.qmd` | borrador |
| Parte IV → Cap. 42 Soberanía de datos | `capitulos/42-...qmd` | borrador |
| Epílogo: El orden no se hereda, se trabaja | `epilogo.qmd` | borrador (cierra el Ciclo Entrópico del libro) |

Los demás capítulos se quedan como plantilla; el piloto los puede ocultar (ver Fase 4).

## Fase 1 — Identidad visual (ya iniciada)

- [x] Tema brutalista/dadaísta en `estilos/tema.scss`: papel, tinta, rojo, amarillo, azul; sin bordes redondeados; sombras duras.
- [x] Recursos de collage: `.grito`, `.recorte`, `.manifiesto`, `.tachado`, `.marcador`, `.ruido`, `.parte-cartel`.
- [x] Portada provisional en SVG, conectada con `cover-image` en `_quarto.yml`.
- [ ] Hacer el collage real de la portada (recortes físicos escaneados, fotocopias, Canva/Photopea) y exportarlo a **PNG de 1600×2400**. Reemplazar en `cover-image`.
- [ ] Una imagen-cartel por parte (4), en `portada/parte1.png`, etc. Insertarla en `partes/parteN.qmd` con `![](../portada/parte1.png)`.
- [ ] Decidir la paleta final: cambiar solo las 5 variables al inicio de `tema.scss`.

**Cómo cambiar colores:** edita `$papel`, `$tinta`, `$rojo`, `$amarillo` y `$azul` en `estilos/tema.scss`.
**Cómo añadir objetos/imágenes:** guárdalos en `imagenes/` y úsalos así:

```markdown
![Pie de foto](../imagenes/archivo.png){width=70% fig-align="center"}

::: {.recorte}
![](../imagenes/titular-recortado.png)
:::
```

## Fase 2 — Escribir con la skill `/capitulo`

La skill vive en `.claude/skills/capitulo/SKILL.md`. Fija la estructura (las 6 secciones, sus IDs, la ficha y el cierre) y deja libre la forma interna.

Orden sugerido:
1. `/capitulo 14 pulir` → que sea el modelo definitivo.
2. `/capitulo 23 borrador`
3. `/capitulo 31 borrador`
4. `/capitulo 42 borrador`
5. `/capitulo epilogo borrador`

Después de cada uno: léelo, corrígelo con tu voz y vuelve a `/capitulo NN revisar`.

## Fase 3 — Fuentes

- [ ] Por cada capítulo del piloto: entre 3 y 6 fuentes reales en `references.bib`.
- [ ] Resolver cada `[VERIFICAR]`.

## Fase 4 — Construir el piloto

- Vista previa en vivo: `quarto preview`
- HTML: `quarto render --to html` → `_book/index.html`
- Para un piloto sin capítulos vacíos: comenta con `#` en `_quarto.yml` los capítulos que no entran.
- PDF: `quarto install tinytex` y luego `quarto render --to pdf`. El PDF necesita su propia portada en LaTeX (Fase 5).

## Fase 5 — Pulido para entregar

- [ ] Portada del PDF: página de título con la imagen del collage (plantilla LaTeX `before-body`).
- [ ] Publicar el HTML (Quarto Pub o GitHub Pages) para compartir el enlace.
- [ ] Lectura completa en voz alta: ritmo, repetición y si lo dadaísta suma o distrae.
- [ ] Cambiar `estado:` a `listo` en los capítulos del piloto.
