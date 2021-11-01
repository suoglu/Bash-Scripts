#!/bin/bash
# This script calls first icarus verilog, then vvp and removes .out

SIM_DIR=""
SRC_DIC=""
SRC_FILE=""

if [ $# -eq 2 ]; then
  SRC_FILE=$2
  echo "Using given source files list $2"
else
  if [ -d "Sim" ]; then
    SIM_DIR="Sim/"
  elif [ -d "sim" ]; then
    SIM_DIR="sim/"
  elif [ -d "Simulation" ]; then
    SIM_DIR="Simulation/"
  elif [ -d "simulation" ]; then
    SIM_DIR="simulation/"
  fi
  if [ -d "src" ]; then
    SRC_DIC="src/"
  elif [ -d "Src" ]; then
    SRC_DIC="Src/"
  elif [ -d "Sources" ]; then
    SRC_DIC="Sources/"
  elif [ -d "sources" ]; then
    SRC_DIC="sources/"
  fi
  if [ -f "$SIM_DIR""sources.txt" ]; then
    SRC_FILE="$SIM_DIR""sources.txt"
  elif [ -f "$SIM_DIR""Sources.txt" ]; then
    SRC_FILE="$SIM_DIR""Sources.txt"
  elif [ -f "$SIM_DIR""src.txt" ]; then
    SRC_FILE="$SIM_DIR""src.txt"
  elif [ -f "$SIM_DIR""Src.txt" ]; then
    SRC_FILE="$SIM_DIR""Src.txt"
  elif [ -f "$SRC_DIC""sources.txt" ]; then
    SRC_FILE="$SRC_DIC""sources.txt"
  elif [ -f "$SRC_DIC""Sources.txt" ]; then
    SRC_FILE="$SRC_DIC""Sources.txt"
  elif [ -f "$SRC_DIC""src.txt" ]; then
    SRC_FILE="$SRC_DIC""src.txt"
  elif [ -f "$SRC_DIC""Src.txt" ]; then
    SRC_FILE="$SRC_DIC""Src.txt"
  fi
  
  if [ $SRC_FILE == "" ]; then
    echo "Cannot find source files list under names sources.txt or src.txt!"
    echo "Searched sim/ simulation/ src/ sources/ and ./"
    echo "Running without additional source files!"
  else
    echo "Found source file list $SRC_FILE"
    SRC_FILE="-c "$SRC_FILE
  fi
fi

if [ $# -eq 1 ] || [ $# -eq 2 ]; then
  iverilog -Wall -o o.out $SRC_FILE $1
  if [ $? -ne 0 ]; then
    echo "iverilog...failed"
    echo "Exiting..."
  else
    wait
    echo "iverilog...done"
    vvp o.out
    if [ $? -ne 0 ]; then
      echo "vvp...failed"
      echo "Exiting..."
    else
      wait
      echo "vvp...done"
      rm o.out
      if [ $? -ne 0 ]; then
        echo "Cannot remove o.out!"
      else
        echo "Script...done"
      fi
    fi
  fi
else
	echo "Usage: verilog.sh <testbench file> [<Source file list>]"
fi
