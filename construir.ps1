# construir.ps1 — genera el libro completo: web + PDF impreso + ePub
# Uso:   .\construir.ps1            (todo)
#        .\construir.ps1 -Solo pdf  (solo el PDF; la web queda como estaba)
param([ValidateSet("todo", "pdf", "web")] [string]$Solo = "todo")

$env:Path = [Environment]::GetEnvironmentVariable('Path', 'Machine') + ';' + [Environment]::GetEnvironmentVariable('Path', 'User')

# Una vista previa abierta bloquea archivos: se cierra antes de generar
Get-CimInstance Win32_Process -Filter "Name='quarto.exe' or Name='deno.exe'" |
  Where-Object { $_.CommandLine -match 'preview' } |
  ForEach-Object { Stop-Process -Id $_.ProcessId -Force }

switch ($Solo) {
  "todo" { quarto render }
  "web"  { quarto render --to html }
  "pdf"  {
    # Quarto limpia _book al generar un solo formato: se guarda la web y se restaura
    $tmp = Join-Path $env:TEMP "libro-web"
    if (Test-Path _book) { Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue; Copy-Item _book $tmp -Recurse }
    quarto render --to typst
    if (Test-Path $tmp) { Copy-Item "$tmp\*" _book -Recurse -Force -Exclude "codigo-entropico.pdf"; Remove-Item $tmp -Recurse -Force }
  }
}

Write-Host ""
Write-Host "Listo. PDF: _book\codigo-entropico.pdf" -ForegroundColor Green
Write-Host "Para verlo: quarto preview --no-render  ->  http://localhost:4848/hojear.html" -ForegroundColor Yellow
