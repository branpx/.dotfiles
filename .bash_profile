#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export QT_QPA_PLATFORMTHEME="qt5ct"

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  startx
fi
