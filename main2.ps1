# Setze die Pfade für den Quell- und Zielordner
$quellordner = "C:\test"
$zielordner = "C:\test2"

# Erstelle den Zielordner, falls er noch nicht existiert
if (-not (Test-Path -Path $zielordner)) {
    New-Item -ItemType Directory -Force -Path $zielordner | Out-Null
}

# Unendliche Schleife
while ($true) {
    # Kopiere den Inhalt des Quellordners in den Zielordner
    Copy-Item -Path $quellordner\* -Destination $zielordner -Recurse -Force -ErrorAction SilentlyContinue

    # Warte 5 Minuten
    Start-Sleep -Seconds (30)
}
