# Anleitung für Herrn Lux

## 1. Repository klonen

__Hinweis: Git muss schon auf Client konfiguriert sein!__

Um dieses Repository lokal zu klonen, gehe wie folgt vor:

1. Auf GitHub auf die Hauptseite des Repositorys navigieren.
2. Oben rechts auf den grünen **Code**-Button klicken.
3. Unter **HTTPS** die Repository-URL kopieren  
   (z. B. `https://github.com/<benutzer>/<repository>.git`).
4. Ein Terminal (Git Bash, PowerShell o. Ä.) öffnen.
5. In den Ordner wechseln, in dem das Projekt liegen soll, z. B.:
6. Den Befehl: Git clone "Kopierter Pfad zum Repo"

## 2. Skript vorbereiten

Ins Verzeichnis mit AWS_NextCloud_IaC.sh wechseln:

cd pfad/zum/skript


Zeilenenden fixen (Git Bash):

sed -i 's/\r$//' AWS_NextCloud_IaC.sh


Ausführbar machen:

chmod +x AWS_NextCloud_IaC.sh 

## 3. Skript ausführen

__Hinweis: aws muss auf Client konfiguriert sein!__

Jetzt muss das Skript in PowerShell mit folgendem Befehl ausgeführt werden:

./AWS_NextCloud_IaC.sh

## 4. Auf NextCloud verbinden

__Hinweis: Man sollte sich erst nach etwa 5-10min auf den Webserver verbinden, da dieser Zeit zum aufsetzen braucht!__

In der Skriptausgabe, wird eine IP des Webservers und des Datenbankservers ausgegeben sammt DB_Nutzer, DB_Name und DB_Passwort.

Mit http://"IP des Webservers"/ können sie auf die Webseite gelangen. Danach müssen sie bei der Datenbank MariaDB/MySQL wählen und dort die ausgegebenen Werte der Datenbank eintragen. Wichtig ist, dass sie beim abschnitt Home die IP des DB-Servers angegeben wird, sammt Port also z. B. "IP des DB-Servers:3306".

Jetzt müssen sie oben noch den gewünschten Namen und das Passwort für ihren neuen NextCloud-Administrator eintragen und dann noch beim Datenortner folgendes angeben: /var/www/html/nextcloud/data

Jetzt solten sie nur noch auf installieren klicken müssen, um NextCloud installieren zu können. Wenn NextCloud installiert ist, können sie sich dann noch mit dem Admin, welchen sie erstellt haben Anmelden.