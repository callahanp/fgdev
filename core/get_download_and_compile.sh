#!/bin/bash
cd ${FG_DEV}
function run_cmd(){
  cmd="$1"
  echo $cmd
  $cmd
  return $?
}
dc="trees/download_and_compile"

patch=1
run_cmd "wget -O ${dc}.sh.new https://sourceforge.net/p/flightgear/fgmeta/ci/next/tree/download_and_compile.sh?format=raw"
if [[ ! -e ${dc}.sh ]]; then
  mv ${dc}.sh.new ${dc}.sh
  echo "${dc}.sh initial download complete"
  chmod +x ${dc}.sh
  exit
else
  run_cmd "diff ${dc}.sh.new ${dc}.sh.orig"
  if [[ $? == 0 ]]; then
	echo "${dc}.sh - No changes"
	rm ${dc}.sh.new 
	exit
  else
	rm ${dc}.sh.orig
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
