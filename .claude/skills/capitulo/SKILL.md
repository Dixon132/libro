---
name: capitulo
description: Redactar, continuar o revisar capítulos del libro "Código Entrópico" sin perder la estructura del libro (Ciclo Entrópico, partes, estilo brutalista-dadaísta) pero con libertad creativa en cada capítulo. Usar cuando el usuario pida escribir, desarrollar, expandir, revisar o pulir un capítulo, el prefacio, el epílogo o una portada de parte.
argument-hint: "<número o nombre del capítulo> [qué hacer: borrador | expandir | revisar | pulir]"
---

# Skill: redactar un capítulo de *Código Entrópico*

Tu trabajo es escribir **con libertad** dentro de una **columna vertebral fija**.
Piensa en el capítulo como un edificio brutalista: el hormigón (estructura) no se negocia;
lo que se cuelga en las paredes (tono, ejemplos, collage, ritmo) es libre y debe sorprender.

## 0. Antes de escribir (siempre)

0. **Lee `.claude/skills/capitulo/AVANCE.md`**: ahí está el estado del libro, los personajes, la metáfora
   y la versión actual de Caserita. Es la memoria entre sesiones. Nunca contradigas lo que dice sin avisar.
1. Lee `_quarto.yml` para ubicar el capítulo, su parte y sus vecinos.
2. Lee `ciclo-entropico.qmd` (la regla) y `capitulos/14-git-y-trabajo-en-equipo.qmd` (el modelo).
3. Lee el capítulo anterior y el siguiente (aunque sea su ficha) para no repetir y para enlazar.
4. Lee el archivo del capítulo pedido completo. Respeta lo que ya escribió la persona autora:
   amplía, no reemplaces, salvo que lo pida.
5. Si falta información clave (objetivo, caso real, proyecto guía), propón una opción concreta
   y sigue; no bloquees la escritura con preguntas.

## 1. Lo que NO se negocia (invariantes)

Todo capítulo en `capitulos/NN-*.qmd` mantiene, en este orden:

| # | Elemento | Forma exacta |
|---|---|---|
| a | Encabezado YAML | `title:` y `estado:` (`pendiente`, `borrador`, `revision`, `listo`) |
| b | Ficha | callout `note` colapsado con **Objetivo**, **Prerrequisitos**, **Proyecto guía** |
| c | `## Orden {#sec-cNN-orden}` | el sistema en equilibrio; problema real |
| d | `## Entropía {#sec-cNN-entropia}` | qué lo degrada (tiempo, equipo, escala) |
| e | `## Análisis {#sec-cNN-analisis}` | el contenido de fondo |
| f | `## Contención {#sec-cNN-contencion}` | prácticas + **un** callout `important` "Reto" |
| g | `## Ojo de la IA {#sec-cNN-ia}` | callout `tip icon="false"` "Ojo de la IA" |
| h | `## Custodia {#sec-cNN-custodia}` | callout `warning icon="false"` "Custodia" |
| i | `## Para cerrar` | Ideas clave (3–5), Preguntas de repaso (3), Para profundizar (con `[@clave]`) |

Reglas duras:
- Los seis `##` del ciclo existen siempre, con esos nombres e IDs (las referencias cruzadas dependen de ellos).
- Idioma: español neutro con voz boliviana cuando el ejemplo lo pida. Segunda persona ("tú") en instrucciones.
- Toda afirmación factual o cifra lleva cita `[@clave]` y la entrada va en `references.bib`.
  Si no puedes verificar una fuente, escribe `[VERIFICAR: ...]` en el texto; nunca inventes datos, autores, DOIs ni cifras.
- Código: bloques con lenguaje (` ```python `, ` ```bash `…), que funcionen y sean cortos.
- Al terminar, actualiza `estado:` (normalmente `pendiente → borrador`).

## 2. Cómo cambia el peso según la parte

| Parte | Capítulos | Centro de gravedad |
|---|---|---|
| I — El orden | 01–20 | Análisis técnico largo. *Ojo de la IA* = ventana breve (1–3 párrafos). |
| II — La perturbación | 21–28 | *Ojo de la IA* es el núcleo. *Custodia* responde **cuándo no delegar**. |
| III — La señal | 29–38 | La IA es el componente. *Análisis* mide costos, latencia, límites con números. |
| IV — El equilibrio | 39–47 | Orden y entropía son **sociales**. Datos de Bolivia/región. *Ojo de la IA*: qué ve y qué ignora el modelo. |

## 3. Lo que SÍ es libre (y se espera)

