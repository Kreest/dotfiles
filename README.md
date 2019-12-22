# Dotifles
My dotfiles, using [Parabola Linux](http://https://www.parabola.nu/)  with [sway](http://https://github.com/swaywm/sway).
If you care about the long-term usability of your setup, you should probably consider moving to a wayland-capable environment, it is the [future](https://www.phoronix.com/scan.php?page=news_item&px=X.Org-Maintenance-Mode-Quickly)

Organized using [stow](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html). Run `stow $folder` from inside `~/dotfiles`. This creates symlinks to the configs, and now they can be updated via `git pull`.

Please create backups before trying things out!

| Name           | Stow dir | Dependencies                                         | Details                                          |
| :------------- | :------- | :--------------------------------------------------- | :----------------------------------------------- |
| zsh            | `$HOME`  | zplug                                                | shell                                            |
| vim            | `$HOME`  | vim-plug, YouCompleteMe, cppman                      | text editing                                     |
| termite        | `$HOME`  |                                                      | terminal                                         |
| sway           | `$HOME`  | rofi, grim, mako, amixer, mpc, task, passmenu, clipmenu, networkmanager_dmenu, udiskie, redshift-wlr | wayland compositor
| newsboat       | `$HOME`  | qutebrowser, trans, xclip, umpv+mpv, gvim            | RSS reader
| ncmpcpp        | `$HOME`  | mpd                                                  | mpd client
| ranger         | `$HOME`  |                                                      | file browser
| zathura        | `$HOME`  |                                                      | pdf viewer

i3, polybar and xorg are leftovers from an old config, left here because sometimes I need xorg for vidyas.

| Name           | Stow dir | Dependencies                                         | Details                                          |
| :------------- | :------- | :--------------------------------------------------- | :----------------------------------------------- |
| i3             | `$HOME`  | feh, scrot, rofi, wmctrl, i3lock-color, i3lock-fancy, compton | Window manager                             |
| xorg           | `$HOME`  | xinit, colors, xcape, unclutter, numlockx                         | |
| polybar        | `$HOME`  | | |

# Thanks

[SicariusNoctis](http://github.com/SicariusNoctis/dotfiles), whose reddit posts made me aware of this whole i3 thing, a lot of things here are based on his dotfiles  
[mohlerm](http://github.com/mohlerm/dotfiles) whose display and scrot setup I adopted  
[szorfein](http://github.com/szorfein/dotfiles) current polybar setup is based on his
Any other place that I might have copied scripts and code snippets from, and all the vim plugin creators - you make life hella easy.
