#!/bin/bash
# Place in ~/.ncmpcpp

# send the notif with notify send.
notify-send -i /tmp/cover.jpg "Now Playing:" "$(mpc current)"
