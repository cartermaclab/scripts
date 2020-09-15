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


# Define versions for downloads using wget in this strip
RSTUDIO_VER=1.3.1091
JBMONO_VER=2.001
TILIX_VER=1.9.3


echo
read -r -p "Have you verified contents of the script? [Y/n] " input
case $input in
        [yY])
    echo
    echo "Installing pop_pkgs..."
    echo
    tput sgr0; sudo pacman -Syu  
    ;;
        [nN])
    exit
    ;;
esac


# Check for updates
echo "Checking for updates..."
sudo apt update && sudo apt upgrade -y

# Setup for current version of R
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/'

# Setup for Brave Browser
sudo apt install apt-transport-https curl -y
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -

echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

# Update package lists
echo "Updating package lists..."
sudo apt update

# List of repo packages to install on fresh Pop!_OS installation {
typeset -a REPO_PKGS=(
"biber"
"brave-browser"
"ffmpeg"
"gir1.2-gtop-2.0"
"gnome-tweaks"
"gpick"
"imagemagick"
"libcairo2-dev"
"libcurl4-openssl-dev"
"libfontconfig1-dev"
"libgit2-dev"
"libgmp-dev"
"libgsl-dev"
"libmagick++-dev"
"libmpfr-dev"
"libnode-dev"
"libopenblas-dev"
"libpoppler-cpp-dev"
"libssl-dev"
"libxml2-dev"
"libxt-dev"
"lm-sensors"
"r-base"
"synaptic"
"texlive-base"
"texlive-bibtex-extra"
"texlive-binaries"
"texlive-fonts-extra"
"texlive-formats-extra"
"texlive-latex-extra"
"texlive-publishers"
"wget"
"zsh"
) # }


# List of flatpaks to install on fresh Pop!_OS installation {
typeset -a FLATPAKS=(
"com.microsoft.Teams"
"com.obsproject.Studio"
"com.slack.Slack"
"com.spotify.Client"
"com.visualstudio.code"
"net.xm1math.Texmaker"
"org.blender.Blender"
"org.inkscape.Inkscape"
"org.jamovi.jamovi"
"us.zoom.Zoom"
) # }

# Install lists
sudo apt install ${REPO_PKGS[*]} -y
flatpak install flathub ${FLATPAKS[*]} -y

# Refresh font cache to fix jamovi plot problem
flatpak run --command=fc-cache org.jamovi.jamovi -f -v

# Download RStudio Preview
wget -P ~/Downloads/ https://s3.amazonaws.com/rstudio-ide-build/desktop/bionic/amd64/rstudio-${RSTUDIO_VER}-amd64.deb

# Download JetBrains Mono font
wget -P ~/Downloads/ https://download.jetbrains.com/fonts/JetBrainsMono-${JBMONO_VER}.zip
#unzip ~/Downloads/JetBrainsMono-2.001.zip
#rm -r ~/Downloads/JetBrainsMono-2.001/web/
#mkdir -pv ~/.local/share/fonts
#mv ~/Downloads/JetBrainsMono-2.001/ ~/.local/share/fonts
#unzip ~/Downloads/JetBrainsMono-2.001.zip -d ~/.local/share/fonts
#fc-cache -f -v

# Download current Hugo version
wget -P ~/Downloads/ https://github.com/gohugoio/hugo/releases/download/v0.74.3/hugo_0.74.3_Linux-64bit.deb

# Download current Tilix
wget -P ~/Downloads/ https://github.com/gnunn1/tilix/releases/download/${TILIX_VER}/tilix.zip

# Download current Miniconda
wget -P ~/Downloads/ https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

# Change shell to zsh
echo
echo "Changing shell to zsh"
chsh -s $(which zsh)

# Exit
echo
echo "Installation of pop_pkgs completed succesfully."
sleep 2
echo "Exiting..."
sleep 1
exit 0


