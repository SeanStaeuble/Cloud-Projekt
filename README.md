# Anleitung für Herrn Lux

## Repository klonen

__Hinweis: Git muss schon auf Client configuriert sein__

Um dieses Repository lokal zu klonen, gehe wie folgt vor:

1. Auf GitHub auf die Hauptseite des Repositorys navigieren.
2. Oben rechts auf den grünen **Code**-Button klicken.
3. Unter **HTTPS** die Repository-URL kopieren  
   (z. B. `https://github.com/<benutzer>/<repository>.git`).
4. Ein Terminal (Git Bash, PowerShell o. Ä.) öffnen.
5. In den Ordner wechseln, in dem das Projekt liegen soll, z. B.:
6. Den Befehl: Git clone "Kopierter Pfad zum Repo"

## Skript vorbereiten

Ins Verzeichnis mit .sh wechseln:

cd pfad/zum/skript


Zeilenenden fixen (Git Bash):

sed -i 's/\r$//' test.sh


Ausführbar machen:

chmod +x test.sh 
