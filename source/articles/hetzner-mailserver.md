---
layout: post
author: Uli Heller
published: true
title: "Hetzner-Mailserver"
date: 2013-02-19 07:00
updated: 2013-02-19 07:00
comments: false
---

Aufsetzen des Hetzner-Mailservers
=================================

Grundinstallation und -konfiguration
------------------------------------

* Anmelden am Robot
* Ubuntu-12.04 64bit
* Anmelden via SSH: root/xxxxx
* Einspielen der SSH-Schlüssel
* Test: Klappt das Anmelden via SSH ohne Kennworteingabe? Ja!

Sichtung der APT-Schlüssel
--------------------------

{% codeblock Paket aktualisieren lang:sh %}
# apt-key list
/etc/apt/trusted.gpg
--------------------
pub   1024D/437D05B5 2004-09-12
uid                  Ubuntu Archive Automatic Signing Key <ftpmaster@ubuntu.com>
sub   2048g/79164387 2004-09-12

pub   1024D/FBB75451 2004-12-30
uid                  Ubuntu CD Image Automatic Signing Key <cdimage@ubuntu.com>

pub   4096R/C0B21F32 2012-05-11
uid                  Ubuntu Archive Automatic Signing Key (2012) <ftpmaster@ubuntu.com>

pub   4096R/EFE21092 2012-05-11
uid                  Ubuntu CD Image Automatic Signing Key (2012) <cdimage@ubuntu.com>
{% endcodeblock %}

Mailbenutzer anlegen
--------------------


Exim installieren und konfigurieren
-----------------------------------
