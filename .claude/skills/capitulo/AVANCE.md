# Bitácora de avance — Código Entrópico

> Memoria entre sesiones. **Léela al empezar y actualízala al terminar cualquier trabajo en el libro.**
> Lo más reciente va arriba en "Registro". Mantén "Estado actual" siempre al día.

## Estado actual (2026-10-10)

- **Herramientas:** Quarto 1.10.19 (`C:\Program Files\Quarto\bin\quarto.exe`), con Typst incluido para el PDF. **No hace falta TinyTeX.**
- **Construir:** `.\construir.ps1` genera web + PDF + ePub en `_book/`. Con `-Solo pdf` genera solo el PDF y conserva la web.
- **Ver:** `preview_start` con el nombre `libro` (vista previa sin renderizar, puerto 4848). El PDF se hojea en `http://localhost:4848/hojear.html`.
- **Formato impreso:** libro de 17 × 24 cm, con margen de lomo de 2,3 cm. Lleva portada, portadilla, créditos, índice propio, páginas negras para las partes, apertura de capítulo con número gigante, cabeceras con parte y capítulo, números de página en caja negra y figuras, tablas y códigos numerados por capítulo (1.1, 1.2…). Las citas van en estilo APA.
- **Canva:** no está conectado. Se conectará más adelante para la portada y los carteles de cada parte.
- **Piloto:** ver `PLAN-PILOTO.md`. Se empezó por el capítulo 1.

| Cap. | Estado | Acento | Nota |
|---|---|---|---|
| Introducción | esqueleto | amarillo | "¿Para qué aprender a programar si la IA ya programa?" Plan dentro del archivo |
| 01 Pensar antes de programar | borrador ampliado | rojo | 6 ilustraciones, 8 figuras, ~20 tablas, Código 1.1. Modelo visual para los demás |
| 14 Git | borrador | — | Modelo estructural original, falta desarrollar |
| resto | pendiente | — | Solo plantilla |

## Hilos que continúan (no romper la continuidad)

- **Metáfora global:** el **mercado**. Tabla maestra en el cap. 1 (@tbl-c01-metafora): puesto = programa, cuaderno = datos, pasillos = arquitectura, caseras que se pasan pedidos = API, sobrino Marco = equipo, inspector = pruebas y seguridad, ayudante que nunca duerme = IA, dueño de lo que sabe el mercado = soberanía de datos.
- **Personajes:** Doña Rosa (puesto 47 de abarrotes, 22 años en el mercado, cuaderno de tapas azules), Marco (su sobrino; el error de "lo de siempre": 50 kg de sal y nada de aceite) y **el Inge** (ficticio, 50 años de oficio, casco rojo, lentes redondos, tarjeta perforada; habla en las `.pizarra`).
- **Ilustraciones del cap. 1** (`imagenes/cap01/`): apertura, puesto, inge, marco, cuatro-movimientos y fiado. Reutiliza los mismos rasgos de los personajes en los capítulos siguientes.
- **Proyecto guía: Caserita.** La hoja de ruta (@tbl-c01-caserita) es: 0.1 (cap. 1) → 0.2 (cap. 2, Python) → 0.3 (cap. 3, estructuras) → 0.5 (cap. 9, base de datos) → 0.7 (cap. 12, API) → 1.0 (cap. 19, producción) → 2.0 (Partes II y III, asistente con IA).
  - v0.1: `reponer_puesto(productos, es_fin_de_mes)`. Cada producto es un dict con `nombre, stock, minimo, lote, alta_rotacion`. Regla: `stock < minimo O (fin_de_mes Y alta_rotacion)`.
  - Reto abierto: `DecidirFiado` (crédito con límite de deuda y antigüedad). Se puede retomar en los caps. 4, 9 y 45.
