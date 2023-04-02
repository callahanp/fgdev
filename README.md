# fg-dev Development Utilities for Flightgear

## In brief

fgdev simplifies the work of a Flightgear developer by scripting repetitive tasks
Development Utilities for Flightgear
The intent is to provide an organized set of scripts for specific workflow tasks in the development of FlightGear, SimGear, Scenery, Aircraft, Vulkan Scene Graph and OpenSceneGraph.

fgdev is new and not broadly used or tested by more than one developer

## fg-dev Features

fg-dev provides easy ways to:

+ Obtain the latest download_and_compile.sh script
+ Build Flightgear next, stable or lts using download_and_compile.sh
+ Work on Aircraft in fgaddon, or in a another directory
+ Work on Scenery including WS2.0, WS3.0, Photoscenery
+ Update download_and_compile.sh on demand by running a simple script
+ Produce a csv of every class in flightgear and simgear, and every class using inheritance.
+ Use Visual Studio Code to view, edit, rebuild and debug with gdb

## Futures

+ Stage, commit and push changes
+ Modify configurations of local clones to push to personal Sourceforge Clones of flightgear, simgear, etc.
+ Scripts for Scenery, Aircraft and Airport development

## Pre-requisite: Visual Studio Code

Required Visual Studio Code extensions:

+ C/C++
+ C/C++ Extension Pack
+ CMake
+ CMakeTools
  
Optional Visual Studio Code extensions:

+ Git Graph
+ Git History
+ Git Blame
+ Git History Diff
+ Markdown All in One
+ MarkdownLint

## Installation

```bash
cd /work
git clone <https://github.com/callahanp/fgdev.git> fg
```

The cd and git command above would create /work/fg with the fg-dev materials.  The remaining parts of README.md assume you are working in /work/fg

### Create a symbolic link for trees containing working copies of repositories

```bash
cd fg
ln -s /work/trees ../trees
```

### Update ~/.bashrc

only the first line is required, but the rest are recommended.

```bash
export FG_DEV=/work/fg
# fgdevrc from the repo.
if [ -f ~/work/fg/helpers/fgdevrc ]; then
    . ~/work/fg/helpers/fgdevrc
fi
# user's fgdevrc
if [ -f ~/work/fg/trees/fgdevrc ]; then
    . ~/work/fg/trees/fgdevrc
fi
done
```

## Environment Variables

+ FG_DEV  a user defined environment variable giving the location of the fg-dev top level project
+ FG_HOME defined as $FG_DEV/homes/something

we can use a different directory in homes for different run scenarios
defaults to $FG_DEV/homes/default/.fgfs

+ FG_ROOT we use wherever the build put fgdata. for example: /work/fg/trees/next/install/flightgear/fgdata
+ FG_SCENERY set as needed
+ FG_AIRCRAFT set as needed

Environment variables can be set as needed in trees/fgdevrc

## FG_DEV directories

All fgdev directories contain scripts for working on some aspect of flightgear's data and code:

+ $FG_DEV/aircraft
+ $FG_DEV/fgcore
+ $FG_DEV/helpers
+ $FG_DEV/scenery
+ $FG_DEV/airports

## Data: Repositories and Others

All fgdev data and source code is kept outside of FG_DEV, but can be access through a symbolic link

+ $FG_DEV/trees -> usually $FG_DEV/../

 $FG_DEV/trees may contain full git repos, additional worktrees, output from helper scripts and anything else you want to keep organized while working on flightgear.

## Scripts, some with convenient aliases

Everything is done with bash scripts, and executing them is a simple as

```bash
core/wget_download_and_compile.sh

core/build 
core/build 
core/run 
core/vscode 
```

or their aliases:

```bash
b 
r
v
```

Parameters to these scripts and aliases specify which tree to operate on.

b, or build accepts c, clean, -c or --clean as the first parameter, and if used, will remove the build and install folders, but will leave flightgear/fgdata in place.
