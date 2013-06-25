---
layout: post
author: Uli Heller
published: true
title: "Ubuntu auf einem Macbook Air 2013"
date: 2013-06-24 05:00
updated: 2013-06-25 06:00
comments: true
categories: 
- Linux
- Ubuntu
- Precise
- Macbook Air 2013
---

Bedingt durch die Probleme mit meinem Samsung-Notebook habe ich
mir nun ein Macbook Air 2013 11 Zoll gegönnt. Erste Eindrücke habe
ich mit Live-CDs und Ad-Hoc-Installationen gesammelt. Hier nun
mein Weg zu einem "richtig" funktionierenden System.

<!-- more -->

## Erstellung eines Installationsmediums

Einfach das Mac-Iso von "Ubuntu-12.04.2, 64bit für Mac"
auf einen USB-Stick schreiben mittels @dd@.

## Anschließen der Test-Platte

Für die Installationstests habe ich eine externe USB-Festplatte
angeschlossen. Es handelt sich dabei um eine etwas ältere SSD in
einem USB3-Festplattengehäuse.

## Starten der Installation

Den Stick an's Macbook anschließen und beim Neustart die "Alt"-Taste
gedrückt halten. Es erscheint eine Auswahl, bei der ich den Punkt
"Windows" mit dem stilisierten USB-Medium angewählt habe. Danach startet
das Installationsmedium wie gewohnt.

## Durchführen der Installation

Die Installation läuft problemlos durch. Ich habe einfach darauf geachtet,
dass

* die Installation die externe Platte als Ziel hat
* der Boot-Block von GRUB in den MasterBootRecord der externen Platte
  geschrieben wird

## Durchführen der Aktualisierung

Zur Durchführung der Aktualisierung benötigt man eine Verbindung in's
Internet. Zunächst habe ich mit USB-WLAN-Karten rumgespielt:

* TP-Link TL-WN275N ... hat auch nach längeren Experimenten nicht funktioniert
* ISY ... hat sofort funktioniert, aber nach ein paar Minuten dann den
  Geist aufgegeben - jetzt funktioniert er auch an anderen Rechnern nicht mehr

Dann bin ich auf einen USB-2-Ethernet-Adapter ausgewichen. Damit klappt's
ohne Probleme.

## Inbetriebnahme des WLAN-Adapters

Mein Hauptproblem mit dem Macbook Air 2013 war der WLAN-Adapter.
Die Standard-Varianten wie "Zusätzliche Treiber laden" haben bei
mir nicht funktioniert.

### Herunterladen der Quelldateien für "bcmwl-kernel-sources" von Saucy

Hier der [Link](https://launchpad.net/ubuntu/+source/bcmwl/6.30.223.30+bdcom-0ubuntu2) zum Herunterladen. Es müssen 3 Dateien geladen werden:

* *.tar.gz
* *.diff.gz
* *.dsc

### Erzeugen des DEB-Paketes

* `sudo apt-get build-dep bcmwl`
* `dpkg-source -x bcmwl*dsc`
* `cd bcmwl*bdcom`
* `dpkg-buildpackage`

### Einspielen des DEB-Paketes

Das DEB-Paket habe ich eingespielt mit `dpkg -i bcmwl-kernel-source_6.30.223.30+bdcom-0ubuntu2_amd64.deb`. Die Installation blieb
hängen bei "DKMS: install completed", also habe ich sie abgebrochen mit Strg-C.

Zur Sicherheit habe ich noch folgende Kommandos "nachgeschoben":

* `sudo update-initramfs -u`
* `sudo update-grub2`

Dann ein Neustart des Rechners, danach wird der WLAN-Adapter erkannt und
kann konfiguriert werden.

Hinweis: Beim zweiten Installieren hat's ohne Hänger geklappt.

## Probleme

### Systemstart mit "linux-generic-lts-raring" klappt nicht

### Normaler Systemstart klappt nicht - "Wiederherstellungsmodus" ist angesagt

### Installation von bcmwl-kernel-source_6.30.223.30+bdcom-0ubuntu2_amd64.deb bleibt hängen

* Abbrechen mit Strg-C
* `sudo update-initramfs -u`
* `sudo update-grub2`

### WLAN ist erst nach einer Minute betriebsbereit
