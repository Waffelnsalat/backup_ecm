# Setze die Pfade für den Quell- und Zielordner
$quellordner = "C:\test"
$zielordner = "C:\test2"

# Erstelle den Zielordner, falls er noch nicht existiert
if (-not (Test-Path -Path $zielordner)) {
    New-Item -ItemType Directory -Force -Path $zielordner | Out-Null
}

# Unendliche Schleife
while ($true) {
    # Hole alle Dateien im Quellordner
    $dateien = Get-ChildItem -Path $quellordner

    # Durchlaufe jede Datei
    foreach ($datei in $dateien) {
        # Pfade zur Quell- und Zieldatei erstellen
        $quellpfad = Join-Path -Path $quellordner -ChildPath $datei.Name
        $zielpfad = Join-Path -Path $zielordner -ChildPath $datei.Name

        # Überprüfe, ob die Datei bereits im Zielordner existiert oder bearbeitet wurde
        if (-not (Test-Path -Path $zielpfad) -or ($datei.LastWriteTime -gt (Get-Item -Path $zielpfad).LastWriteTime)) {
            # Kopiere die Datei in den Zielordner
            Copy-Item -Path $quellpfad -Destination $zielpfad -Force
            Write-Host "Datei '$($datei.Name)' wurde kopiert."
        }
    }

    # Warte 5 Minuten
    Start-Sleep -Seconds (30)
}
