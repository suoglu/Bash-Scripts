#!/bin/bash
# Generate random binary data

if [ $# -eq 2 ]; then
  dd if=/dev/urandom of=$1 bs=$2 count=1
elif [ $# -eq 3 ]; then
  dd if=/dev/urandom of=$1 bs=$2 count=$3
else
  echo "Usage: rand-bin-gen <filename> <random data size> [repetition]"
fi
