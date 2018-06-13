# Dotifles
My dotfiles, using archlinux with i3wm

Organized using [stow](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html)

Please create backups before trying things out!

| Name           | Stow dir | Dependencies                                         | Details                                          |
| :------------- | :------- | :--------------------------------------------------- | :----------------------------------------------- |
| zsh            | `$HOME`  | zplug | Shell                                            |
| xorg           | `$HOME`  |                                                      | xinit, colors, xcape, unclutter, numlockx                         |
| vim            | `$HOME`  | vim-plug, YouCompleteMe | text editing                                       |
| i3             | `$HOME`  | feh, scrot, rofi, wmctrl, i3lock-color, i3lock-fancy, compton | Window manager                             |
| calculator     | `$HOME`  | sympy, jupyter, ipython, (matplotlib) | Calculator setup        |
| termite        | `$HOME`  |                                                      | Terminal                         |

# Thanks

[SicariusNoctis](http://github.com/SicariusNoctis/dotfiles), whose reddit posts made me aware of this whole i3 thing, a lot of things here are based on his dotfiles
[mohlerm](http://github.com/mohlerm/dotfiles) whose display and scrot setup I adopted
Any other place that I might have copied scripts and code snippets from, and all the vim plugin creators - you make life hella easy.
