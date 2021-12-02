export PATH="$HOME/.cargo/bin:$HOME/bin/:$PATH"
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  export MOZ_ENABLE_WAYLAND=1
  export XDG_CURRENT_DESKTOP="sway" 
  XDG_SESSION_DESKTOP=sway XKB_DEFAULT_LAYOUT=us XKB_CURRENT_DESKTOP=Unity exec  dbus-run-session sway
fi
