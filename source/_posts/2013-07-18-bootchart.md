---
layout: post
author: Uli Heller
published: true
title: "Analyse des Systemstarts"
date: 2013-07-18 10:00
#updatee: 2013-07-12 07:00
comments: true
categories:
- Linux
- Ubuntu
- Precise
---

Mein Samsung-Laptop benötigt sehr lange für den Systemstart.
Gefühlt dauert's 5 Minuten vom Einschalten bis zum Login-Prompt.
Das sollte doch irgendwie schneller gehen - nur wie?

<!-- more -->

## Bootchart

### Installieren

```
sudo apt-get install bootchart pybootchartgui
```

### Neustart

```
sudo reboot
```

### Sichten

* Verzeichnis: /var/log/bootchart
* Dateien: uli-samsung-precise-20130718-1.tgz und uli-samsung-precise-20130718-1.png

![Bootchart vom Samsung-Laptop](/images/bootchart/uli-samsung-precise-20130718-1.png)
