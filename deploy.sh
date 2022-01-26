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
	sudo pacman -S base-devel
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
	git clone https://github.com/motelnine/dotfiles ~/Projects/dotfiles
fi

yn "i3-gaps"
read I3GAPS
if [ $I3GAPS == "y" ]
then
	sudo pacman -S dmenu lxappearance
	yay -S i3-gaps feh compton-tryone-git arc-gtk-theme paper-icon-theme candy-icons i3lock-fancy
	mkdir -p ~/.config/i3
	cp ~/Projects/dotfiles/i3/config ~/.config/i3/config
	mkdir -p ~/Pictures
	mkdir -p ~/Pictures/Wallpaper
	cp ~/Projects/dotfiles/wallpaper/* ~/Pictures/Wallpaper/
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
	cd ~/Projects/dotfiles/vim
	cp vimrc ~/.vimrc
	chmod 755 installplugins.sh
	./installplugins.sh
fi

yn "utilities and fonts"
read UTILS
if [ $UTILS == "y" ]
then
	sudo pacman -S htop pidgin aspell-en neofetch
	yay -S cava agave nerd-fonts-jetbrains-mono ttf-jetbrains-mono-git
fi

yn "terminals"
read TERMINALS
if [ $TERMINALS == "y" ]
then
	sudo pacman -S xfce4-terminal
	yay -S kitty
	mkdir -p ~/.config/kitty
	cp ~/Projects/dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
fi


yn "xfce4-panel"
read XFCE4PANEL
if [ $XFCE4PANEL == "y" ]
then
	sudo pacman -S xfce4-panel xfce4-goodies
	yay -S network-manager-applet-gtk2 xfce4-i3-workspaces-plugin-git xfce4-pulseaudio-plugin
	sudo cp ~/Projects/dotfiles/arch/icons/* /usr/share/pixmaps/
fi

yn "fish"
read FISH
if [ $FISH == "y" ]
then
	sudo pacman -S fish
	mkdir -p ~/.config/fish
	cp ~/Projects/dotfiles/fish/config.fish ~/.config/fish/config.fish
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

yn "BlackArch"
read BLACKARCH
if [ $BLACKARCH == "y" ]
then
	curl -O https://blackarch.org/strap.sh
	chmod 755 strap.sh
	sudo ./strap.sh
	rm -i strap.sh
fi

yn "Bluetooth Support"
read BLUETOOTH
if [ $BLUETOOTH == "y" ]
then
	sudo pacman -S bluez bluez-utils blueman
fi
