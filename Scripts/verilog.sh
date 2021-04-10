#!/bin/bash
# This script calls first icarus verilog, then vvp and removes .out

if [ $# -eq 1 ]; then
  iverilog -Wall -o o.out $1
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
        echo "done"
      fi
    fi
  fi
else
	echo "Usage: verilog.sh <testbench file>"
fi
