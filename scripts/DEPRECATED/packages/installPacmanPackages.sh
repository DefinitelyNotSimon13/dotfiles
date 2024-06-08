echo "Starting \"installPacmanPackages.sh\" script"
echo "Due to the experimental state of all the scripts, I've opted to add an increaed amount of confirmations (\"Press enter to continue\"). This will be changed (an option added to remove) later."
  
read -p "Press enter to continue"

sudo pacman -S --noconfirm \
  --needed base-devel \
  wayland \
  sddm \
  ttf-jetbrains-mono-nerd \
  kitty \
  alacritty \
  tmux \
  zsh \
  rofi \
  breeze \
  waybar \
  pulseaudio \
  neovim \
  dunst \
  hyprland \
  xdg-desktop-portal-hyprland \
  git \
  polkit \
  qt5-wayland \
  qt6-wayland \
  firefox \
  python \
  python-pip \
  npm \
  hyprpaper \
  cliphist \
  dolphin \
  os-prober \
  qt5-graphicaleffects \
  qt5-svg \
  qt5-quickcontrols2 \
  neofetch \
  papirus-icon-theme \
  mpd \
  btop \
  mc \
  dconf-editor \
  ttf-dejavu \
  nwg-look \
  dconf-editor \
  ddcutil \
  i2c-tools \
  unzip \
  linux-headers \
  pavucontrol \
  networkmanager \
  network-manager-applet \
  pulseaudio \
  cliphist \
  grim \
  qt5ct \
  qt6ct \
  curl \
  lazygit \
  python3 \
  python-gobject \
  pacman-contrib \
  viewnior \
  lynx \
  thunderbird \
  breeze 

echo "\"installPacmanPackages.sh\" script finished!"
echo "If this script was run as part of the full installation process, errors may not have been shown yet, they'll be shown in the next step!"
read -p "Press enter to continue"
