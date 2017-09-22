#!/bin/sh
xrdb ~/.Xresources
xrdb -merge ~/.Xdefaults
if [ -s ~/.Xmodmap ]; then
  xmodmap ~/.Xmodmap
fi
xset +dpms
xset dpms 0 0 300
eval $(ssh-agent)
pgrep redshift &> /dev/null || redshift &> /dev/null &
exec awesome
#exec xmonad
#exec $1
