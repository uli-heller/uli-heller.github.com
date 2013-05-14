---
layout: post
author: Uli Heller
published: false
title: "OpenVPN unter Ubuntu nutzen"
date: 2013-05-14 06:00
#updated: 2013-05-12 19:00
comments: true
categories: 
- Linux
- Ubuntu
- Precise
- OpenVPN
---

Installation von OpenVPN
------------------------

{% codeblock Installation von OpenVPN %}
sudo apt-get install openvpn
{% endcodeblock %}

Konfigurationsdateien von OpenVPN einspielen
---------------------------------------------

{% codeblock Konfigurationsdateien von OpenVPN einspielen %}
mkdir ~/openvpn
unzip -d ~/openvpn uheller.zip
{% endcodeblock %}

Es werden Dateien wie diese abgelegt:

* openvpn/2E76.crt        
* openvpn/2E76.key        
* openvpn/ca.crt          
* openvpn/ta.key          
* openvpn/uheller.ovpn    

OpenVPN starten
---------------

{% codeblock OpenVPN starten %}
$ openvpn ~/openvpn/uheller.ovpn
Enter Auth Username: uheller
Enter Auth Password: xxxx
{% endcodeblock %}
