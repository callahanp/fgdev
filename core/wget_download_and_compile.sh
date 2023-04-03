#!/bin/bash
cd ${FG_DEV}/core
function run_cmd(){
  cmd="$1"
  echo $cmd
  $cmd
  return $?
}
dc="download_and_compile"
patch=1
wget -O ${dc}.sh.new https://sourceforge.net/p/flightgear/fgmeta/ci/next/tree/${dc}.sh?format=raw
if [[ ! -e ${dc}.sh ]]; then
  mv ${dc}.new ${dc}.sh
  echo "${dc}.sh initial download complete"
  exit
else
  run_cmd "diff ${dc}.sh.new ${dc}.sh.orig"
  if [[ $? == 0 ]]; then
	echo "${dc}.sh - No changes"
	rm ${dc}.sh.new 
	exit
  else
	rm ${dc}.sh~
	cp ${dc}.sh.new ${dc}.sh.orig
	run_cmd "cp ${dc}.sh.new ${dc}.sh"
	patch=0
  fi
fi  
if [[ "$patch" ]]; then
   for p in download_and_compile_*.diff; do
   if [[ -e "$p" ]]; then
     run_cmd "patch  ${dc}}.sh <${p}"
   fi
   done  
fi
chmod +x ${dc}.sh
./build next
