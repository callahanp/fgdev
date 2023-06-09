# fg-dev Development Utilities for Flightgear

## In brief

fgdev simplified the work of a Flightgear developer by scripting repetitive tasks
It has been supplanted by a new effort callahanp/dev0.  Dev0 will have a "plug-in for flightgear development, but covers a wider range of development activities than just flightgear.  Dev0 borrows the concept of using a "trees" directory to hold projects, and many of the same commands and command aliases in FGDEV are present in DEV0 and operate similarly.

-Pat Callahan July 6, 2023


The intent was to provide an organized set of scripts for specific workflow tasks in the development of FlightGear, SimGear, Scenery, Aircraft, Vulkan Scene Graph and OpenSceneGraph.

fgdev is new and not broadly used or tested by more than one developer. Expect the unexpected. Report issues.

## fg-dev Features

fg-dev provides easy ways to:

+ Obtain the latest download_and_compile.sh script
+ Build Flightgear next, stable or lts using download_and_compile.sh
+ Work on Aircraft in fgaddon, or in a another directory
+ Work on Scenery including WS2.0, WS3.0, Photoscenery
+ Update download_and_compile.sh on demand by running a simple script
+ Produce a csv of every class in flightgear and simgear, and every class using inheritance.
+ Use Visual Studio Code to view, edit, rebuild and debug with gdb

## Built on download_and_compile.sh

fgdev uses the download_and_compile.sh script to build flightgear, simgear and other components.

## Futures

+ Scenery including Photoscenery and WS3.0
+ Airports
+ Aircraft
+ Modify the way download_and_compile.sh is updated to use a clone of fgmeta instead of wget always use the latest script to build.
+ Modify configurations of local clones to push to personal Sourceforge or Github Clones of flightgear, simgear and others
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

### Create a symbolic link for trees containing working copies of git repositories

```bash
cd fg
ln -s /work/trees ../trees
```

### Update ~/.bashrc

only the first line is required, but the rest are recommended.

```bash
export FG_DEV=/work/fg
# fgdevrc from the repo.
if [ -f ~/work/fg/core/fgdevrc ]; then
    . ~/work/fg/core/fgdevrc
fi
# user's fgdevrc
if [ -f ~/work/fg/trees/fgdevrc ]; then
    . ~/work/fg/trees/fgdevrc
fi
done

export MY_CALLSIGN="N0000B"
```
### After Installation

You'll have two directories somewhere in your filesystem:

├── fg
└── trees

* fg contains all the fgdev scripts and utilities you can 
* trees, which at the moment must be named trees, contains sources for whatever you build and run using fgdev.  

* You can use trees for additional projects beyond flightgear.


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
+ $FG_DEV/utilities
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

b, or build accepts c, clean, -c or --clean as the first parameter, and if used, will remove the build and install folders, but will leave flightgear/fgdata in place.  This is not use standard option processing.  b -c next is legal, but b next -c is ignore the -c.

