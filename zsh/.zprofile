export PATH="$HOME/.cargo/bin:$HOME/bin/:$PATH"
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  export MOZ_ENABLE_WAYLAND=1
  XKB_DEFAULT_LAYOUT=us XKB_CURRENT_DESKTOP=Unity exec sway
fi
