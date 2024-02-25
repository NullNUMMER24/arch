#!/bin/bash
# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch Polybar, using default config location ~/.config/polybar/config.ini
#-+-+-+-+-#
polybar mainbar --config=$HOME/.config/polybar/polybar_config 2>&1 | tee -a /tmp/polybar.log & disown
polybar secondbar --config=$HOME/.config/polybar/polybar_config 2>&1 | tee -a /tmp/polybar.log & disown


echo "Polybar launched..."
