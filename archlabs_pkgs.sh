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

# user packages {
typeset -a USER_PKGS=(
"autorandr"
#"biber"
"brightnessctl"
#"engrampa"
#"evince"
"firefox"
"flatpak"
"fzf"
"gcc-fortran"
#"gnome-disk-utility"
"gpick"
"gvfs-smb"
"hugo"
"hunspell-en_ca"
"hunspell-en_us"
"inkscape"
"julia"
"libgit2"
"libreoffice-fresh"
#"mate-power-manager"
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
"pasystray"
"pavucontrol"
"playerctl"
#"pulsemixer"
"python-pip"
"python-psutil"
"python-setproctitle"
"python-pyxdg"
"python-wheel"
"qt5ct"
"r"
"rofi"
#"sxhkd"
"texlive-bibtexextra"
"texlive-bin"
"texlive-core"
"texlive-fontsextra"
"texlive-formatsextra"
"texlive-latexextra"
"texlive-publishers"
"ttf-jetbrains-mono"
"ttf-joypixels"
"tk"
#"vifm"
"xcb-proto"
"xcb-util"
"xcb-util-keysyms"
"xcb-util-cursor"
"xcb-util-wm"
#"xreader"
#"zathura"
#"zathura-pdf-mupdf"
"zsh"
"zsh-autosuggestions"
"zsh-completions"
"zsh-syntax-highlighting"
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
"bluez-utils"
#"blueberry"
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

# Exit
echo
echo "Installation completed succesfully."
sleep 2
echo "Exiting..."
sleep 1
exit 0
