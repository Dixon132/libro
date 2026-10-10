# Bitácora de avance — Código Entrópico

> Memoria entre sesiones. **Léela al empezar y actualízala al terminar cualquier trabajo en el libro.**
> Lo más reciente va arriba en "Registro". Mantén "Estado actual" siempre al día.

## Estado actual (2026-10-09)

- **Herramientas:** Quarto 1.10.19 instalado (`C:\Program Files\Quarto\bin\quarto.exe`). Si la terminal no lo encuentra, recargar PATH o abrir una terminal nueva. TinyTeX (para el PDF) **no** está instalado aún.
- **Canva:** no está conectado. La persona autora lo conectará más adelante para la portada y los carteles de cada parte.
- **Diseño:** tema brutalista/dadaísta en `estilos/tema.scss`, con portada provisional `portada/portada.svg`.
- **Piloto:** ver `PLAN-PILOTO.md`. Capítulos del piloto: 14, 23, 31 y 42, más el prefacio y el epílogo. La persona autora decidió **empezar por el capítulo 1**.

| Cap. | Estado | Nota |
|---|---|---|
| 01 Pensar antes de programar | borrador | Primer capítulo escrito con la voz del Inge. Nacen la metáfora del mercado y Caserita v0.1 |
| 14 Git | borrador | Modelo estructural original, falta desarrollar |
| resto | pendiente | Solo plantilla |

## Hilos que continúan (no romper la continuidad)

- **Metáfora global:** el **mercado**. Tabla maestra en el cap. 1 (@tbl-c01-metafora): puesto = programa, cuaderno = datos, pasillos = arquitectura, caseras que se pasan pedidos = API, sobrino Marco = equipo, inspector = pruebas y seguridad, ayudante que nunca duerme = IA, dueño de lo que sabe el mercado = soberanía de datos.
- **Personajes:** Doña Rosa (dueña del puesto de abarrotes, lleva 22 años en el mercado, cuaderno de tapas azules), Marco (su sobrino, ayuda en el puesto) y **el Inge** (personaje ficticio, ingeniero con 50 años de oficio; habla en las cajas `.pizarra`).
- **Proyecto guía: Caserita.**
  - v0.1 (cap. 1): `reponer_puesto(productos, es_fin_de_mes)`. Cada producto es un dict con `nombre, stock, minimo, lote, alta_rotacion`. Regla: `stock < minimo O (fin_de_mes Y alta_rotacion)`.
  - Reto abierto del cap. 1: el algoritmo `DecidirFiado`, que vende a crédito con límite de deuda y antigüedad. Se puede retomar en caps. 4, 9 y 45 (ética).
  - Próxima pieza (cap. 2): darle un lenguaje de verdad (Python) y convertir la lista en un programa que lee y escribe datos.
- **Pseudocódigo del libro:** `INICIO/FIN`, `LEER/MOSTRAR`, `←`, `SI…ENTONCES…SINO…FIN SI`, `PARA CADA…EN…HACER…FIN PARA`, `MIENTRAS…HACER…FIN MIENTRAS`. Los conectores lógicos se escriben `Y`, `O`, `NO`.

## Lecciones técnicas (no repetir errores)

- **No pongas diagramas `mermaid` dentro de `.panel-tabset`**: al cambiar de pestaña aparece "Syntax error". Pon el diagrama fuera y deja en las pestañas solo código o texto.
- En las etiquetas de mermaid, no empieces con "1. ", porque se interpreta como lista. Usa "Paso 1: …".
- No numeres a mano los `###` (Quarto ya los numera).
- Vista previa: en el panel del navegador, `preview_start` con el nombre `libro` (definido en `.claude/launch.json`, puerto 4848).

## Pendientes abiertos

- [ ] Confirmar el autor o los autores en `_quarto.yml`.
- [ ] Portada definitiva y carteles de parte (Canva, cuando esté conectado).
- [ ] Instalar TinyTeX para generar el PDF.

## Decisiones de la persona autora

- **2026-10-09 — Fuera el Tilcayo de todo el libro.** El foco es la idea central de *Código Entrópico* y su estructura (el Ciclo Entrópico, el mercado, Caserita). No lo vuelvas a proponer. El epílogo ahora es "El orden no se hereda, se trabaja" y cierra el ciclo del libro entero.

## Registro

- **2026-10-09** — Se quitó el Tilcayo del epílogo, del cap. 39, de `references.bib` y del plan. El epílogo se replanteó como cierre del Ciclo Entrópico.

- **2026-10-09** — Quarto instalado. Escrito el borrador del cap. 1 (voz del Inge, metáfora del mercado, Caserita v0.1, recursos visuales: tabsets, mermaid, anotaciones de código, `.pizarra`). Agregadas las referencias `wing2006`, `polya1945` y `brooks1987`. Agregada la clase `.pizarra` al tema.
- **2026-10-09** — Creados la skill `/capitulo`, el tema brutalista/dadaísta, la portada SVG provisional y `PLAN-PILOTO.md`.
