#!/bin/sh
###############################################################################
#
# $B%U%!%$%kFb$N@55,I=8=(B(grep/sed)$B$K%R%C%H$9$kJ8;zNs$r!"CV$-49$($k!#(B
# $B$?$@$7!"@55,I=8=$K%R%C%H$7$J$$>l9g$O!"DI5-$9$k!#(B
# $B0z?t(B:
#   - 1:$BBP>]%U%!%$%k(B
#   - 2:$B@55,I=8=(B
#   - 3:$BCV49J8;zNs(B
#
###############################################################################
NAME=${0##*/}
LOG=/tmp/${NAME:?}.log
TMP=/tmp/${NAME:?}.tmp

usage() {
  # FILE$BFb$N(BREGEXP$B$r!"(BREPLACE$B$GCV$-49$($k(B
  # REGEXP$B$,%R%C%H$7$J$$>l9g$O!"DI5-$9$k!#(B
  echo "\$ ${NAME:?} FILE REGEXP REPLACE" 1>&2
  exit 1
}

if [ "$#" -ne "3" ]; then
  usage
  exit 1
fi

FILE=$1
REGEXP="$2"
REPLACE="$3"

main() {
  set -xve
  if grep "$REGEXP" "$FILE"; then
    mv ${FILE:?} ${TMP:?}
    sed "s/$REGEXP/$REPLACE/g" ${TMP:?} > ${FILE:?}
  else
    echo ${REPLACE:?} >> ${FILE:?}
  fi
}

main > ${LOG:?} 2>&1
exit 0
