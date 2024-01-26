#!/bin/bash

DOTFILES_DIR="$HOME/.dotfiles"

# Create .dotfiles folder
mkdir -p "$DOTFILES_DIR"
mkdir -p "$DOTFILES_DIR"/wallpapers
mkdir -p "$DOTFILES_DIR"/i3-dotfiles

# Copy files to folder
cp -r files/wallpapers/* "$DOTFILES_DIR"/wallpapers
cp -r files/i3/* "$DOTFILES_DIR"/i3-dotfiles


# Copy files to .dotfiles folder
#cp -r ../arch/* "$DOTFILES_DIR"

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
    configure_i3
}

configure_i3() {
    # Copy my i3config files
    cp -r "$DOTFILES_DIR"/i3/configHome "$HOME"/.config/i3/config
    cp -r "$DOTFILES_DIR"/i3/configWork "$HOME"/.config/i3/config

    # Copy lightdm-stuff
    cp -r "$DOTFILES_DIR"/i3/slick-greeter.conf /etc/lightdm/slick-greeter.conf
    cp -r "$DOTFILES_DIR"/wallpapers/home.jpg /usr/share/pixmaps/lightdm_wallpaper.jpg
  
    # Copy i3block-stuff

}

install_PROGRAMS

install_FONTS