#!/bin/bash
yn () {
	printf "Install '$1' [y/n] "
}

echo "Creating ~/Downloads"
mkdir -p ~/Downloads

echo "Creating ~/Development"
mkdir -p ~/Development

yn "firefox"
read FIREFOX
if [ $FIREFOX == "y" ]
then
	sudo pacman -S firefox
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
	git clone https://github.com/motelnine/dotfiles ~/Development/dotfiles
fi

yn "i3-gaps"
read I3GAPS
if [ $I3GAPS == "y" ]
then
	sudo pacman -S dmenu lxappearance
	yay -S i3-gaps feh compton-tryone-git arc-gtk-theme paper-icon-theme
	mkdir -p ~/.config/i3
	cp ~/Development/dotfiles/i3/config ~/.config/i3/config
	mkdir -p ~/Pictures
	mkdir -p ~/Pictures/Wallpaper
	cp ~/Development/dotfiles/wallpaper/* ~/Pictures/Wallpaper/
fi

yn "vim plugins"
read VIM
if [ $VIM == "y" ]
then
	sudo pacman -S wget
	cd ~/Development/dotfiles/vim
	cp vimrc ~/.vimrc
	chmod 755 installplugins.sh
	./installplugins.sh
fi

yn "utilities and fonts"
read UTILS
if [ $UTILS == "y" ]
then
	sudo pacman -S htop pidgin aspell-en neofetch
	yay -S cava agave nerd-fonts-jetbrains-mono
fi

yn "terminals"
read TERMINALS
if [ $TERMINALS == "y" ]
then
	sudo pacman -S xfce4-terminal
	yay -S kitty
	mkdir -p ~/.config/kitty
	cp ~/Development/dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
fi


yn "xfce4-panel"
read XFCE4PANEL
if [ $XFCE4PANEL == "y" ]
then
	sudo pacman -S xfce4-panel xfce4-goodies
	yay -S network-manager-applet-gtk2 xfce4-i3-workspaces-plugin-git xfce4-pulseaudio-plugin
	sudo cp ~/Development/dotfiles/arch/icons/* /usr/share/pixmaps/
fi

yn "fish"
read FISH
if [ $FISH == "y" ]
then
	sudo pacman -S fish
	mkdir -p ~/.config/fish
	cp ~/Development/dotfiles/fish/config.fish ~/.config/fish/config.fish
fi

yn "Surface addons"
read SURFACE
if [ $SURFACE == "y" ]
then
	sudo pacman -S xf86-input-synaptic
fi
