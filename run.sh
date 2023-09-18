#!/bin/bash

go(){

  export FG_HOME="$PWD/.fgfs"
  fgdata_path=$(realpath "$DEV1_SUITES/fg/installs/$task/flightgear/fgdata")
  export FG_ROOT=$fgdata_path
  echo $FG_ROOT
  #export FG_SCENERY="$PWD/scenery/"
  #export FG_AIRCRAFT="$PWD/aircraft"
  echo  "FG_HOME:          $FG_HOME"
  echo  "FG_ROOT:          $FG_ROOT"
  echo  "FG_SCENERY:       $FG_SCENERY"
  echo  "FG_AIRCRAFT:      $FG_AIRCRAFT"
  cd     flightgear
  echo  "FlightGear:       $(git branch -v)"
  cd    ../simgear
  echo  "Simgear:          $(git branch -v)"
  cd ..
  pwd
  ls -lah compilation_log.txt
  #$FG_DEV/utilities/last-update $activity
  run_command="$PWD/run_fgfs.sh ${std_options} $@"
  echo ""
  echo "Running Flightgear with run_fgfs.sh in ${PWD}"
  echo ""
  echo ${run_command}
  echo ""
  time ${run_command}
}
if [[ "${MY_CALLSIGN}" == "" ]]; then
   echo "Please define an environment variable for your callsign"
   echo "in your ~/.bashrc"
   echo "for Example:"
   echo "export MY_CALLSIGN=N0000B"
   echo "We'll proceed with N0000B for now...."
   export MY_CALLSIGN=N0000B
fi

task=$1 
# set -x # uncomment to debug
if [[ "$task" == "" ]]; then 
  task="next"
elif [[ "${task:0:1}" == "-" ]]; then
  task="next"
else
shift
fi
fgdata_path=$DEV1_SUITES/fg/tasks/installs/flightgear/fgdata
fgdata_worktree_path=$DEV1_SUITES/fg/worktrees/$task/fgdata

echo $fgdata_path $fgdata_worktree
if [[ ! -e fgdata_path ]]; then
  ln -s $fgdata_path $fgdata_worktree_path 
fi
if [[ -d $DEV1_SUITES/fg/tasks/$task ]];then
  cd $DEV1_SUITES/fg/tasks/$task
  std_options="$(cat $DEV1_SUITES/fg/tasks/next/fgdev/std-options.txt \
  |sed s/\$\{IP_ADDRESS\}/$(hostname -I | cut -d ' ' -f1)/ \
  |sed s/\$\{MY_CALLSIGN\}/${MY_CALLSIGN}/)"
  go $@  2>&1 |tee logs/run_fgfs_$(date +"%Y_%m_%d_%H_%M_%S")_log_.txt
else
  echo "Cannot find $DEV1_SUITES/$tasks"
fi
exit
