#!/bin/bash



# Create .dotfiles folder
mkdir -p "$HOME/.dotfiles"
export DOTFILES_DIR="$HOME/.dotfiles"
mkdir -p "$DOTFILES_DIR"/wallpapers
mkdir -p "$DOTFILES_DIR"/i3-dotfiles
mkdir -p "$DOTFILES_DIR"/alacritty


mkdir -p "$HOME"/.config/alacritty

# Copy files to folder
cp -rf files/wallpapers/* "$DOTFILES_DIR"/wallpapers/
cp -rf files/i3/* "$DOTFILES_DIR"/i3-dotfiles/
cp -rf files/alacritty/* "$DOTFILES_DIR"/alacritty/

# List with programs to install
PROGRAMS=(
    "discord"
    "obsidian"
    "keepassxc"
    "neovim"
    "chromium"
    "flameshot"
    "blueman"
    "alacritty"
    "arandr"
    "autorandr"
    "nextcloud-client"
    #"program"
)

YUBIKEY_PROGRAMS=(
    "yubico-authenticator-bin"
    "yubikey-manager"
    "yubikey-personalization-gui"
)

FONTS=(
    "ttf-firacode"
    "ttf-firacode-nerd"
)

VirtualManager=(
    "qemu"
    "virt-manager"
    "virt-viewer"
    "dnsmasq"
    "vde2"
    "bridge-utils"
    "openbsd-netcat"
    "dmidecode"
    "libguestfs"
)

I3PACKAGES=(
    "i3-wm"
    "xorg"
    "i3status"
    "dmenu"
    "terminator"
    "i3blocks"
    "feh"
    "rofi"
    "picom"
    "polybar"
)

ohmyzsh=(
    "zsh"
    "zsh-completions"
    "zsh-syntax-highlighting"
)

install_ohmyzsh() {
    for program in "${ohmyzsh[@]}"; do
        yay --noconfirm -S "$program" >/dev/null
    done
}

install_PROGRAMS() {
    for program in "${PROGRAMS[@]}"; do
        yay --noconfirm -S "$program" >/dev/null
    done
}

install_YUBIKEY() {
    for program in "${YUBIKEY_PROGRAMS[@]}"; do
        yay --noconfirm -S "$program" >/dev/null
    done
}

install_FONTS() {
    for font in "${FONTS[@]}"; do
        yay --noconfirm -S "$font" >/dev/null
    done
}

install_KVM() {
    for program in "${VirtualManager[@]}"; do
        yay --noconfirm -S "$program" >/dev/null
    done
    sudo systemctl enable --now libvirtd
}

install_I3PACKAGES() {
    for program in "${I3PACKAGES[@]}"; do
        yay --noconfirm -S "$program" >/dev/null
    done
    apply_dotfiles
}

apply_dotfiles() {
    # Copy my i3config files
    cp -rf "$DOTFILES_DIR"/i3-dotfiles/configHome "$HOME"/.config/i3/configHome
    cp -rf "$DOTFILES_DIR"/i3-dotfiles/configWork "$HOME"/.config/i3/configWork
    cp -rf "$DOTFILES_DIR"/i3-dotfiles/configWork "$HOME"/.config/i3/config

    # Copy lightdm-stuff
    sudo cp -rf "$DOTFILES_DIR"/i3-dotfiles/slick-greeter.conf /etc/lightdm/slick-greeter.conf
    sudo cp -rf "$DOTFILES_DIR"/wallpapers/home.jpg /usr/share/pixmaps/lightdm_wallpaper.jpg
  
    # Copy i3block-stuff
    cp -rf "$DOTFILES_DIR"/i3-dotfiles/i3blocks.conf "$HOME"/.config/i3/i3blocks.conf
    cp -rf "$DOTFILES_DIR"/i3-dotfiles/i3blocks/* "$HOME"/.config/i3/scripts/

    # polybar-stuff ##### polybar.sh not executeable #####
    mkdir -p "$HOME"/.config/polybar
    cp -rf "$DOTFILES_DIR"/i3-dotfiles/polybar/polybar.sh "$HOME"/.config/polybar/polybar.sh
    cp -rf "$DOTFILES_DIR"/i3-dotfiles/polybar/* "$HOME"/.config/polybar/

    # Copy alacritty config
    cp -rf "$DOTFILES_DIR"/alacritty/alacritty.toml "$HOME"/.config/alacritty/alacritty.toml
}

#install_PROGRAMS

#install_FONTS

apply_dotfiles