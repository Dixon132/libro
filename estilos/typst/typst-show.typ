#show: libro.with(
$if(title)$
  title: [$title$],
$endif$
$if(subtitle)$
  subtitle: [$subtitle$],
$endif$
$if(by-author)$
  autor: "$for(by-author)$$it.name.literal$$sep$, $endfor$",
$endif$
$if(date)$
  fecha: [$date$],
$endif$
$if(description)$
  descripcion: [$description$],
$endif$
$if(lang)$
  lang: "$lang$",
$endif$
  portada: "portada/portada.svg",
)