Dentro de cada sección puedes (y conviene) variar. No hagas dos capítulos con el mismo ritmo.

- **Entrada:** una escena, un error real, un diálogo, una cita, un fragmento de log, una carta, un manifiesto.
- **Subsecciones `###`** con títulos propios, provocadores si sirven.
- **Formas raras:** tablas comparativas, diagramas `mermaid`, listas numeradas absurdas, poemas de código,
  "instrucciones para destruir este sistema", un falso changelog, una entrevista imaginaria con el compilador.
- **Longitud desigual** entre secciones según el tema. Una sección puede ser una sola línea contundente.
- **Recursos visuales del libro** (definidos en `estilos/`), úsalos con intención, no como decoración:

```markdown
::: {.grito}
EL CÓDIGO SE PUDRE.
:::

::: {.recorte}
Fragmento pegado como recorte de periódico: una cita, un dato, un titular.
:::

::: {.manifiesto}
1. Ningún commit sin explicación.
2. ...
:::

[palabra tachada]{.tachado} [palabra subrayada a mano]{.marcador}

::: {.ruido}
texto        desordenado    a propósito
:::
```

Máximo sugerido por capítulo: 1 `.grito`, 2 `.recorte`, 1 `.manifiesto`. Lo dadaísta funciona por contraste:
si todo grita, nada grita.

## 3b. La voz del profesor

Escribe como **un profesor e ingeniero con 50 años de experiencia, experto en enseñar y en ser comprendido en español**:

- Explica de lo concreto a lo abstracto: primero la escena del mercado, luego el concepto y luego la definición formal.
- Habla de tú, con calidez y sin condescendencia. Usa "fíjate", "mira" y "esto es importante" para guiar la atención.
- Cada concepto nuevo pasa por **tres formas**: palabra (definición), imagen (tabla o diagrama) y acción (código o ejercicio).
- Anticipa el error típico de quien aprende y desármalo antes de que ocurra.
- El personaje **el Inge** habla en cajas `::: {.pizarra}` que empiezan con `**Pizarra del Inge**`: definiciones memorables, trucos del oficio, el resumen final. Es un personaje ficticio, así que **no inventes anécdotas como si fueran de la persona autora**.

## 3c. Material visual obligatorio por capítulo

Mínimos para que el capítulo sea "bien visual":

- 2 o más diagramas `mermaid` (flujo, secuencia, estados o mapa del concepto).
- 3 o más tablas (comparación, tabla de verdad, prueba de escritorio, casos borde…).
- 1 o más `::: {.panel-tabset}` mostrando lo mismo en varias formas (pseudocódigo / diagrama / código, o antes / después).
- Código anotado: líneas con `# <1>` seguidas de una lista numerada explicando cada marca.
- 2 o más `.pizarra` del Inge (una de ellas es el cierre).
- La escena del **mercado** y el avance de **Caserita** (en Partes I a III; en la Parte IV, el mercado como sociedad).

En la Parte IV el código puede bajar, pero no los diagramas ni las tablas de datos.

## 3d. Identidad visual propia de cada capítulo

Cada capítulo tiene **su propio estilo dentro del sistema**. Justo debajo del YAML va:

```markdown
::: {.estilo-capitulo acento="rojo" motivo="rayas" imagen="../imagenes/capNN/apertura.svg"}
:::
```

- `acento`: `rojo`, `azul`, `amarillo`, `verde`, `naranja`, `violeta` o `tinta`. Pinta el número gigante de la apertura, los números de sección, el grito, el manifiesto y los pies de figura.
  Sugerencia: no repitas el acento de los capítulos vecinos.
- `motivo` (se usa si no hay imagen): `rayas`, `puntos`, `cuadricula` o `ruido`.
- `imagen`: banda de apertura de 1600 × 650 px (SVG o PNG) en `imagenes/capNN/`.

## 3e. Imágenes dentro del texto (no solo cajas en medio)

Las ilustraciones van en `imagenes/capNN/`, en estilo collage brutalista: paleta del libro, contornos negros gruesos, sombra sólida desplazada, etiquetas mecanografiadas. Puedes dibujarlas en SVG.
**La imagen va siempre primero dentro del div**, y siempre con etiqueta `#fig-cNN-...` para que se numere:

