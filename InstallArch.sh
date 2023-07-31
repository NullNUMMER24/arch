#!/bin/bash

# Set the keyboard layout to German
loadkeys de-latin1

# List available disks
lsblk

# Prompt for the partition to install Arch Linux
echo "Please enter the target disk to install Arch Linux (e.g., /dev/sda):"
read target_disk

# Verify internet connectivity
ping -c 3 archlinux.org || (echo "No internet connection. Please check your network." && exit 1)

# Update the system clock
timedatectl set-ntp true

# Partition the disk
parted "$target_disk" mklabel gpt
parted "$target_disk" mkpart primary ext4 1MiB 100%
mkfs.ext4 "${target_disk}1"
mount "${target_disk}1" /mnt

# Update the mirrorlist (optional, you can skip this if you want to use the default mirrorlist)
curl -o /etc/pacman.d/mirrorlist "https://archlinux.org/mirrorlist/all/"
sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist
grep -A 1 "Switzerland" /etc/pacman.d/mirrorlist | grep -v "#" > /etc/pacman.d/mirrorlist.tmp
rankmirrors -n 6 /etc/pacman.d/mirrorlist.tmp > /etc/pacman.d/mirrorlist
rm /etc/pacman.d/mirrorlist.tmp

# Install the base system
pacstrap /mnt base linux linux-firmware

# Generate an fstab file
genfstab -U /mnt >> /mnt/etc/fstab

# Change root into the new system
arch-chroot /mnt /bin/bash <<EOF

# Set the time zone to Switzerland/Zurich
ln -sf /usr/share/zoneinfo/Europe/Zurich /etc/localtime
hwclock --systohc

# Uncomment the locale(s) you want to use in /etc/locale.gen and generate them
sed -i 's/^#de_CH.UTF-8 UTF-8/de_CH.UTF-8 UTF-8/' /etc/locale.gen
locale-gen

# Set the default locale
echo "LANG=de_CH.UTF-8" > /etc/locale.conf

# Set the hostname (change 'myhostname' to your desired hostname)
echo "code" > /etc/hostname

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
