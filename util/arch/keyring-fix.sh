#!/bin/bash
sudo rm -R /etc/pacman.d/gnupg/
sudo pacman-key --init
sudo pacman-key --populate archlinux
sudo pacman -Scc
sudo pacman -S archlinux-keyring
