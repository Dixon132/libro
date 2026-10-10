# Código Entrópico

*La evolución del desarrollo de software frente al ojo de la IA* — libro en Quarto.

## Requisitos

1. Quarto: `winget install --id Posit.Quarto` (o https://quarto.org/docs/get-started/)
2. Para PDF: `quarto install tinytex`
3. Recomendado: extensión **Quarto** de VS Code.

## Comandos

| Acción | Comando |
|---|---|
| Vista previa en vivo | `quarto preview` |
| Generar HTML | `quarto render --to html` |
| Generar PDF | `quarto render --to pdf` |
| Generar todo (HTML + PDF + EPUB) | `quarto render` |

La salida queda en `_book/`.

## Estructura

```
_quarto.yml          configuración y orden de capítulos
index.qmd            prefacio
ciclo-entropico.qmd  patrón de enseñanza
partes/              portadas de cada parte
capitulos/           47 capítulos (01-...qmd a 47-...qmd)
epilogo.qmd
referencias.qmd      bibliografía generada desde references.bib
estilos/             tema visual
```

## Flujo de trabajo

- Cada capítulo tiene en su encabezado `estado: pendiente | borrador | revision | listo`.
- El capítulo 14 es el **modelo** del Ciclo Entrópico; los demás siguen su estructura.
- Citas: agrega la fuente en `references.bib` y cítala con `[@clave]`.
- Para sacar un capítulo temporalmente, coméntalo en `_quarto.yml` con `#`.
- Ver avance: `grep -h "^estado:" capitulos/*.qmd | sort | uniq -c`
