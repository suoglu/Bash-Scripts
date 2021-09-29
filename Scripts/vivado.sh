#!/bin/bash
ARG=""

if [ 1 -lt $# ]; then
  echo "Too many arguments!"
  exit 1
elif [ 1 -eq $# ]; then
  ARG=$1
fi

if [[ "${PWD##*/}" != "vivado" ]]; then
  if [ ! -d "vivado" ]; then
    mkdir vivado
  fi
  cd vivado
fi

PROJECTS=$(ls *.xpr 2>/dev/null)
XPR_COUNT=$(echo "$PROJECTS" | wc -w)

if [ $XPR_COUNT -eq 0 ]; then
  vivado
elif [[ $ARG != "" ]]; then
  if [ -f $ARG ]; then
    vivado "${ARG##*/}"
  else
    echo -n "$ARG does not exist! Open a empty vivado? (y/n): "
    read RESPONSE
    if [[ $RESPONSE == "y" ]]; then
      vivado
    else
      exit
    fi 
  fi
elif [ $XPR_COUNT -eq 1 ]; then
  vivado $PROJECTS
else
  echo "Multiple projects found! Please select one."
  echo $PROJECTS  | tr ' ' '\n'
  exit
fi

