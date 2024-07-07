local usersettings = {}
usersettings.colorscheme = require('theme.colors.catppuccin-frappe')
--this value should be between 0 and 1
local opacity = .6
usersettings.opacity = string.format("%x", math.floor(opacity * 255))
usersettings.fontstyle = "JetBrains Mono, Symbols Nerd Font Mono, Noto Sans Mono CJK Regular"

usersettings.fontsize = tostring(12)


return usersettings
