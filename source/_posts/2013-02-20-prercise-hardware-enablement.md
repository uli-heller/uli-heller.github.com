---
layout: post
author: Uli Heller
published: true
title: "Neuer Kernel für Ubuntu-12.04"
date: 2013-02-20 07:00
updated: 2013-02-24 10:00
comments: true
categories: 
- Linux
- Ubuntu
- Precise
- Kernel
---

Kommt ein Kernel geflogen ... Hardware Enablement Stack für Ubuntu-12.04
========================================================================

Eben hab' ich mir die Zeit genommen und die 
[Ankündigung für Ubuntu-12.04.2](https://wiki.ubuntu.com/PrecisePangolin/ReleaseNotes/UbuntuDesktop)
ein wenig näher angeschaut. Offenbar gibt's im Zuge des
[LTS Enablement Stacks](https://wiki.ubuntu.com/Kernel/LTSEnablementStack) einen
neuen Kernel (3.5 statt 3.2). Dieser soll die Verwendung von neueren Geräten
ermöglichen.

Eigentlich bin ich mit dem Alt-Kernel recht zufrieden. Alle meine
Rechner laufen - sogar der Problemfall eines AMD-basierten Samsung-Notebooks.
Bei diesem mußte ich allerdings den Grafiktreiber selbst kompilieren, der bei
12.04 ausgelieferte Treiber unterstützt die verbaute Radeon-Karte nicht.

Trotzdem habe ich vor, den neuen Kernel einfach mal auszuprobieren.
Mit etwas Glück läuft er ja genauso gut wie der alte und eventuell
bringt der LTS Enablement Stack ja auch einen funktionierenden
Grafiktreiber für das Samsung-Notebook mit und erspart mit so etwas Arbeit.

Eingespielt werden die ganzen Pakete so:

```sh
sudo apt-get install linux-generic-lts-quantal xserver-xorg-lts-quantal 
```

Da ich eine langsame Internetanbindung habe, dauert das ewig.
Danach habe ich den Rechner einfach neu gestartet und siehe da: Alles
funktioniert noch genauso, wie zuvor. Sogar VirtualBox läuft.

Jetzt sammle ich noch etwas Mut, dann spiele ich's auch auf dem 
Samsung-Notebook ein.

Nachtrag
--------

Leider gibt's jetzt doch ein paar negative Auffälligkeiten:

* Nach dem "Aufwachen" aus "Bereitschaft" laufen die Lüfter auf Höchstdrehzahl
* Starten mit dem alten 3.2-er-Kernel funktioniert nicht mehr - man sieht
  scheinbar die Konsole mit Mauszeiger und kann keine Eingaben vornehmen
