#!/bin/bash

#ln -sf ~/dotfiles/.bashrc ~/.bashrc

# i3
ln -sf /home/$USER/git/arch/files/i3/configWork /home/$USER/.config/i3/config

# i3blocks
mkdir -p /home/$USER/.config/i3/scripts
ln -f /home/$USER/git/arch/files/i3/i3blocks/i3blocks.conf /home/$USER/.config/i3/i3blocks.conf
ln -f /home/$USER/git/arch/files/i3/i3blocks/battery /home/$USER/.config/i3/scripts/battery
ln -f /home/$USER/git/arch/files/i3/i3blocks/lock /home/$USER/.config/i3/scripts/lock
