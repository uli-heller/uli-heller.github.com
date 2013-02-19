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

Zusatzprogramme installieren und Systemaktualisierung
-----------------------------------------------------

Zunächst installiere ich einige Zusatzprogramme:

{% codeblock Zusatzprogramme installieren lang:sh %}
apt-get install joe
{% endcodeblock %}

Dann eine Aktualisierung des Komplettsystems gefolgt von einem Neustart:

{% codeblock Systemaktualisierung lang:sh %}
apt-get update
apt-get dist-upgrade
reboot
{% endcodeblock %}

Mailbenutzer anlegen
--------------------

{% codeblock Mailbenutzer anlegen lang:sh %}
useradd -m dpmail
id dpmail
 uid=1000(dpmail) gid=1000(dpmail) groups=1000(dpmail)
{% endcodeblock %}

Exim installieren und konfigurieren
-----------------------------------

Exim installieren:

{% codeblock Exim installieren lang:sh %}
apt-get install exim4-daemon-heavy
{% endcodeblock %}

Exim konfigurieren:

{% codeblock Exim konfigurieren lang:sh %}
dpkg-reconfigure exim4-config
{% endcodeblock %}

Zur Durchführung der Konfiguration müssen einige Fragen beantwortet werden:

* General type of mail configuration:
  internet site; mail is sent and received directly using SMTP
* System mail name:
  daemons-point.com
* IP-addresses to listen on for incoming SMTP connections:
  *
* Other destinations for which mail is accepted:
  daemons-point.com,daspersonal.com
* Domains to relay mail for:
  LEER
* Machines to relay mail for:
  LEER
* Keep number of DNS-queries minimal (Dial-on-Demand)?
  No
* Delivery method for local mail:
  mbox format in /var/mail/
* Split configuration into small files?
  No

Danach:

{% codeblock Exim-Konfiguration abschliessen lang:sh %}
cp .../exim4.conf /etc/exim4/exim4.conf
chown -R Debian-exim.Debian-exim /var/log/exim4
{% endcodeblock %}

Dateilisten
-----------

Diese Dateien wurden geändert:

* /root/.ssh/authorized_keys
* /etc/apt/sources.list
* /etc/apt/sources.list.hetzner
* /etc/apt/sources.list.120464
* /etc/exim4/exim4.conf
* /etc/exim4/blocked-recipients
* /etc/hosts
* /etc/hostname
* /home/dpmail/.ssh/authorized_keys

Probleme
--------

### Programmaktualisierung bricht ab: WARNING: The following packages cannot be authenticated!

Problem:

{% codeblock Programmaktualisierung reparieren lang:sh %}
apt-get install joe
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following NEW packages will be installed:
  joe
0 upgraded, 1 newly installed, 0 to remove and 3 not upgraded.
Need to get 481 kB of archives.
After this operation, 1,340 kB of additional disk space will be used.
WARNING: The following packages cannot be authenticated!
  joe
Install these packages without verification [y/N]? 
E: Some packages could not be authenticated
{% endcodeblock %}

Korrektur:

{% codeblock Programmaktualisierung reparieren lang:sh %}
cd /etc/apt
cp sources.list sources.list.hetzner
cp ubuntu120464:/etc/apt/sources.list sources.list
apt-get update
apt-get install joe
{% endcodeblock %}
