#!/bin/bash

######################################################################
# country specific things                                            #
######################################################################
# Set the keyboard layout to German
loadkeys de-latin1

# Set the time zone to Switzerland/Zurich
ln -sf /usr/share/zoneinfo/Europe/Zurich /etc/localtime
hwclock --systohc

# Uncomment the locale(s) you want to use in /etc/locale.gen and generate them
sed -i 's/^#de_CH.UTF-8 UTF-8/de_CH.UTF-8 UTF-8/' /etc/locale.gen
locale-gen

# Set the default locale
echo "LANG=de_CH.UTF-8" > /etc/locale.conf

######################################################################
# user prompts                                                       #
######################################################################
# Select username
echo "Please enter your username"
read USER

# Select hostname
echo "Please enter your hostname"
read HOST

# List available disks
lsblk

# Prompt for the partition to install Arch Linux
echo "Please enter the target disk to install Arch Linux (e.g., /dev/sda):"
read target_disk

# Choose DE
echo "Please choose your Desktop Environment (DE)
echo "1. GNOME"
echo "2. KDE"
echo "3. i3"
read Desktop

######################################################################
# make filesystem                                                    #
######################################################################
echo -e "\nCreating Filesystems...\n"

mkfs.vfat -F32 -n "EFISYSTEM" "${EFI}"
mkswap "${SWAP}"
swapon "${SWAP}"
mkfs.ext4 -L "ROOT" "${ROOT}"

# mount target
mount -t ext4 "${ROOT}" /mnt
mkdir /mnt/boot
mount -t vfat "${EFI}" /mnt/boot/

# Update the system clock
timedatectl set-ntp true

######################################################################
# install Arch Linux                                                 #
######################################################################
echo "----------------------------------------------"
echo "-- INSTALLING Arch Linux BASE on Main Drive --"
echo "----------------------------------------------"
pacstrap /mnt base base-devel --noconfirm --needed

# kernel
pacstrap /mnt linux linux-firmware --noconfirm --needed


######################################################################
# setup dependencies                                                 #
######################################################################
echo "--------------------------------------"
echo "-- Setup Dependencies               --"
echo "--------------------------------------"

pacstrap /mnt networkmanager network-manager-applet wireless_tools nano intel-ucode bluez bluez-utils blueman git --noconfirm --needed

# Generate an fstab file
genfstab -U /mnt >> /mnt/etc/fstab

######################################################################
# Desktop Environments (DE)                                          #
######################################################################
if [[ $DESKTOP == '1' ]]
then 
    pacman -S gnome gdm --noconfirm --needed
    systemctl enable gdm
elif [[ $DESKTOP == '2' ]]
then
    pacman -S plasma sddm kde-applications --noconfirm --needed
    systemctl enable sddm
elif [[ $DESKTOP == '3' ]]
then
    pacman -S i3-wm --noconfirm --needed
    systemctl enable sddm


# Change root into the new system
arch-chroot /mnt /bin/bash <<EOF

# Set the root password (change 'your_password' to your desired root password)
echo "root:Passwort" | chpasswd

# Install additional packages (add any packages you want to install here)
pacman -S --noconfirm networkmanager vim

# Enable NetworkManager service
systemctl enable NetworkManager

# Exit the chroot environment
EOF

# Unmount all partitions
umount -R /mnt

# Reboot into the newly installed system
reboot
