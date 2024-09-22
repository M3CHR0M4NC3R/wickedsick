local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local usersettings = {}
usersettings.titlebars_enabled = true
usersettings.colorscheme = require('theme.colors.catppuccin-frappe')
--this value should be between 0 and 1
local opacity = .8
usersettings.opacity = string.format("%x", math.floor(opacity * 255))
usersettings.fontstyle = "JetBrains Mono, Symbols Nerd Font Mono,Noto Sans Mono CJK JP, Noto Sans Mono CJK TC, Regular, Noto Sans"
usersettings.gap = dpi(5)
usersettings.border = 3
usersettings.corner_radius = 16

usersettings.fontsize = tostring(12)


return usersettings
