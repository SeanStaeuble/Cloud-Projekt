# Dokumentation Cloudprojekt Modul 346
**by Sean, Noa und Stefan**  
Klasse: INP1b

Datum: 20.11.2025 - 17.12.2025

## Kurzbeschreibung
>[!NOTE]
>
> Herr Lux hat uns die **Ausgangslage** für das Nextcloud-Projekt gegeben: automatisierte Bereitstellung auf AWS mittels Infrastructure as Code (IaC), vollständig reproduzierbar.
>Vollständige Ziele und auch wichtigee Annforderungen werden später in der Dokumentation noch aufgeziegt.

## Inhaltsverzeichnis
- [Dokumentation Cloudprojekt Modul 346](#dokumentation-cloudprojekt-modul-346)
  - [Kurzbeschreibung](#kurzbeschreibung)
  - [Inhaltsverzeichnis](#inhaltsverzeichnis)
  - [Ausgangslage](#ausgangslage)
  - [Ziele](#ziele)
    - [Lern- und Projektziele](#lern--und-projektziele)
  - [Planung und Organisation](#planung-und-organisation)
    - [Projektorganisation](#projektorganisation)
    - [Zeitplanung](#zeitplanung)
  - [Architektur](#architektur)
    - [Zielarchitektur](#zielarchitektur)
    - [Komponenten](#komponenten)
  - [Umsetzung IaC und Infrastruktur](#umsetzung-iac-und-infrastruktur)
    - [IaC-Konzept](#iac-konzept)
    - [Ordnerstruktur](#ordnerstruktur)
    - [Webserver-Setup](#webserver-setup)
    - [Datenbank-Setup](#datenbank-setup)
    - [Automatisierung / Scripts](#automatisierung--scripts)
  - [Umsetzung Nextcloud](#umsetzung-nextcloud)
    - [Installation](#installation)
    - [Erstaufruf / Installationsassistent](#erstaufruf--installationsassistent)
  - [Tests](#tests)
    - [Testkonzept](#testkonzept)
    - [Testprotokolle](#testprotokolle)
  - [Fazit \& Reflexion](#fazit--reflexion)
    - [Projektfazit (Gruppe)](#projektfazit-gruppe)
    - [Persönliche Reflexion Sean](#persönliche-reflexion-sean)
    - [Persönliche Reflexion Noa](#persönliche-reflexion-noa)
    - [Persönliche Reflexion Stefan](#persönliche-reflexion-stefan)
  - [Verzeichnisse](#verzeichnisse)
    - [Quellenverzeichnis](#quellenverzeichnis)
    - [Bildverzeichnis](#bildverzeichnis)
    - [Glossar](#glossar)


## Ausgangslage
Wir haben von unserem Lehrer, Herrn Oliver Lux, den Auftrag für ein Projekt erhalten. Dabei sollen wir einen Webserver auf AWS bereitstellen und darauf den Cloud-Dienst Nextcloud installieren und konfigurieren. Die gesamte Einrichtung wird mithilfe von Infrastructure as Code (IaC) umgesetzt und dokumentiert, sodass sie die Installation per IaC von Herrn Lux nachgestellt werden kann. Die Dokumentation erfolgt in Markdown und wird per Git bereitgestellt, sodass jedes Teammitglied unabhängig den Anderen Arbeiten kann.

## Ziele
Eines der relevantesten Ziele ist die Bereitstellung eines Cloud-basierten Services auf AWS, der funktionsfähig, erreichbar und stabil betrieben werden kann. Automatisierte Infrastrukturbereitstellung mittels Infrastructure as Code (IaC), sodass der Service jederzeit reproduzierbar in AWS erstellt werden kann. Unter anderem erstellen wir auch noch eine Versionskontrollierte Verwaltung aller Konfigurations- und Infrastrukturdateien in einem Git-Repository. Die Dokumentation des gesamten Projektes erfolgt in Markdown, inklusive Architektur, Implementierungsschritte und Konfigurationsdateien.

### Lern- und Projektziele
-	Umgang mit AWS, Linux-Servern, Webserver, DB, Nextcloud.
-	Professionelle Nutzung von Git (Commits, Branches, Zusammenarbeit).
- Erstellen einer verständlichen, prägnanten Doku mit Markdown inkl. Bildern/Diagrammen.

## Planung und Organisation
### Projektorganisation
- **Noa Imfeld** = Dokumentator
- **Stefan Kaufln** = Dokumentator
- **Sean Stäuble** = Hauptzusändiger für Skripts

> [!IMPORTANT]
> 
> Dies ist nur die Verteilung der Hauptaufgaben der Projektmitglieder. Wichtig zu wissen ist, dass Noa und Stefan auch an den Skripts gearbeitet haben. Unter anderem hat Sean auch an der Dokumentation gearbeitet.

### Zeitplanung

| Aufgabe                   | Verantwortlich | geplanter Zeitraum | gebrauchter Zeitraum |
|---------------------------|----------------|--------------------|----------------------|
| IaC Grundsetup            |      Sean      |         2h         |          3h          |
| Webserver-Konfiguration   | Sean & Stefan  |         2h         |         2.5h         |
| DB-Server & DB-Setup      |   Noa & Sean   |        1.5h        |         2.5h         |
| Nextcloud-Installation    |      Sean      |        1.5h        |          4h          |
| Tests                     |      Alle      |         1h         |                      |
| Dokumentation             |  Stefan & Noa  |         4h         |          8h          |
| README                    |      Sean      |         1h         |                      |

## Architektur
### Zielarchitektur
Eine Drittperson soll von ihrem Gerät aus über den Browser durchs Internet auf unsere AWS Cloud kommen. Diese ist in einem eigenen Subnetz. In diesem Subnetz sind die EC2 Instanzen also Webserver & Datenbank.
- Hinweis auf Diagramm

_(Hier Bild einfügen, z.B. `![Architekturdiagramm](bilder/architektur.png)` )_

### Komponenten
- Webserver (Ubuntu, Nextcloud, 72.44.61.93)
- DB-Server (MySQL-DB, dynamische IP)

## Umsetzung IaC und Infrastruktur
### IaC-Konzept
- Visual Studio Code, schreiben der Skripts
- PuTTY, Connection testen
 
### Webserver-Setup
- Wie wird die VM erstellt? (Sean)
- Beim Setup des Webservers wird Apache2, php und MariaDB mitinstalliert. 

### Datenbank-Setup
Zuerst wird die DB durch einen Bash-Skript initialisiert. Im Bash-Skript wird der MariaDB-Server auf die Ubuntu Instanz installiert dannach wird ein Admin Benutzer erstellt. Dieses Admin Konto hat ausserdem Vollrechte und dieser kann dann die angegebenen Daten einsehen.

## Nextcloud
Nachdem der DB-Server initialisiert wurde, wird nun noch ein Bash-Skript ausgeführt, in welchem als ertes Apache2 und dann php auf die Ubuntu-Instanz installiert wird. 

### Erstaufruf / Installationsassistent
- Wie wird sichergestellt, dass beim Aufruf der IP der Assistent erscheint?
- Welche DB-Daten werden eingegeben?

## Tests
### Testkonzept
- Ziel der Tests
- Übersicht der Testfälle

### Testprotokolle

| Test-ID | Datum      | Testperson | Beschreibung                      | Erwartetes Ergebnis                         | Tatsächliches Ergebnis | Fazit / Massnahmen |
|--------:|------------|-----------|------------------------------------|---------------------------------------------|------------------------|--------------------|
| T1      |            |           | Aufruf IP                          | Man kommt von Drittgerät auf Webserver      |                        |                    |
| T2      |            |           | Verbindung Nextcloud ↔ DB          | Verbindung erfolgreich                      |                        |                    |
| T3      |            |           | Ausführung IaC-Script              | Infrastruktur wird ohne Fehler erstellt     |                        |                    |

_(Screenshots im Text referenzieren, z.B. `siehe Abbildung 1`.)_

## Fazit & Reflexion
### Projektfazit (Gruppe)
- Wurden alle Anforderungen erfüllt?
- Was hat gut funktioniert?
- Was könnte verbessert werden?

### Persönliche Reflexion Sean
- Learnings
- Schwierigkeiten
- Verbesserungsansätze

### Persönliche Reflexion Noa
- …

### Persönliche Reflexion Stefan
- …

## Verzeichnisse

### Quellenverzeichnis
- [1] Titel – URL – Abrufdatum
- …

### Bildverzeichnis
- Abb. 1: Architekturdiagramm – Seite X
- Abb. 2: Installationsassistent – Seite X
- …

### Glossar
- IaC: IT-Systeme werden nicht von Hand eingerichtet, sondern automatisch mit Code erstellt und verwaltet.
- VM: Ein „virtueller Computer“, der auf einem echten Computer läuft und sich wie ein eigener PC verhält.
- Nextcloud: Eine private Cloud, in der man Dateien, Fotos und Kalender selbst speichern und teilen kann.
- Repository: Ein Online-Ablageort für Code, in dem Dateien gespeichert, geändert und gemeinsam genutzt werden.
