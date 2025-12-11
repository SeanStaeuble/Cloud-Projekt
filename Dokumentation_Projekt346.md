# Dokumentation Cloudprojekt Modul 346
**by Sean, Noa und Stefan**  
_Klasse: INP1b
_Datum: 20.11.2025 - 17.12.2025

## Kurzbeschreibung
- Ziel des Projekts in 3–4 Sätzen
- Was wird gebaut? (Nextcloud auf AWS mit IaC)
- Wichtigste Anforderungen

## Inhaltsverzeichnis
- Ausgangslage
- Ziele
- Planung und Organisation
- Architektur
- Umsetzung IaC und Infrastruktur
- Umsetzung Nextcloud
- Tests
- Fazit & Reflexion
- Verzeichnisse
  - Quellenverzeichnis
  - Bildverzeichnis
  - Glossar

## Ausgangslage
Wir haben von unserem Lehrer, Herrn Oliver Lux, den Auftrag für ein Projekt erhalten. Dabei sollen wir einen Webserver auf AWS bereitstellen und darauf den Cloud-Dienst Nextcloud installieren und konfigurieren. Die gesamte Einrichtung wird mithilfe von Infrastructure as Code (IaC) umgesetzt und dokumentiert, sodass sie die Installation per IaC von Herrn Lux nachgestellt werden kann.

## Ziele
### Fachliche Ziele
Eines der relevantesten Ziele ist die Bereitstellung eines Cloud-basierten Services auf AWS, der funktionsfähig, erreichbar und stabil betrieben werden kann. Automatisierte Infrastrukturbereitstellung mittels Infrastructure as Code (IaC), sodass der Service jederzeit reproduzierbar in AWS erstellt werden kann. Unter anderem erstellen wir auch noch eine Versionskontrollierte Verwaltung aller Konfigurations- und Infrastrukturdateien in einem Git-Repository. Die Dokumentation des gesamten Projektes erfolgt in Markdown, inklusive Architektur, Implementierungsschritte und Konfigurationsdateien.

### Lern- und Projektziele
- Umgang mit AWS, Linux, IaC, Git
- …

## Planung und Organisation
### Projektorganisation
- Team, Rollenverteilung

| Aufgabe                   | Verantwortlich | Zeitraum    |
|---------------------------|----------------|------------|
| IaC Grundsetup            |                |            |
| Webserver-Konfiguration   |                |            |
| DB-Server & DB-Setup      |                |            |
| Nextcloud-Installation    |                |            |
| Tests                     |                |            |
| Dokumentation             |                |            |

### Zeitplanung
- kurze Beschreibung + optional Tabelle mit Meilensteinen

## Architektur
### Zielarchitektur
- Textbeschreibung der Architektur
- Hinweis auf Diagramm

_(Hier Bild einfügen, z.B. `![Architekturdiagramm](bilder/architektur.png)` )_

### Komponenten
- Webserver-VM (OS, Webserver-Software, IP)
- DB-Server-VM (DB-Typ, IP)
- Security Groups / Firewall

## Umsetzung IaC und Infrastruktur
### IaC-Konzept
- Welches Tool / welche Scripts
- Ordnerstruktur kurz beschreiben

### Webserver-Setup
- Wie wird die VM erstellt?
- Welche Pakete werden installiert?
- Wie wird der Webserver konfiguriert (ohne Unterpfad)?

### Datenbank-Setup
- Erstellung DB-Server
- DB-Installation und User für Nextcloud
- Nur interne Erreichbarkeit von Webserver aus

### Automatisierung / Scripts
- Wie startet man das Script?
- Welche Ausgaben in der Konsole (IP, DB-Daten)?

## Umsetzung Nextcloud
### Installation
- Download des Archivs
- Entpacken, Rechte, PHP-Module

### Erstaufruf / Installationsassistent
- Wie wird sichergestellt, dass beim Aufruf der IP der Assistent erscheint?
- Welche DB-Daten werden eingegeben?

## Tests
### Testkonzept
- Ziel der Tests
- Übersicht der Testfälle

### Testprotokolle

| Test-ID | Datum      | Testperson | Beschreibung                      | Erwartetes Ergebnis                         | Tatsächliches Ergebnis | Fazit / Massnahmen |
|--------:|------------|-----------|-----------------------------------|---------------------------------------------|------------------------|--------------------|
| T1      |            |           | Aufruf IP → Installationsassistent | Assistent wird ohne Fehler angezeigt        |                        |                    |
| T2      |            |           | Verbindung Nextcloud ↔ DB         | Verbindung erfolgreich                      |                        |                    |
| T3      |            |           | Ausführung IaC-Script             | Infrastruktur wird ohne Fehler erstellt     |                        |                    |

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
- IaC: …
- VM: …
- Security Group: …
- Nextcloud: …
- Repository: …
