local awful = require'awful'
local beautiful = require'beautiful'
local wibox = require'wibox'

local vars = require'config.vars'
local widgets = require'widgets'
local freedesktop = require("modules.freedesktop")

--screen.connect_signal('request::wallpaper', function(s)
--   awful.wallpaper{
--      screen = s,
--      widget = {
--         {
--            --image     = beautiful.wallpaper,
--            image = '/home/sam/Pictures/wallpapers/Anime/melty.png',
--            upscale   = true,
--            downscale = true,
--            widget    = wibox.widget.imagebox,
--         },
--         valign = 'center',
--         halign = 'center',
--         tiled = false,
--         widget = wibox.container.tile,
--      }
--
--   }
--end)

screen.connect_signal('request::desktop_decoration', function(s)
   awful.tag(vars.tagnames, s, vars.taglayouts)
   s.promptbox = widgets.create_promptbox()
   s.layoutbox = widgets.create_layoutbox(s)
   s.taglist   = widgets.create_taglist(s)
   s.tasklist  = widgets.create_tasklist(s)
   s.wibox_top     = widgets.create_wibox_top(s)
   s.wibox_bottom     = widgets.create_wibox_bottom(s)
end)
