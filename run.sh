#!/bin/bash
# constructs a command to execute run_fgfs.sh
#
go(){
  export FG_HOME="$PWD/.fgfs"
  export FG_ROOT=$fgdata_path
  #export FG_SCENERY="$PWD/scenery/"
  #export FG_AIRCRAFT="$PWD/aircraft"
  echo "std_options:       $std_options"

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
  run_command="$PWD/run_fgfs.sh $@ ${std_options} "
  echo ""
  echo "Running Flightgear with run_fgfs.sh in ${PWD}"
  echo ""
  echo ${run_command}
  echo ""
  time ${run_command}
}

if [[ ! "$DEV1_DEBUG" == "" ]]; then
  echo "starting $0"
  set -x
fi
if [[ "${MY_CALLSIGN}" == "" ]]; then
   echo "Please define an environment variable for your callsign"
   echo "in your ~/.bashrc"
   echo "for Example:"
   echo "export MY_CALLSIGN=N0000B"
   echo "We'll proceed with N0000B for now...."
   export MY_CALLSIGN=N0000B
fi

task=$DEV1_TASK

# future: Put SG_LOG_DELTAS in my_env.sh or std_env.sh

export SG_LOG_DELTAS="flightgear/=-1,flightgear/src/Network/http=+3,simgear/scene/=1"

# pick first one found of the following for the fgdata setting: FG_ROOT:

fgdata_install_path=$DEV1_SUITES/fg/tasks/$task/install/flightgear/fgdata
fgdata_task_path=$DEV1_SUITES/fg/tasks/$task/fgdata
fgdata_worktree_path=$DEV1_SUITES/fg/worktrees/next/fgdata # default if nowhere else
if [[ -e $fgdata_install_path ]]; then
  fgdata_path=$fgdata_install_path
else 
  if [[ -e $fgdata_task_path ]]; then
    fgdata_path=$fgdata_task_path
    if [[-e fgdata_worktree_path ]]; then
      fgdata_path=$fgdata_worktree_path
    fi
  fi
fi
  # fgdata has to be a real path not a symlink.  I'm not sure why at this point.
  fgdata_path=$(realpath "$fgdata_path")

# Future
# set variable: MY_AIRCRAFT, MY_CALLSIGN ETC.
# example: use first one found of 
#   parameter value: --aircraft=c172p
#   file ./my_options_aircraft.txt containing --aircraft=c172p
#   environment variable my-options-aircraft="--aircraft=c172p"
#   file ./std-options-aircraft.txt containing --aircraft=c172p

options=( aircraft callsign multiplayer terrasync scenery network )

# current implementation uses std-options from fgdev only
# future implement the scheme above.

cd $DEV1_SUITES/fg/tasks/$task
std_options="$(cat $DEV1_SUITES/fg/tasks/next/fgdev/std-options.txt \
|sed s/\$\{IP_ADDRESS\}/$(hostname -I | cut -d ' ' -f1)/ \
|sed s/\$\{MY_CALLSIGN\}/${MY_CALLSIGN}/ \
|sed s/\$\{MY_SCENERY\}/${MY_SCENERY}/)"
# timestamped run log files
go $@  2>&1 |tee logs/run_fgfs_$(date +"%Y%m%d_%H%M%S")_log.txt

if [[ ! "$DEV1_DEBUG" == "" ]]; then
  echo "ending  $0"
  set +x
fi
exit
