#!/bin/bash
#Update/upgrade Apt, dnf, pacman and Flatpaks

if command -v apt; then
    echo "Running apt update:"
    sudo apt update; wait
    echo "apt update done!";  echo
    echo "Running apt upgrade:"
    sudo apt upgrade; wait
    echo "apt upgrade done!"; echo
    echo "Running apt autoremove:"
    sudo apt autoremove; wait
    echo "apt autoremove done!"; echo
fi

if command -v dnf; then
    echo "Running dnf upgrade:"
    sudo dnf upgrade; wait
    echo "dnf upgrade done!"; echo
    echo "Running dnf autoremove:"
    sudo dnf autoremove; wait
    echo "dnf autoremove done!"; echo
fi

if command -v pacman; then
    echo "Running pacman -Syu:"
    sudo pacman -Syu; wait
    echo "pacman -Syu done!"; echo
fi

if command -v flatpak; then
    echo "Running flatpak update:"
    flatpak update; wait
    echo "flatpak update done!"; echo
    echo "Removing unused flatpak:"
    flatpak uninstall --unused; wait
    echo "Unused flatpak removed!"
fi
