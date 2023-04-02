#!/bin/bash

cd ${FG_DEV}

if [[ -e download_and_compile.sh~ ]]
then 
	mv -f download_and_compile.sh~ download_and_compile.sh~~
else 
  if [[ -e  download_and_compile.sh ]]
  then
	cp download_and_compile.sh     download_and_compile.sh~~
  fi
fi
if [[ -e  download_and_compile.sh ]]
then
  cp      download_and_compile.sh     download_and_compile.sh~
fi

wget -O download_and_compile.sh https://sourceforge.net/p/flightgear/fgmeta/ci/next/tree/download_and_compile.sh?format=raw
#wget -O download_and_compile.sh https://sourceforge.net/u/frougon/flightgear-fgmeta/ci/download_and_compile.sh-changes/tree/download_and_compile.sh?format=raw
if [[ -e  download_and_compile.sh~ ]]
then
  diff download_and_compile.sh download_and_compile.sh~
  if [[ $? == 0 ]]
  then
	echo "download_and_compile.sh - No changes"
	mv -f download_and_compile.sh~~ download_and_compile.sh~
  else
	rm download_and_compile.sh~~
  fi
else
 echo "download_and_compile.sh initial download complete"
fi
