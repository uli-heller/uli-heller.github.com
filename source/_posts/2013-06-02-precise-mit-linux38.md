---
layout: post
author: Uli Heller
published: true
title: "Ubuntu-12.04 mit 3.8-er-Kernel"
date: 2013-06-01 17:30
updated: 2013-06-14 19:00
comments: true
categories: 
- Linux
- Ubuntu
- Precise
- Kernel
---

Heute habe ich den Drang verspürt, den Raring-Kernel - also Linux-3.8 - auf
mein Precise-System zu installieren.

<!--more -->

Zuvor hatte ich
dan Hardware-Enablement-Stack für 12.04 installiert
und damit schon den 3.5-er-Kernel verwendet und auch
den neueren XServer. Details dazu stehen hier:
[Neuer Kernel für Ubuntu-12.04](/2013/02/20/precise-hardware-enablement/).

Das Einspielen des Kernels geht ganz einfach. Nach dem Einspielen
muß man seinen Rechner neu starten, damit der neue Kernel auch
verwendet wird:

{% codeblock Einspielen des Raring-Kernels lang:sh %}
$ sudo apt-get install linux-generic-lts-raring
...
Error! Could not locate dkms.conf file.
File:  does not exist.
...
$ reboot
{% endcodeblock %}

Wie oben angedeutet erschien bei mir u.a. eine Fehlermeldung bzgl. "dkms.conf".
Die habe ich einfach ignoriert und noch keinen Fehler festgestellt (auch nicht
mit "VirtualBox" und anderen Dingen, die Kernel-Module benötigen).

Nachdem der neue Kernel gut funktioniert, lösche ich nun die alten Kernels:

{% codeblock Entfernen der Alt-Kernel lang:sh %}
sudo apt-get purge linux-generic
sudo apt-get purge linux-generic-lts-quantal
dpkg --get-selections "linux*-3.2*"|cut -f1|xargs sudo apt-get purge -y
dpkg --get-selections "linux*-3.5*"|cut -f1|xargs sudo apt-get purge -y
{% endcodeblock %}
