# Install dependencies
sudo apt install build-essential
sudo apt install git
sudo apt install python3-pip
sudo apt install meson


# Wlroots
sudo apt install libwlroots-0.18


# x11 support
sudo apt install libxcb-composite0-dev \
  libxcb-icccm4-dev \
  libxcb-image0-dev \
  libxcb-render0-dev \
  libxcb-xfixes0-dev \
  libxkbcommon-dev \
  libxcb-xinput-dev \
  libx11-xcb-dev


# Get sway dependencies
sudo apt install libjson-c-dev \
  libpango1.0-dev \
  libcairo2-dev \
  libgdk-pixbuf2.0-dev \
  scdoc


# Get sway and its goodies
sudo apt install sway foot-themes sway-backgrounds swayidle swaylock xdg-desktop-portal-wlr alacritty ulauncher


# Create and populate sway launch file
sudo mkdir -p /usr/local/share/wayland-sessions
sudo touch /usr/local/share/wayland-sessions/sway.desktop

sudo tee -a /usr/local/share/wayland-sessions/sway.desktop <<'EOF'
[Desktop Entry]
Name=Sway
Comment=An i3-compatible Wayland compositor
Exec=sway
Type=Application
EOF


# Create and link sway config file
mkdir -p ~/.config/sway/
touch ~/.config/sway/config
ln -s ~/.dotfiles/sway/config ~/.config/sway/config


# Create and link the sway wallpaper directory
mkdir -p ~/.config/sway/data/backgrounds/
ln ~/.dotfiles/sway/data/backgrounds/* ~/.config/sway/data/backgrounds
