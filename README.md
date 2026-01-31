collection of dot config files for OXWM with a simple install script for a fresh Arch linux with yay

Arch bootable usb

iwctl
device wlan0 station
station wlan0 scan
station wlan0 connect SSID
Enter password / exit.

Install arch.
- Audio: pulse
- Network, copy from ISO or NetworkManager

sudo pacman -Syu \
sudo pacman -S git base-devel xorg xorg-xinit xorg-xrandr
mkdir Install

Install YAY
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

Install this Desktop
git clone https://github.com/MarshmelloVapes/OXWM-DE.git
cd oxwm-de
sudo chmod +x set-oxwm
./set-oxwm

This script sets up the basic system that I am personally after.
