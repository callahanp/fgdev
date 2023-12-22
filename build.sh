if [[ -e build_targets ]]; then
  build_targets=$(cat build_targets)
else 
  build_targets="OSG SIMGEAR FGFS"
fi
if [[ -e build_options ]]; then
  build_options=$(cat build_options)
else 
  build_options="-p n -j 24 -G Ninja"
fi
cmd="fgmeta/download_and_compile.sh $build_options $@ $build_targets" 

echo "$cmd"|grep -e "\-r y"
if [[ "$?" == "0" ]]; then
 cmd=$(echo $cmd|sed -e "s/\-r n//")
fi
# OSG # TERRAGEAR FGRUN FFGO ATCPIE
echo "$cmd"
time $cmd
