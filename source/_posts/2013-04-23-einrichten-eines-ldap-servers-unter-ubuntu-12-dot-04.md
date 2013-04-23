---
layout: post
title: "Einrichten eines LDAP-Servers unter Ubuntu-12.04"
date: 2013-04-23 15:38
comments: true
external-url: 
categories: 
- Linux
- Ubuntu
- LDAP
---

<!--
Einrichten eines LDAP-Servers unter Ubuntu-12.04
================================================
-->

Rechner aktualisieren
---------------------

Zunächst sollte der Rechner aktualisiert werden.

{% codeblock Rechner aktualisieren lang:sh %}
sudo apt-get update
sudo apt-get dist-upgrade
{% endcodeblock %}

LDAP-Pakete installieren
------------------------

{% codeblock LDAP-Pakete installieren lang:sh %}
sudo apt-get install slapd ldap-utils cpu
# LDAP-Administrator-Passwort: uli
{% endcodeblock %}

LDAP-Schemas definieren
-----------------------

Standard-Schemas:

{% codeblock LDAP-Schemas definieren lang:sh %}
sudo ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/ldap/schema/cosine.ldif
sudo ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/ldap/schema/nis.ldif
sudo ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/ldap/schema/inetorgperson.ldif
{% endcodeblock %}

Zusatz-Schema:

{% codeblock LDAP-Zusatzschema definieren lang:sh %}
sudo ldapadd -Y EXTERNAL -H ldapi:/// -f /tmp/backend_dp.ldif
{% endcodeblock %}

Das Zusatzschema gibt's [hier](/downloads/code/backend_dp.ldif)

LDAP-Daten importieren
----------------------

Dieser Schritt ist optional. Er dient primär der Übernahme eines Datenbestandes
von einem bestehenden LDAP-Server.

{% codeblock LDAP-Daten importieren lang:sh %}
sudo /etc/init.d/slapd stop
sudo slapadd -c -l 94.out.ldif  # 94.out.ldif ist eine ältere LDAP-Sicherung
sudo /etc/init.d/slapd start
{% endcodeblock %}

LDAP in Firewall freischalten
-----------------------------

Sofern die UFW-Firewall installiert und aktiviert ist, muß der LDAP-Port
freigeschaltet werden.

{% codeblock LDAP in Firewall freischalten lang:sh %}
sudo ufw allow 389/tcp
sudo ufw status
{% endcodeblock %}

LDAP-Daten sichern und zurückspielen
------------------------------------

### Sichern

{% codeblock LDAP-Daten sichern lang:sh %}
sudo slapcat -l /tmp/slapcat.ldif
{% endcodeblock %}

### Zurückspielen

{% codeblock LDAP-Daten zurückspielen lang:sh %}
sudo /etc/init.d/slapd stop
sudo rm -rf /var/lib/ldap/*
sudo slapadd -c -l /tmp/slapcat.ldif
sudo chown -R openldap.openldap /var/lib/ldap/*
sudo /etc/init.d/slapd start
{% endcodeblock %}
