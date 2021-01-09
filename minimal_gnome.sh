#!/bin/bash
#set -e

# -------------------------------------------------------
# A script to automate personal package installation after a fresh
# ArchLabs installation
#
# Written by Michael Carter
#
# Some ideas and code adapted from other sources, mainly the ArchLabs
# installer (https://www.archlabslinux.com) and the Arch Wiki
#
# -------------------------------------------------------

# Define tput_menu
BOLD="$(tput bold)"
FG_RED="$(tput setaf 1)"
FG_GREEN="$(tput setaf 2)"
FG_YELLOW="$(tput setaf 3)"
FG_BLUE="$(tput setaf 4)"
FG_MAGENTA="$(tput setaf 5)"
FG_CYAN="$(tput setaf 6)"

# minimal gnome {
typeset -a MIN_GNOME_PKGS=(
"chrome-gnome-shell"
"eog"
"evince"
"file-roller"
"dconf-editor"
"gedit"
"gnome-autoar"
"gnome-bluetooth"
"gnome-calculator"
"gnome-calendar"
"gnome-characters"
"gnome-control-center"
"gnome-disk-utility"
"gnome-icon-theme"
"gnome-keyring"
#"gnome-latex"
"gnome-screenshot"
"gnome-shell-extensions"
"gnome-system-monitor"
"gnome-terminal"
"gnome-todo"
"gnome-tweaks"
"gnome-video-effects"
"gnome-weather"
"gvfs"
"gvfs-smb"
"nautilus"
"networkmanager"
"sushi"
"xdg-user-dirs-gtk"
) # }

# user packages {
typeset -a USER_PKGS=(
#"biber"
"firefox"
#"flameshot"
"flatpak"
"fzf"
"gcc-fortran"
#"gpick"
"hugo"
"hunspell-en_CA"
"hunspell-en_US"
"inkscape"
"julia"
"libgit2"
"libreoffice-fresh"
"mpv"
"nmap"
"noto-fonts"
"noto-fonts-cjk"
"numlockx"
"openblas"
#"pandoc"
#"pandoc-citeproc"
#"pandoc-crossref"
"papirus-icon-theme"
#"playerctl"
"qt5ct"
"r"
"texlive-bibtexextra"
"texlive-bin"
"texlive-core"
"texlive-fontsextra"
"texlive-formatsextra"
"texlive-latexextra"
"texlive-publishers"
#"ttf-jetbrains-mono"
"ttf-joypixels"
"tk"
) # }

# printing supporting {
typeset -a PRINT_PKGS=(
"cups"
"cups-filters"
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

# Install minimal gnome packages
read -r -p "Install minimal gnome packages? [(Y)es/(S)kip/(C)ancel] " input
echo
case $input in
        [yY])
    echo
    sudo pacman -S ${MIN_GNOME_PKGS[*]} --noconfirm --needed
    echo
    ;;
        [sS])
    ;;
        [cC])
    exit
    ;;
esac

# Install user packages
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

# Install printing support
read -r -p "Install printing support? [(Y)es/(S)kip/(C)ancel] " input
echo
case $input in
        [yY])
    echo
    sudo pacman -S ${PRINT_PKGS[*]} --noconfirm --needed
    sudo systemctl enable --now cups.socket
    echo
    ;;
        [sS])
    ;;
        [cC])
    exit
    ;;
esac

# Install bluetooth support
read -r -p "Install bluetooth? [(Y)es/(S)kip/(C)ancel] " input
echo
case $input in
        [yY])
    echo
    sudo pacman -S ${BLUE_PKGS[*]} --noconfirm --needed
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
read -r -p "Enable TRIM support for SSD with fstrim.timer? [(Y)es/(S)kip/(C)ancel] " input
echo
case $input in
        [yY])
    echo
    sudo systemctl enable --now fstrim.timer
    echo
    ;;
        [sS])
    ;;
        [cC])
    exit
    ;;
esac


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
