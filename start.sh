#!/bin/bash

DOTFILES_DIR="$HOME/.dotfiles"

# Create .dotfiles folder
mkdir -p "$DOTFILES_DIR"

# Copy files to .dotfiles folder
#cp -r ../arch/* "$DOTFILES_DIR"

# List with programs to install
PROGRAMS=(
    "discord"
    "obsidian"
    "keepassxc"
    "neovim"
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

install_PROGRAMS