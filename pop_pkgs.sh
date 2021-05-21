#!/bin/bash
#set -e

# -------------------------------------------------------
# A script to automate personal package installation after a fresh
# Pop!_OS installation
#
# Written by Michael Carter
#
# Some ideas and code adapted from other sources, mainly the ArchLabs
# installer (https://www.archlabslinux.com) and the Arch Wiki
#
# -------------------------------------------------------

# Prompt user to check script before proceeding. Some items may require manual
# updating to ensure links reflect the most up-to-date version. This includes
# current version of R from CRAN, RStudio Preview, and JetBrains Mono, etc.

echo
read -r -p "Have you verified contents of the script? [Y/n] " input
case $input in
        [yY])
    ;;
        [nN])
    exit
    ;;
esac

# Setup for current version of R
#echo
#echo "Adding keys for current version of R"
#gpg --keyserver keyserver.ubuntu.com --recv-key E298A3A825C0D65DFD57CBB651716619E084DAB9
#gpg -a --export E298A3A825C0D65DFD57CBB651716619E084DAB9 | sudo apt-key --keyring /etc/apt/trusted.gpg.d/E298A3A825C0D65DFD57CBB651716619E084DAB9.gpg add -
#sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu groovy-cran40/'

# Update package lists
echo
echo "Updating package lists..."
sudo apt update

# List of repo packages to install on fresh Pop!_OS installation {
typeset -a REPO_PKGS=(
"biber"
"code"
"dconf-editor"
"ffmpeg"
"gir1.2-gtop-2.0"
"gnome-sushi"
"gnome-tweaks"
"gpick"
"imagemagick"
"inkscape"
#"libasound2-dev" # related to psychopy
"libcairo2-dev"
"libcurl4-openssl-dev"
"libfontconfig1-dev"
"libgconf-2-4"
"libgit2-dev"
"libgmp-dev"
"libgsl-dev"
"libmagick++-dev"
"libmpfr-dev"
"libnode-dev"
"libopenblas-dev"
"libpoppler-cpp-dev"
"libsecret-1-dev"
"libssl-dev"
#"libusb-1.0-0-dev" # related to psychopy
#"libxml2-dev" # installed by default in Pop!_OS
"libxt-dev"
"lm-sensors"
"mpv"
"neovim"
#"portaudio19-dev" # related to psychopy
"qt5ct"
"r-base"
"synaptic"
"texlive-full"
"zsh"
"zsh-autosuggestions"
"zsh-syntax-highlighting"
) # }

# List of flatpaks to install on fresh Pop!_OS installation {
typeset -a FLATPAKS=(
"com.bitwarden.desktop"
"com.github.tchx84.Flatseal"
#"com.obsproject.Studio"
"com.spotify.Client"
#"org.blender.Blender"
"org.gnome.Boxes"
"org.gnome.GTG"
"org.jamovi.jamovi"
#"org.jaspstats.JASP"
#"org.kde.kdenlive"
#"org.zotero.Zotero"
) # }

# Install lists
echo
echo "Installing packages from repository"
sudo apt install ${REPO_PKGS[*]} -y
echo
echo "Installing flatpaks from flathub"
flatpak install flathub ${FLATPAKS[*]} -y

# Refresh font cache to jamovi
flatpak run --command=fc-cache org.jamovi.jamovi -f -v

# Refresh font cache for jasp
#flatpak run --command=fc-cache org.jaspstats.JASP -f -v

# Update papirus-icon-themes and download papirus-folders
#echo
#echo "Updating papirus icon theme..."
#wget -qO- https://git.io/papirus-icon-theme-install | sh
#echo
#echo "Downloading papirus folder script..."
#wget -qO- https://git.io/papirus-folders-install | sh

# Change shell to zsh
#echo
#echo "Changing shell to zsh"
#chsh -s $(which zsh)

# Exit
echo
echo "Installation of pop_pkgs completed succesfully."
sleep 2
echo "Exiting..."
sleep 1
exit 0
