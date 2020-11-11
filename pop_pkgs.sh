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


# Define versions for downloads using wget
TEXMAKER=5.0.4
RSTUDIO=1.4.999
JBMONO=2.200
HUGO=0.78.1
#TILIX=1.9.3

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
#sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
#sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/'

# Update package lists
echo
echo "Updating package lists..."
sudo apt update

# List of repo packages to install on fresh Pop!_OS installation {
typeset -a REPO_PKGS=(
"biber"
"ffmpeg"
"gir1.2-gtop-2.0"
"gnome-sushi"
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
"neovim"
"papirus-icon-theme"
"python3-nautilus"
"qt5ct"
"r-base"
"synaptic"
"tilix"
"texlive-full"
#"texlive-base"
#"texlive-bibtex-extra"
#"texlive-binaries"
#"texlive-fonts-extra"
#"texlive-formats-extra"
#"texlive-latex-extra"
#"texlive-publishers"
"wget"
"zsh"
) # }

# List of flatpaks to install on fresh Pop!_OS installation {
typeset -a FLATPAKS=(
"com.github.tchx84.Flatseal"
"com.microsoft.Teams"
"com.obsproject.Studio"
"com.slack.Slack"
"com.spotify.Client"
"com.visualstudio.code"
"org.blender.Blender"
"org.flameshot.Flameshot"
"org.gnome.Boxes"
"org.gnome.Todo"
"org.inkscape.Inkscape"
"org.jamovi.jamovi"
"org.jaspstats.JASP"
"org.kde.kdenlive"
"uk.co.ibboard.cawbird"
"us.zoom.Zoom"
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
flatpak run --command=fc-cache org.jaspstats.JASP -f -v

# Download some packages
echo
echo "Downloading some packages"
echo

# Download Zoom
#echo
#echo "Downloading Zoom..."
#wget -P ~/Downloads/ https://zoom.us/client/latest/zoom_amd64.deb

# Download Teams
#echo
#echo "Downloading Teams..."
#wget -P ~/Downloads/ https://packages.microsoft.com/repos/ms-teams/pool/main/t/teams/teams_${TEAMS}_amd64.deb

# Download VSCode
#echo
#echo "Downloading VSCode..."
#wget -P ~/Downloads/ https://packages.microsoft.com/repos/vscode/pool/main/c/code/code_${CODE}_amd64.deb

# Download Slack
#echo
#echo "Downloading Slack..."
#wget -P ~/Downloads/ https://downloads.slack-edge.com/linux_releases/slack-desktop-${SLACK}-amd64.deb

# Download Texmaker
echo
echo "Downloading Texmaker..."
wget -P ~/Downloads/ https://www.xm1math.net/texmaker/assets/files/texmaker_${TEXMAKER}_ubuntu_20_10_amd64.deb

# Download RStudio
echo
echo "Downloading RStudio..."
wget -P ~/Downloads/ https://s3.amazonaws.com/rstudio-ide-build/desktop/bionic/amd64/rstudio-${RSTUDIO}-amd64.deb

# Download JetBrains Mono font
echo
echo "Downloading JetBrains Mono..."
wget -P ~/Downloads/ https://github.com/JetBrains/JetBrainsMono/releases/download/v${JBMONO}/JetBrainsMono-${JBMONO}.zip

# Download current Hugo version
echo
echo "Downloading Hugo..."
wget -P ~/Downloads/ https://github.com/gohugoio/hugo/releases/download/v${HUGO}/hugo_${HUGO}_Linux-64bit.deb

# Download current Tilix
#echo
#echo "Downloading Tilix..."
#wget -P ~/Downloads/ https://github.com/gnunn1/tilix/releases/download/${TILIX}/tilix.zip

# Download current Miniconda
echo
echo "Downloading Miniconda..."
wget -P ~/Downloads/ https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

# Update papirus-icon-themes and download papirus-folders
echo
echo "Updating papirus icon theme..."
wget -qO- https://git.io/papirus-icon-theme-install | sh
echo
echo "Downloading papirus folder script..."
wget -qO- https://git.io/papirus-folders-install | sh

# Download antigen for zsh
echo
echo "Downloading Antigen..."
curl -L git.io/antigen > antigen.zsh
mv antigen.zsh ~/.config/

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
