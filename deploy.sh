#!/bin/bash
yn () {
	printf "Install '$1' [y/n] "
}

echo "Creating ~/Downloads"
mkdir -p ~/Downloads

echo "Creating ~/Projects"
mkdir -p ~/Projects

#yn "Enable multilib"
#read MULTILIB
#if [ $MULTILIB == "y" ]
#then
#	sudo echo "[multilib]" >> /etc/pacman.conf
#	sudo echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
#fi

yn "general dependencies"
read GENERAL
if [ $GENERAL == "y" ]
then
	sudo pacman -S ntfs-3g ffmpegthumbnailer gst-libav gst-plugins-base gst-plugins-good network-manager-applet dnsutils inetutils nmap pavucontrol
fi

yn "firefox"
read FIREFOX
if [ $FIREFOX == "y" ]
then
	sudo pacman -S firefox
fi

yn "base-devel"
read BASEDEVEL
if [ $BASEDEVEL == "y" ]
then
	sudo pacman -S base-devel go rustup
	rustup default stable
fi

yn "yay"
read YAY
if [ $YAY == "y" ]
then
	cd ~/Downloads
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si
fi

yn "media players":
read MEDIAPLAYERS
if [ $MEDIAPLAYERS == "y" ]
then
	sudo pacman -S vlc rhythmbox
	yay -S tauon-music-box
fi


yn "design tools":
read DESIGNTOOLS
if [ $DESIGNTOOLS == "y" ]
then
	sudo pacman -S gimp blender krita
	yay -S aseprite
fi


yn "keepassxc"
read KEEPASSXC
if [ $KEEPASSXC == "y" ]
then
	sudo pacman -S keepassxc
fi

printf "Clone dotfiles [y/n]"
read DOTFILES
if [ $DOTFILES == y ]
then
	echo "Cloning dotfiles..."
	mkdir ~/Projects/motelnine
	git clone https://github.com/motelnine/dotfiles ~/Projects/motelnine/dotfiles
fi

