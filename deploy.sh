#!/bin/bash
yn () {
	echo -e "\n\n---------------[ \e[34m$1\e[0m ] ---------------"
	echo -e  "Install \e[33m$1\e[0m?"
	echo -n -e "[\e[32my\e[0m/\e[31mn\e[0m] > "
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
	sudo pacman -S ntfs-3g ffmpegthumbnailer gst-libav gst-plugins-base gst-plugins-good network-manager-applet dnsutils inetutils nmap pavucontrol core/less arp-scan --noconfirm
fi

yn "replace pulseaudio with pipewire/easyeffects (recommended)?"
read PIPEWIRE
if [ $PIPEWIRE == "y" ]
then
	#sudo pacman -Rdd pulseaudio --noconfirm
	sudo pacman -S pipewire-{jack,alsa,pulse} --noconfirm
	sudo pacman -S easyeffects --noconfurm
	systemctl --user enable --now pipewire pipewire-pulse wireplumber pipewire-alsa pipewire-jack
	systemctl --user enable pipewire.socket pipewire-pulse.socket wireplumber.service
fi

yn "Install Easyeffects?"
read EASYEFFECTS
if [ $EASYEFFECTS == "y" ]
then
	sudo pacman -S easyeffects lsp-plugins --noconfirm
	#yay -S linux-studio-bin --noconfirm
fi


yn "gnome extras"
read GNOMEEXTRAS
if [ $GNOMEEXTRAS == "y" ]
then
	sudo pacman -S gnome-extras --noconfirm
fi

yn "firefox"
read FIREFOX
if [ $FIREFOX == "y" ]
then
	sudo pacman -S firefox --noconfirm
fi

yn "base-devel"
read BASEDEVEL
if [ $BASEDEVEL == "y" ]
then
	sudo pacman -S base-devel go rustup --noconfirm
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
	sudo pacman -S vlc vlc-plugins-all rhythmbox audacious audacious-plugin --noconfirm
	yay -S tauon-music-box --noconfirm
fi


yn "design tools":
read DESIGNTOOLS
if [ $DESIGNTOOLS == "y" ]
then
	sudo pacman -S gimp blender krita --noconfirm
	yay -S aseprite --noconfirm
fi


yn "keepassxc"
read KEEPASSXC
if [ $KEEPASSXC == "y" ]
then
	sudo pacman -S keepassxc --noconfirm
fi

#printf "Clone dotfiles [y/n]"
yn "dotfiles"
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
	sudo pacman -S i3 xorg dmenu lxappearance rofi --noconfirm
	yay -S feh picom i3lock-fancy --noconfirm
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
	yay -S arc-gtk-theme material-black-colors-theme graphite-gtk-theme nordic-theme candy-icons yaru-colors-icon-theme yaru-colors-wallpapers yaru-colors-gtk-theme --noconfirm
fi

yn "Stacer"
read STACER
if [ $STACER == "y" ]
then
	yay -S stacer --noconfirm
fi

yn "Virtualbox"
read VIRTUALBOX
if [ $VIRTUALBOX == "y" ]
then
	yay -S virtualbox linux-headers virtualbox-host-modules-arch virtualbox-guest-utils --noconfirm
	sudo pacman -S qemu edk2-ovmf
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
	# 86 cava and agave
	sudo pacman -S htop aspell-en hunspell-en_us fastfetch numlockx nerd-fonts ttf-roboto --noconfirm
	yay -S nerd-fonts-jetbrains-mono ttf-jetbrains-mono-git --noconfirm
	#fastfetch --gen-config
	mkdir -p ~/.config/fastfetch
	cp defaults/config.jsonc ~/.config/fastfetch/config.jsonc
fi	

yn "terminals"
read TERMINALS
if [ $TERMINALS == "y" ]
then
	sudo pacman -S xfce4-terminal --noconfirm
	yay -S kitty --noconfirm
	mkdir -p ~/.config/kitty
	cp ~/Projects/motelnine/dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
fi


yn "xfce4-panel"
read XFCE4PANEL
if [ $XFCE4PANEL == "y" ]
then
	sudo pacman -S xfce4-panel xfce4-goodies xfce4-battery-plugin network-manager-applet --noconfirm
	yay -S network-manager-applet-gtk2 xfce4-i3-workspaces-plugin-git xfce4-pulseaudio-plugin --noconfirm
	sudo cp ~/Projects/motelnine/dotfiles/arch/icons/* /usr/share/pixmaps/
fi

yn "Golang Dev Tools"
read GOLANG
if [ "$GOLANG" == "y" ]
then
	yay -S golangci-lint-bin --noconfirm
fi

yn "Python Dev Tools"
read PYTHON
if [ $PYTHON == "y" ]
then
	sudo pacman -S python --noconfirm
	yay -S python-pylint python-psycopg2 python-pandas python3-numpy --noconfirm
fi

yn "Dbeaver"
read DBEAVER
if [ $DBEAVER == "y" ]
then
	yay -S dbeaver --noconfirm
fi

yn "Javascript Dev Tools"
read "JAVASCRIPT"
if [ "$JAVASCRIPT" == "y" ]
then
	sudo pacman -S nodejs npm npx yarn --noconfirm
	yay -S nodejs-jslinter jslint --noconfirm
fi

yn "fish"
read FISH
if [ $FISH == "y" ]
then
	sudo pacman -S fish fisher --noconfirm
	mkdir -p ~/.config/fish
	cp ~/Projects/motelnine/dotfiles/fish/config.fish ~/.config/fish/config.fish
	fisher install edc/bass
fi

yn "lxdm-themes"
read LXDM
if [ $LXDM == "y" ]
then
	yay -S lxdm-themes --noconfirm
fi

yn "xfce4-i3-workspaces-plugin-git"
read SWITCHER
if [ $SWITCHER == "y" ]
then
	yay -S xfce4-i3-workspaces-plugin-git --noconfirm
fi

yn "ckb-next"
read CKBNEXT
if [ $CKBNEXT == "y" ]
then
	yay -S ckb-next --noconfirm
	sudo systemctl enable ckb-next-daemon
	sudo systemctl start ckb-next-daemon
fi

yn "Alfa Network Wifi Driver (yay)"
read ALFAWIFI
if [ $ALFAWIFI == "y" ]
then
	#yay -S rtl8812au-dkms-git --noconfirm
	yay -S rtl8812au-aircrack-dkms --noconfirm
fi


yn "Power Management (tlp)"
read POWMAN
if [ $POWMAN == "y" ]
then
	sudo pacman -S tlp tlp-rdw powertop acpi
	sudo systemctl enable tlp
	sudo systemctl start tlp
fi


yn "Surface addons"
read SURFACE
if [ $SURFACE == "y" ]
then
	sudo pacman -S iw --noconfirm
	sudo pacman -S xf86-input-synaptic --noconfirm
fi

yn "Nvidia"
read NVIDIA 
if [ $NVIDIA == "y" ]
then
	sudo pacman -S nvidia nvidia-utils nvidia-settings lib32-nvidia-utils --noconfirm
fi

yn "Pulse/Alsa 32 Bit"
read PULSE
if [ $PULSE == "y" ]
then
	sudo pacman -S lib32-alsa-plugins lib32-libpulse lib32-openal --noconfirm
fi

yn "Sway"
read SWAY
if [ $SWAY == "y" ]
then
	sudo pacman -S sway waybar wofi
fi

#yn "Browser/Gaming Libraries"
#read LIBVA
#if [ $LIBVA == "y" ]
#then
#	sudo pacman -S libva lib32-libva lib32-gnutls lib32-libldap lib32-libgpg-error lib32-sqlite lib32-libpulse
#fi

yn "NetTools"
read NETTOOLS
if [ $NETTOOLS == "y" ]
then
	sudo pacman -S net-tools whois wireshark-qt inetutils --noconfirm
fi

yn "Cherry Tree"
read CHERRYTREE
if [ $CHERRYTREE == "y" ]
then
	sudo pacman -S cherrytree --noconfirm
fi

yn "Remmina"
read REMMINA
if [ $REMMINA == "y" ]
then
	sudo pacman -S remmina parcellite xdotool --noconfirm
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
	sudo pacman -S bluez bluez-utils blueman --noconfirm
fi

yn "Red Team Tools"
read REDTEAM
if [ $REDTEAM == "y" ]
then
	sudo pacman -S extra/exploitdb npm metasploit nikto extra/exploitdb gnu-netcat hashcat hydra --noconfirm
	yay -S theharvester-git python-playwright burpsuite nessus burpsuite aircrack-ng python-shodan --noconfirm
	# yay -S ghidra-desktop
	echo "\n\nNote: you may need to manually install blackarch/hash-identifier or use blackarch repo\n\n"
	# blackarch/wifiphisher
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
	yay -S digimend-kernel-drivers-dkms xorg-xinput --noconfirm
	echo "Done.\nSee: util/generic-tablet-setup.sh"
fi


