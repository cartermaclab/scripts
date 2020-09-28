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
SLACK=4.9.1
VSCODE=1.49.2
ZOOM=5.3.465578.0920
TEAMS=1.3.00.16851
TEXMAKER=5.0.4
RSTUDIO=1.3.1093
JBMONO=2.002
HUGO=0.75.1
TILIX=1.9.3

echo
read -r -p "Have you verified contents of the script? [Y/n] " input
case $input in
        [yY])
    echo
    echo "Checking for and installing any updates..."
    echo
    sudo apt update && sudo apt upgrade -y
    ;;
        [nN])
    exit
    ;;
esac

# Setup for current version of R
echo
echo "Adding keys for current version of R"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/'

# Setup for Brave Browser
echo
echo "Adding dependencies and key for Brave"
sudo apt install apt-transport-https curl -y
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

# Update package lists
echo
echo "Updating package lists..."
sudo apt update

# List of repo packages to install on fresh Pop!_OS installation {
typeset -a REPO_PKGS=(
"biber"
"brave-browser"
"ffmpeg"
"flameshot"
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
"mpv"
"python3-nautilus"
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
#"com.microsoft.Teams"
"com.obsproject.Studio"
#"com.slack.Slack"
#"com.spotify.Client"
#"com.visualstudio.code"
"org.blender.Blender"
#"org.octave.Octave"
"org.inkscape.Inkscape"
"org.jamovi.jamovi"
"uk.co.ibboard.cawbird"
#"us.zoom.Zoom"
) # }

# Install lists
echo
echo "Installing packages from repository"
sudo apt install ${REPO_PKGS[*]} -y
echo
echo "Installing flatpaks from flathub"
flatpak install flathub ${FLATPAKS[*]} -y

# Refresh font cache to fix jamovi plot problem
flatpak run --command=fc-cache org.jamovi.jamovi -f -v

# Download some packages
mkdir -pv packages
echo
echo "Downloading some packages"
echo
# Download Slack
echo
echo "Downloading Slack..."
wget -P ~/packages/ https://downloads.slack-edge.com/linux_releases/slack-desktop-${SLACK}-amd64.deb

# Download VSCode
echo
echo "Downloading VSCode..."
wget -P ~/packages/ https://update.code.visualstudio.com/${VSCODE}/linux-deb-x64/stable

# Download Zoom
echo
echo "Downloading Zoom..."
wget -P ~/packages/ https://zoom.us/client/${ZOOM}/zoom_amd64.deb

# Download Teams
echo
echo "Downloading MS Teams..."
wget -P ~/packages/ https://packages.microsoft.com/repos/ms-teams/pool/main/t/teams/teams_${TEAMS}_amd64.deb

# Download Texmaker
echo
echo "Downloading Texmaker..."
wget -P ~/packages/ https://www.xm1math.net/texmaker/assets/files/texmaker_${TEXMAKER}_ubuntu_20_04_amd64.deb

# Download RStudio
echo
echo "Downloading RStudio..."
wget -P ~/packages/ https://download1.rstudio.org/desktop/bionic/amd64/rstudio-${RSTUDIO}-amd64.deb

# Download JetBrains Mono font
echo
echo "Downloading JetBrains Mono..."
wget -P ~/packages/ https://github.com/JetBrains/JetBrainsMono/releases/download/v${JBMONO}/JetBrainsMono-${JBMONO}.zip

# Download current Hugo version
echo
echo "Downloading Hugo..."
wget -P ~/packages/ https://github.com/gohugoio/hugo/releases/download/v${HUGO}/hugo_${HUGO}_Linux-64bit.deb

# Download current Tilix
echo
echo "Downloading Tilix..."
wget -P ~/packages/ https://github.com/gnunn1/tilix/releases/download/${TILIX}/tilix.zip

# Download current Miniconda
echo
echo "Downloading Miniconda..."
wget -P ~/packages/ https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

# Download antigen for zsh
echo
echo "Downloading Antigen..."
curl -L git.io/antigen > antigen.zsh

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
