#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

export XDG_SESSION_TYPE=x11

## start some nice programs
# restores the old bg
exec ~/.fehbg &
exec eww daemon &

# audio bc its kinda janky sometimes
exec pulseaudio --start &

# keyboard bindings
# disable for some wms
#exec sxhkd &

# mpd music stuff
exec mpd --stdout --no-daemon &
exec mpdscribble &

# bookmarks page
exec python3 -m http.server --directory Documents/Dev/startpage &

# compositor - disable for compositor+wms
exec picom --experimental-backends &

# changes mouse cursor to be an actual cursor instead of an X lol
exec xsetroot -cursor_name left_ptr &

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#setxkbmap -option caps:swapescape

#export DESKTOP_SESSION=openbox
#exec openbox-session

#export DESKTOP_SESSION=fvwm3
#exec fvwm3

#export DESKTOP_SESSION=plasma
#exec startplasma-x11

#export DESKTOP_SESSION=xfwm4
#exec xfwm4 --compositor=on

#exec startxfce4

export DESKTOP_SESSION=herbstluftwm
exec herbstluftwm

#export DESKTOP_SESSION=openbox
#exec openbox

#exec /home/sp/Documents/Dev/wm/wm

#export DESKTOP_SESSION=monsterwm
#exec monsterwm

#export DESKTOP_SESSION=sowm
#exec sowm

#export DESKTOP_SESSION=cinnamon
#exec cinnamon-session
