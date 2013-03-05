#!/bin/sh

CRX_URL='https://clients2.google.com/service/update2/crx?response=redirect&x=id%%3D%s%%26uc'

BN="$(basename "$0")"

TMPDIR="/tmp/${BN}.$$~"

cleanUp () {
  rm -rf "${TMPDIR}"
}

trap cleanUp 0 1 2 3 4 5 6 7 8 9 10 12 13 14 15

getJson () {
  grep "\"$1\"" "$2"\
  |while read l; do
    expr "$l" : "[ \t]*\"$1\"[: \t]*\"\([^\"]*\)\""
  done
}

trxName () {
  #"name": "__MSG_ext_name__",
  msg="$(expr '$1' : "__MSG_\(.*\)__")"
  if [ ! -z "${msg}" ]; then
    msg=
  fi
}

mkdir "${TMPDIR}"
(
  cd "${TMPDIR}"
  wget -c "$(printf "${CRX_URL}" "$1")"
  DOWNLOAD_NAME="$(echo *)"
  unzip -qqq -d x "${DOWNLOAD_NAME}"
  VERSION="$(getJson version x/manifest.json)"
  NAME="$(getJson name x/manifest.json)"
  rm -rf x
  set -x
  mv "${DOWNLOAD_NAME}" "$(echo "${NAME}-${VERSION}"|tr " " "_").crx"
)

mv "${TMPDIR}/"*.crx .
cleanUp
exit 0
