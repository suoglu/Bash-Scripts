#!/bin/bash
#Update/upgrade Apt and Flatpaks

echo "Running apt update:"
sudo apt update; wait
echo "apt update done!";  echo
echo "Running apt upgrade:"
sudo apt upgrade; wait
echo "apt upgrade done!"; echo
echo "Running flatpak update:"
flatpak update; wait
echo "flatpak update done!"