yn "i3-gaps"
read I3GAPS
if [ $I3GAPS == "y" ]
then
	sudo pacman -S dmenu lxappearance rofi
	yay -S i3-wm feh picom i3lock-fancy
	mkdir -p ~/.config/i3
	cp ~/Projects/motelnine/dotfiles/i3/config ~/.config/i3/config
	mkdir -p ~/Pictures
	mkdir -p ~/Pictures/Wallpaper
	cp ~/Projects/motelnine/dotfiles/wallpaper/* ~/Pictures/Wallpaper/
	mkdir -p ~/.config/picom
	cp ~/Projects/motelnine/dotfiles/picom/picom.conf ~/.config/picom/
	mkdir -p ~/.config/rofi
	cp ~/Projects/motelnine/dotfiles/rofi/config.rasi ~/.config/rofi/
fi

yn "GTK Themes"
read GTKTHEMES
if [ $GTKTHEMES == "y" ]
then
	yay -S arc-gtk-theme material-black-colors-theme graphite-gtk-theme nordic-theme candy-icons yaru-colors-icon-theme yaru-colors-wallpapers yaru-colors-gtk-theme
fi

yn "Stacer"
read STACER
if [ $STACER == "y" ]
then
	yay -S stacer
fi

yn "vim plugins"
read VIM
if [ $VIM == "y" ]
then
	sudo pacman -S wget
	cd ~/Projects/motelnine/dotfiles/vim
	cp vimrc ~/.vimrc
	chmod 755 installplugins.sh
	./installplugins.sh
fi

yn "utilities and fonts"
read UTILS
if [ $UTILS == "y" ]
then
	sudo pacman -S htop aspell-en neofetch numlockx ttf-nerd-fonts-symbols
	yay -S cava agave nerd-fonts-jetbrains-mono ttf-jetbrains-mono-git
fi	

yn "terminals"
read TERMINALS
if [ $TERMINALS == "y" ]
then
	sudo pacman -S xfce4-terminal
	yay -S kitty
	mkdir -p ~/.config/kitty
	cp ~/Projects/motelnine/dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
fi


yn "xfce4-panel"
read XFCE4PANEL
if [ $XFCE4PANEL == "y" ]
then
	sudo pacman -S xfce4-panel xfce4-goodies xfce4-battery-plugin network-manager-applet
	yay -S network-manager-applet-gtk2 xfce4-i3-workspaces-plugin-git xfce4-pulseaudio-plugin
	sudo cp ~/Projects/motelnine/dotfiles/arch/icons/* /usr/share/pixmaps/
fi

yn "Golang Dev Tools"
read GOLANG
if [ "$GOLANG" == "y"]
then
	yay -S golangci-lint-bin
fi

yn "Python Dev Tools"
read PYTHON
if [ $PYTHON == "y" ]
then
	sudo pacman -S python
	yay -S python-pylint python-psycopg2 python-pandas python3-numpy
fi

yn "Javascript Dev Tools"
read "JAVASCRIPT"
if [ "$JAVASCRIPT" == "y" ]
then
	sudo pacman -S nodejs npm yarn
	yay -S nodejs-jslinter jslint
fi

yn "fish"
read FISH
if [ $FISH == "y" ]
then
	sudo pacman -S fish
	mkdir -p ~/.config/fish
	cp ~/Projects/motelnine/dotfiles/fish/config.fish ~/.config/fish/config.fish
fi

yn "lxdm-themes"
read LXDM
if [ $LXDM == "y" ]
then
	yay -S lxdm-themes 
fi

yn "xfce4-i3-workspaces-plugin-git"
read SWITCHER
if [ $SWITCHER == "y" ]
then
	yay -S xfce4-i3-workspaces-plugin-git
fi

yn "ckb-next"
read CKBNEXT
if [ $CKBNEXT == "y" ]
then
	yay -S ckb-next
	sudo systemctl enable ckb-next-daemon
	sudo systemctl start ckb-next-daemon
fi

yn "Alfa Network Wifi Driver (yay)"
read ALFAWIFI
if [ $ALFAWIFI == "y" ]
then
	yay -S rtl8812au-dkms-git
fi


yn "Surface addons"
read SURFACE
if [ $SURFACE == "y" ]
then
	sudo pacman -S iw
	sudo pacman -S xf86-input-synaptic
fi

yn "Nvidia"
read NVIDIA 
if [ $NVIDIA == "y" ]
then
	sudo pacman -S nvidia nvidia-utils nvidia-settings lib32-nvidia-utils
fi

yn "Pulse/Alsa 32 Bit"
read PULSE
if [ $PULSE == "y" ]
then
	sudo pacman -S lib32-alsa-plugins lib32-libpulse lib32-openal
fi

yn "Browser/Gaming Libraries"
read LIBVA
if [ $LIBVA == "y" ]
then
	sudo pacman -S libva lib32-libva lib32-gnutls lib32-libldap lib32-libgpg-error lib32-sqlite lib32-libpulse
fi

yn "NetTools"
read NETTOOLS
if [ $NETTOOLS == "y" ]
then
	sudo pacman -S net-tools whois
fi

yn "Cherry Tree"
read CHERRYTREE
if [ $CHERRYTREE == "y" ]
then
	sudo pacman -S cherrytree
fi

yn "Remmina"
read $REMMINA
if [ $REMMINA == "y" ]
then
	sudo pacman -S remmina parcellite xdotool
fi

#yn "BlackArch"
#read BLACKARCH
#if [ $BLACKARCH == "y" ]
#then
#	curl -O https://blackarch.org/strap.sh
#	chmod 755 strap.sh
#	sudo ./strap.sh
#	rm -i strap.sh
#fi

yn "Bluetooth Support"
read BLUETOOTH
if [ $BLUETOOTH == "y" ]
then
	sudo pacman -S bluez bluez-utils blueman
fi

yn "Red Team Tools"
read READTEAM
if [ $REDTEAM == "y" ]
then
	sudo pacman -S extra/exploitdb npm metasploit nikto extra/exploitdb
	yay -S theharvester-git python-playwright burpsuite
fi

#yn "LMMS Support"
#read LMMS
#if [ $LMMS == "y" ]
#then
#	sudo pacman -S carla pulseaudio-jack
#fi

yn "Generic Drawing Tablet Support"
read DRAWTAB
if [ $DRAWTAB == "y" ]
then
	yay -S digimend-kernel-drivers-dkms xorg-xinput
	echo "Done.\nSee: util/generic-tablet-setup.sh"
fi


