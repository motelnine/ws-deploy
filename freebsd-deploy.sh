doas kldload linux64.ko
doas pkg upgrade


doas pkg install curl wget fusefs-sshfs


doas pkg install ntp
doas cp /usr/share/zoneinfo/America/Phoenix /etc/localtime

doas pkg install fish bash

# i3
doas pkg install i3 i3lock dmenu polybar rofi nerd-fonts
doas pkg install keepassxc cherrytree pasystray lxappearance thunar nautilus file-roller
doas pkg install papirus-icon-theme pop-icon-theme materia-gtk-theme


# Media Players
doas pkg install vlc audacious audacious-plugins

# Graphic Design
doas pkg isntall gimp
doas pkg install blender
doas pkt install krita

doas pkg install xfce4-terminal
doas pkg install feh


doas pkg install webfonts

doas pkg install firefox



cd ~/Projects/motelnine

doas pkg install portsnap
doas cp /usr/local/etc/portsnap.conf.sample /usr/local/etc/portsnap.conf
doas mkdir -p /var/db/portsnap
doas chown -R root:wheel /var/db/portsnap
doas chmod -R 755 /var/db/portsnap
doas portsnap fetch
doas portsnap extract

# dotfile stuff
git clone git@github.com:motelnine/dotfiles.git

mkdir ~/.config/polybar
cp ~/Projects/motelnine/dotfiles/polybar/config ~/.config/polybar/

mkdir ~/.config/rofi
cp ~/Projects/motelnine/dotfiles/rofi/config.rasi ~/.config/rofi/

# Net tool
doas pkg install nmap whois

# Virtualizatiuon
sudo pkg install qemu qemu-tools
