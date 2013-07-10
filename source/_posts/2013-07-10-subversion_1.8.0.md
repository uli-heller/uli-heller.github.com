---
layout: post
author: Uli Heller
published: false
title: "Subversion 1.8.0 für Ubuntu-12.04"
date: 2013-07-10 10:00
comments: true
categories:
- Linux
- Ubuntu
- Precise
- Subversion
---

Vor ein paar Tagen wurde Subversion-1.8.0 veröffentlicht.
Hier meine Versuche, ein Paket für Ubuntu-12.04 zu bauen.

<!-- more -->

## Ausgangpunkt: Subversion-1.7.10

Mein Ausgangspunkt sind die Pakete für Subversion-1.7.10.

    $ cd subversion-1.7.10
    $ uupdate -u ../subversion-1.8.0
    $ cd ../subversion-1.8.0
    $ dpkg-buildpackage

## Erste Hürde: Serf-1.2.1

## Zweite Hürde: Sqlite-3.7.15

## Dritte Hürde: Python-Test bricht ab

{% codeblock %}
Running testsuite - may take a while.  To disable,
use DEB_BUILD_OPTIONS=nocheck or edit debian/rules.

/usr/bin/make -f debian/rules check-swig-py check-swig-pl check-swig-rb
make[1]: Entering directory `/home/ubuntu/build/subversion/subversion-1.8.0'
set -e; for v in 2.7; do rm -f BUILD/subversion/bindings/swig/python; ln -fs python$v BUILD/subversion/bindings/swig/python; pylib=$(python$v -c 'from distutils import sysconfig; print sysconfig.get_python_lib()');  /usr/bin/make -C BUILD check-swig-py PYTHON=python$v PYVER=$v CLEANUP=1 LC_ALL=C; done
make[2]: Entering directory `/home/ubuntu/build/subversion/subversion-1.8.0/BUILD'
if [ "LD_LIBRARY_PATH" = "DYLD_LIBRARY_PATH" ]; then for d in ./subversion/bindings/swig/python/libsvn_swig_py ./subversion/bindings/swig/python/../../../libsvn_*; do if [ -n "$DYLD_LIBRARY_PATH" ]; then LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$d/.libs"; else LD_LIBRARY_PATH="$d/.libs"; fi; done; export LD_LIBRARY_PATH; fi; \
	cd ./subversion/bindings/swig/python; \
	  python2.7 /home/ubuntu/build/subversion/subversion-1.8.0/subversion/bindings/swig/python/tests/run_all.py
...........................................................................................................................
----------------------------------------------------------------------
Ran 123 tests in 301.417s

OK
make[2]: Leaving directory `/home/ubuntu/build/subversion/subversion-1.8.0/BUILD'
set -e; for v in 2.7; do rm -f BUILD/subversion/bindings/swig/python; ln -fs python$v-dbg BUILD/subversion/bindings/swig/python; pylib=$(python$v -c 'from distutils import sysconfig; print sysconfig.get_python_lib()');  /usr/bin/make -C BUILD check-swig-py PYTHON=python$v-dbg PYVER=${v}_d PYTHON_INCLUDES=-I/usr/include/python${v}_d CLEANUP=1 LC_ALL=C; done
make[2]: Entering directory `/home/ubuntu/build/subversion/subversion-1.8.0/BUILD'
if [ "LD_LIBRARY_PATH" = "DYLD_LIBRARY_PATH" ]; then for d in ./subversion/bindings/swig/python/libsvn_swig_py ./subversion/bindings/swig/python/../../../libsvn_*; do if [ -n "$DYLD_LIBRARY_PATH" ]; then LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$d/.libs"; else LD_LIBRARY_PATH="$d/.libs"; fi; done; export LD_LIBRARY_PATH; fi; \
	cd ./subversion/bindings/swig/python; \
	  python2.7-dbg /home/ubuntu/build/subversion/subversion-1.8.0/subversion/bindings/swig/python/tests/run_all.py
........................Fatal Python error: subversion/bindings/swig/python/svn_client.c:23145 object at 0x399b498 has negative ref count -2604246222170760230
/bin/bash: line 2: 16967 Aborted                 (core dumped) python2.7-dbg /home/ubuntu/build/subversion/subversion-1.8.0/subversion/bindings/swig/python/tests/run_all.py
make[2]: *** [check-swig-py] Error 134
make[2]: Leaving directory `/home/ubuntu/build/subversion/subversion-1.8.0/BUILD'
make[1]: *** [check-swig-py] Error 2
make[1]: Leaving directory `/home/ubuntu/build/subversion/subversion-1.8.0'
make: *** [debian/stamp-build-arch] Error 2
dpkg-buildpackage: error: debian/rules build gave error exit status 2
{% endcodeblock %}