- **Ideas que ya se enseñaron en el cap. 1** (no repetirlas, solo citarlas): los cinco rasgos de Knuth, las tres puertas de la ambigüedad, la entropía H = log₂ N (64 pedidos = 6 bits), Pólya y la prueba de escritorio.
- **Pseudocódigo del libro:** `INICIO/FIN`, `LEER/MOSTRAR`, `←`, `SI…ENTONCES…SINO…FIN SI`, `PARA CADA…EN…HACER…FIN PARA`, `MIENTRAS…HACER…FIN MIENTRAS`. Los conectores lógicos se escriben `Y`, `O`, `NO`.

## Arquitectura del libro (dónde vive cada cosa)

| Qué | Archivo |
|---|---|
| Estilo web | `estilos/tema.scss` |
| Estilo impreso | `estilos/typst/typst-template.typ` (paleta, fuentes, página, aperturas, cajas) |
| Traductor web ↔ papel | `estilos/filtros/libro.lua` (las clases `.pizarra`, `.figura-*`, `.estilo-capitulo`… y las pestañas) |
| Tamaño de los diagramas en papel | `estilos/filtros/libro-post.lua` |
| Visor para hojear | `hojear.html` (usa pdf.js y page-flip desde un CDN) |

## Lecciones técnicas (no repetir errores)

- No pongas diagramas `mermaid` dentro de `.panel-tabset`.
- En las etiquetas de mermaid, no empieces con "1. ". Usa "Paso 1: …".
- No numeres a mano los `###`.
- No uses `<br>` ni otro HTML crudo en el texto: en papel desaparece. Para saltar de línea usa `\` al final.
- `quarto render --to typst` **borra** la web de `_book/`. Usa siempre `.\construir.ps1`.
- La vista previa bloquea archivos: `construir.ps1` la cierra antes de generar. Después hay que volver a abrirla.
- En `figura-izq`, `figura-der` y `figura-pie`, la imagen tiene que ser el **primer** bloque del div.
- Lo que solo aparece en HTML crudo (por ejemplo, la imagen de apertura) no lo copia Quarto. Por eso `imagenes/**` está en `resources`.

## Pendientes abiertos

- [ ] Confirmar el autor o los autores en `_quarto.yml`.
- [ ] Portada definitiva (PNG de 1700 × 2400, proporción 17:24) y carteles de parte (Canva, cuando esté conectado).
- [ ] Escribir la introducción (el plan está dentro de `introduccion.qmd`).
- [ ] Opcional: incrustar las fuentes de la web (Archivo Black, IBM Plex, Space Mono) también en el PDF, para que web y papel sean idénticos. Hoy el PDF usa Arial Black, Georgia y Cascadia Mono.
- [ ] Decidir si el PDF para imprenta lleva sangrado (*bleed*) de 3 mm. Hoy no lo lleva.

## Decisiones de la persona autora

- **2026-10-09 — Fuera el Tilcayo de todo el libro.** No lo vuelvas a proponer. El epílogo es "El orden no se hereda, se trabaja".
- **2026-10-10** — Libro listo para imprimir, con vista para hojearlo. Cada capítulo con estilo propio dentro del sistema. Imágenes en el texto (al costado y al pie), no solo cajas. Bloques numerados solo cuando se citan. Voz de profesor-ingeniero con 50 años de experiencia.

## Registro

- **2026-10-10** — Versión impresa (Typst, 17 × 24 cm) con plantilla propia, filtros Lua, visor `hojear.html` y `construir.ps1`. Cap. 1 reescrito y ampliado: Knuth, tres puertas de la ambigüedad, entropía medida en bits, cuatro pasadas del pseudocódigo, errores típicos, ejercicios por niveles, glosario, 6 ilustraciones SVG, apertura con imagen y Código 1.1. Creado `introduccion.qmd` (esqueleto). Referencia `knuth1997`. Citas en APA en el PDF.
- **2026-10-09** — Se quitó el Tilcayo; el epílogo se replanteó como cierre del Ciclo Entrópico.
- **2026-10-09** — Quarto instalado. Primer borrador del cap. 1.
- **2026-10-09** — Creados la skill `/capitulo`, el tema brutalista/dadaísta, la portada SVG provisional y `PLAN-PILOTO.md`.
