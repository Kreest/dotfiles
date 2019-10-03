if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  XKB_DEFAULT_LAYOUT=us XKB_CURRENT_DESKTOP=Unity exec sway
fi
