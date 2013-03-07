---
layout: post
author: Uli Heller
published: true
title: "Chrome-Erweiterungen"
date: 2013-03-04 07:00
updated: 2013-03-04 07:00
comments: true
categories: 
- Chrome
- Linux
---

Offline-Installation einer Chrome-Erweiterung
=============================================

Mein aktueller Lieblingsbrowser ist zur Zeit Google-Chrome. Dumm nur, wenn
bei manchen Unternehmen der ausgehende Internet-Verkehr so gefiltert wird,
dass nur manch andere Browser (beispielsweise Internet Explorer) zugelassen
sind.

Ein paar Tests zeigen, dann man durch Setzen des "User-Agents" relativ
einfach auch mit Google-Chrome arbeiten kann. Den "User-Agent" setzt man
in Google-Chrome auf diese Weise:

* Tools - Entwicklertools
* Settings (ganz unten rechts)
* Overrides - User Agent
    * aktivieren
    * gewünschten User-Agent auswählen

Grundsätzlich funktioniert dies, nur muß man die Einstellungen bei
jedem Start von Google-Chrome neu durchführen. Zum Glück gibt's ja
Erweiterungen wie
[Ultimate User Agent Switcher, URL sniffer](https://chrome.google.com/webstore/detail/ultimate-user-agent-switc/ljfpjnehmoiabkefmnjegmpdddgcdnpo),
die die Handhabung deutlich verbessern. Leider funktioniert
der Zugriff auf Google-Play nicht, er wird bei meinem Unternehmen
offenbar separat geblockt.

Also: Wir brauchen eine Möglichkeit, Erweiterungen für Google-Chrome
ohne Zugriff auf Google-Play zu installieren.

Verpacken und Entpacken - geht leider nicht
-------------------------------------------

Erste Versuche laufen so:

* Rechner A:
    * Wechseln in's Erweiterungsgrundverzeichnis
    * Verpacken einer installierten Erweiterung
* Rechner B:
    * Wechseln in's Erweiterungsgrundverzeichnis
    * Entpacken einer installierten Erweiterung

Leider funktioniert dies nicht. Google-Chrome auf Rechner B scheint
zu erkennen, dass ihm eine Erweiterung untergeschoben werden soll.
Sie wird ignoriert und gelöscht beim Start von Google-Chrome.

Runterladen mittels Skript
--------------------------

* Ermitteln der Applikations-Id
* `./get-crx.sh ljfpjnehmoiabkefmnjegmpdddgcdnpo`: Ultimate-User-Agent-Switcher,-URL-sniffer_v0.9.2.2.crx
* `./get-crx.sh loljledaigphbcpfhfmgopdkppkifgno`: Lazarus:_Form_Recovery-3.0.5.crx

Das Skript verwendet den Json-Parser [JSON.SH](https://github.com/dominictarr/JSON.sh/blob/master/JSON.sh)

So geht's:

* Verpacken
    1. Sichtung der Erweiterung auf Google-Play: Der letzte Teil der Url ist die
       ID der Erweiterung
        * Ultimate User Agent Switcher, URL sniffer
        * https://chrome.google.com/webstore/detail/ultimate-user-agent-switc/ljfpjnehmoiabkefmnjegmpdddgcdnpo
        * ID=ljfpjnehmoiabkefmnjegmpdddgcdnpo
    2. Wechseln in's Erweiterungsgrundverzeichnis:
       `cd ~/.config/google-chrome/Default/Extensions`
    3. Wechseln in's Erweiterungsverzeichnis (dazu muß man obige ID kennen):
       `cd ljfpjnehmoiabkefmnjegmpdddgcdnpo`
    4. Wechseln in's Versionsverzeichnis:
       `0.9.2.2_0`
    5. Verpacken der Erweiterung:
       `zip -r /tmp/user-agent-switcher.crx .`
* Installieren
    1. Wechseln in's Erweiterungsgrundverzeichnis:
       `cd ~/.config/google-chrome/Default/Extensions`
    2. ...

Notizen:
--------

* Linux: /home/username/.config/google-chrome/Default/Extensions
* Mac: /Users/username/Library/Application Support/Google/Chrome/Default/Extensions
* Windows 7: C:\Users\username\AppData\Local\Google\Chrome\User Data\Default\Extensions
* Windows XP: C:\Documents and Settings\YourUserName\Local Settings\Application Data\Google\Chrome\User Data\Default

Links:
------

* [Download Chrome extension from other browser (for offline installation)](http://blog.gerardin.info/archives/763)
* [Ultimate User Agent Switcher, URL sniffer](https://chrome.google.com/webstore/detail/ultimate-user-agent-switc/ljfpjnehmoiabkefmnjegmpdddgcdnpo)
* [Chrome Extension Downloader](http://chrome-extension-downloader.com/)
* [Downloading the CRX of a Chrome extension](http://thameera.wordpress.com/2011/10/29/downloading-the-crx-of-a-chrome-extension/)