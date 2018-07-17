#!/bin/sh
###############################################################################
#
# ファイル内の正規表現(grep/sed)にヒットする文字列を、置き換える。
# ただし、正規表現にヒットしない場合は、追記する。
# 引数:
#   - 1:対象ファイル
#   - 2:正規表現
#   - 3:置換文字列
#
###############################################################################
NAME=${0##*/}
LOG=/tmp/${NAME:?}.log
TMP=/tmp/${NAME:?}.tmp

usage() {
  # FILE内のREGEXPを、REPLACEで置き換える
  # REGEXPがヒットしない場合は、追記する。
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
