#!/bin/sh

CRX_URL='https://clients2.google.com/service/update2/crx?response=redirect&x=id%%3D%s%%26uc'

BN="$(basename "$0")"
D="$(dirname "$0")"
D="$(cd "${D}"; pwd)"

TMPDIR="/tmp/${BN}.$$~"

cleanUp () {
  rm -rf "${TMPDIR}"
}

trap cleanUp 0 1 2 3 4 5 6 7 8 9 10 12 13 14 15

getJson () {
  if [ -z "$2" ]; then
    cat
  else
    cat "$2"
  fi                 \
  |"${D}/JSON.sh"    \
  |grep "\[\"$1\"\]" \
  |sed -e "s/^\s*\[\"$1\"\]\s*//" -e "s/^\"//" -e "s/\"$//"
}

trxName () {
  #"name": "__MSG_ext_name__",
  msg="$(expr "$1" : "__MSG_\(.*\)__")"
  if [ ! -z "${msg}" ]; then
    getJson "${msg}" "$2"|getJson "message"
  else
    echo "$1"
  fi
}

mkdir "${TMPDIR}"
(
  cd "${TMPDIR}"
  wget -c "$(printf "${CRX_URL}" "$1")"
  DOWNLOAD_NAME="$(echo *)"
  unzip -qqq -d x "${DOWNLOAD_NAME}"
  VERSION="$(getJson version x/manifest.json)"
  TMP_NAME="$(getJson name x/manifest.json)"
  NAME="$(trxName "${TMP_NAME}" "x/_locales/en/messages.json")"
  rm -rf x
  set -x
  mv "${DOWNLOAD_NAME}" "$(echo "${NAME}-${VERSION}"|tr " " "_").crx"
)

mv "${TMPDIR}/"*.crx .
cleanUp
exit 0
