#!/bin/bash
#set -e
#
# A script to automate personal package install on ArchLabs
# Written by Michael Carter
# Last updated: Aug 15 2020
#
# Some ideas and code adapted from other sources
# Credit and acknowledgment to ArchLabs installer, 
# ArcoLinuxD scripts, and the Arch Wiki

# Define tput_menu
BOLD="$(tput bold)"
FG_RED="$(tput setaf 1)"
FG_GREEN="$(tput setaf 2)"
FG_YELLOW="$(tput setaf 3)"
FG_BLUE="$(tput setaf 4)"
FG_MAGENTA="$(tput setaf 5)"
FG_CYAN="$(tput setaf 6)"


# user packages {
typeset -a USER_PKGS=(
"adobe-source-sans-pro-fonts"
"adobe-source-serif-pro-fonts"
"archlabs-i3lock-fancy"
"biber"
#"calcurse"
"dmenu"
"engrampa"
"firefox"
"flameshot"
"fzf"
"gcc-fortran"
"gnome-disk-utility"
"gpick"
"gvfs-smb"
"hugo"
"hunspell-en_CA"
"hunspell-en_US"
"inkscape"
"julia"
"libgit2"
"libreoffice-fresh"
#"maim"
"mpv"
#"numlockx"
"openblas"
#"pandoc"
#"pandoc-citeproc"
#"pandoc-crossref"
"papirus-icon-theme"
#"plank"
"playerctl"
"pulsemixer"
"python-pip"
"python-psutil"
"python-setproctitle"
"python-pyxdg"
"qt5ct"
"r"
#"ranger"
#"sxiv"
"texlive-bibtexextra"
"texlive-bin"
"texlive-core"
"texlive-fontsextra"
"texlive-formatsextra"
"texlive-latexextra"
"texlive-publishers"
"texmaker"
#"thunar-media-tags-plugin"
"ttf-jetbrains-mono"
"tk"
#"viewnior"
#"vifm"
"xcb-util-cursor"
"xreader"
#"zathura"
#"zathura-pdf-mupdf"
#"zsh"
#"zsh-autosuggestions"
#"zsh-completions"
#"zsh-history-substring-search"
#"zsh-syntax-highlighting"
) # }

# printing supporting {
typeset -a PRINT_PKGS=(
"cups"
"cups-pdf"
"cups-pk-helper"
"ghostscript"
"gsfonts"
"gutenprint"
"hplip"
#"foomatic-db"
#"foomatic-db-gutenprint-ppds"
#"python-gobject"
#"python-pyqt5"
#"python-pysmbc"
#"python-reportlab"
"simple-scan"
"system-config-printer"
) # }


# bluetooth packages
typeset -a BLUE_PKGS=(
"pulseaudio-bluetooth"
"bluez"
"bluez-libs"
"bluez-utils"
"blueberry"
) # }


# Prompt user about updating system and then to continue
# with installation packages or not
echo
read -r -p "Check for updates? [Y/n] " input
case $input in
        [yY])
    echo
    echo ${FG_CYAN} "Checking for updates..."
    echo
    tput sgr0; sudo pacman -Syu  
    ;;
        [nN])
    ;;
esac


# Install package arrays

read -r -p "Install user packages? [(Y)es/(S)kip/(C)ancel] " input
echo
case $input in
        [yY])
    echo
    sudo pacman -S ${USER_PKGS[*]} --noconfirm --needed
    echo
    ;;
        [sS])
    ;;
        [cC])
    exit
    ;;
esac



read -r -p "Install printing support? [(Y)es/(S)kip/(C)ancel] " input
echo
case $input in
        [yY])
    echo
    sudo pacman -S ${PRINT_PKGS[*]} --noconfirm --needed
    sudo systemctl enable --now org.cups.cupsd.socket
    echo
    ;;
        [sS])
    ;;
        [cC])
    exit
    ;;
esac


read -r -p "Install bluetooth? [(Y)es/(S)kip/(C)ancel] " input
echo
case $input in
        [yY])
    echo
    sudo pacman -S ${USER_PKGS[*]} --noconfirm --needed
    sudo systemctl enable --now bluetooth.service
    sudo sed -i 's/'#AutoEnable=false'/'AutoEnable=true'/g' /etc/bluetooth/main.conf
    echo
    ;;
        [sS])
    ;;
        [cC])
    exit
    ;;
esac

# Enable TRIM support for SSD
sudo systemctl enable --now fstrim.timer

# Create directories
mkdir -pv ~/.r/libs
mkdir -pv ~/AUR

# Clone aur repos
#git clone



echo ${BOLD}
echo "----------------------------------------------"
echo "----       INSTALLATION IS COMPLETE       ----"
echo "----------------------------------------------"
echo
read -r -p "Would you like to reboot to finalize installation? [(Y)es/(N)o] " input
echo
case $input in
        [yY])
    echo ${FG_MAGENTA} "Rebooting in...";tput sgr0
    echo "3"
    sleep 1
    echo "2"
    sleep 1
    echo "1"
    sleep 1
    systemctl reboot
    echo
    tput sgr0
    ;;
    [nN])
    echo    
    echo ${BOLD}${FG_RED} "Exiting in...";tput sgr0
    echo "3"
    sleep 1
    echo "2"
    sleep 1
    echo "1"
    sleep 1
    exit
    ;;
esac