```markdown
::: {.figura-der ancho="44%"}
![Pie de figura.](../imagenes/cap01/puesto.svg){#fig-c01-puesto}

Párrafos que quedan AL LADO de la imagen (la imagen "repele" el texto).
:::

::: {.figura-izq ancho="36%"}       (igual, con la imagen a la izquierda)

::: {.figura-pie lado="izq" ancho="62%"}
![Pie.](../imagenes/cap01/marco.svg){#fig-c01-marco}
:::                                   (en papel: anclada ABAJO de la hoja, debajo del texto)
```

Imagen a todo el ancho: `![Pie.](ruta){#fig-cNN-x}` sin div. Mínimo por capítulo: 1 imagen de apertura y 3 ilustraciones, con al menos una `figura-izq` o `figura-der` y una `figura-pie`.

## 3f. Referencias numeradas: solo si se citan

Numera un bloque con etiqueta **solo si el texto lo menciona** (por ejemplo, "como en el @lst-c01-reponer"). Si nadie lo menciona, no lleva número.

- Código: ```` ```{#lst-cNN-nombre .python lst-cap="Qué hace"} ```` y en el texto `@lst-cNN-nombre`, que se lee "Código 1.1".
- Figuras `#fig-cNN-…` ("Figura 1.2"), tablas `{#tbl-cNN-…}` ("Tabla 1.3") y secciones `@sec-cNN-…`.
- Los diagramas mermaid se numeran con `%%| label: fig-cNN-…` y `%%| fig-cap: "…"`.
- Las etiquetas se escriben siempre con el prefijo del capítulo (`c01`, `c14`…) para que no choquen.

## 3g. Reglas para que funcione en web Y en papel

- Nada de HTML crudo (`<br>`, `<span>`): para saltar de línea usa `\` al final de la línea.
- No pongas mermaid dentro de `.panel-tabset`; las pestañas en papel se imprimen una tras otra con su etiqueta.
- Las etiquetas de mermaid no deben empezar con "1. " (se leen como lista); usa "Paso 1: …".
- Prefiere los diagramas verticales (`flowchart TB`/`TD`) o los horizontales con pocos nodos: en papel el ancho es de 12,8 cm.
- No numeres los títulos a mano.

## 4. Tono: brutalista + dadaísta

- **Brutalista:** frases cortas, honestidad estructural, se muestran las costuras (el código, el log, el error real).
  Nada de relleno ni "en el mundo actual…".
- **Dadaísta:** ruptura, ironía, collage, el absurdo como forma de decir algo serio. Un giro inesperado por sección como mucho.
- Pero siempre **enseña**: quien termine el capítulo debe poder hacer lo que dice el Objetivo.

## 5. Modos de trabajo (según el argumento)

- `borrador`: escribe todas las secciones con contenido real (no "_Por escribir_"). Prioriza Orden, Entropía y Análisis.
- `expandir`: profundiza la sección indicada o la más débil; agrega ejemplos, código y citas.
- `revisar`: no reescribas; entrega lista de problemas (estructura, hechos sin cita, repetición con otros capítulos,
  tono plano) y aplica solo lo que la persona apruebe.
- `pulir`: ritmo, cortes, transiciones, un recurso visual bien puesto; luego `estado: revision`.

## 6. Checklist final (verifícalo antes de responder)

- [ ] YAML con `title` y `estado` actualizado
- [ ] Ficha completa (sin `_(...)_` vacíos)
- [ ] Seis secciones del ciclo con sus IDs exactos, en orden
- [ ] Un Reto concreto y evaluable
- [ ] Callouts Ojo de la IA y Custodia presentes
- [ ] Peso correcto según la parte
- [ ] Citas en `references.bib`; dudas marcadas `[VERIFICAR]`
- [ ] Al menos un momento formalmente libre/sorpresivo
- [ ] `estilo-capitulo` con un acento distinto al de los capítulos vecinos
- [ ] Apertura y 3 o más ilustraciones con `#fig-`; al menos una al costado y una al pie
- [ ] Bloques numerados solo si se citan en el texto
- [ ] `.\construir.ps1` termina sin errores, y el capítulo se revisó en `hojear.html` (papel) y en la web

## 7. Al terminar: actualizar la bitácora (obligatorio)

Edita `.claude/skills/capitulo/AVANCE.md`:
- Tabla de estado del capítulo.
- "Hilos que continúan": personajes nuevos, la versión de Caserita y los retos abiertos que otros capítulos deban retomar.
- Una línea fechada en "Registro" (lo más reciente arriba).
- Pendientes nuevos (fuentes `[VERIFICAR]`, decisiones que tiene que tomar la persona autora).

Responde al usuario con: qué hiciste, qué quedó `[VERIFICAR]` y qué sugieres para la próxima pasada.
