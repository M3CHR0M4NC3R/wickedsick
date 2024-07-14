## The most sickest most awesome most wicked config

This repo is meant to house my current progress on a
desktop environment that can be used by your mother
and yourself. Customization is done through a lua
file from the awesome menu.
Style is not consistant throughout, focusing on
features first.

## Window Menu branch
Instead of having window titlebars, I'm moving mouse based window control the
menu bar to save screen space. This raises the issue of moving and resizing
windows with only the mouse though. 
This update also brings some changes to the menubars' information display. I
like having the taglist be pretty symbols so I added a seperate widget that
explicitly states which tag is active.

BUGS:
- ~~menu duplicates if you click the window name multiple times~~
    fixed by generating the menu when focus changes instead of when the widget
    is clicked. This is kinda wasteful, but otherwise it won't be toggleable.
- ~~menu doesn't go away to the shadow realm if you click outside it~~
    fixed on accident by killing existing window menu when a new one is
generated

## Package Requirements
- awesomewm git
- alacritty (terminal)
- ranger (file browser)
- vim
- pcmanfm (file browser)
- rofi (app launcher)
- brillo (brightness)
- picom (see thru terminals)
- zathura (most pretty pdf viewer)

## Awesome Module Requirements
- awesome-switcher
- battery-widget (optional)
- revelation
- lain

## Planned Features
- Control Center Widget
- Settings GUI
- automatic tasklist hiding
- integrating changing desktop wallpaper
