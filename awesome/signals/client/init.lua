local awful = require'awful'
require'awful.autofocus'
local wibox = require'wibox'
local gears = require'gears'
local beautiful = require'beautiful'

--client.connect_signal('mouse::enter', function(c)
--   c:activate{context = 'mouse_enter', raise = false}
--end)

--rounded corners
client.connect_signal("manage", function (c)
    c.shape = function(cr,w,h)
        gears.shape.rounded_rect(cr,w,h,0)
    end
end)

client.connect_signal('request::titlebars', function(c)
   -- buttons for the titlebar
   local buttons = {
      awful.button{
         modifiers = {},
         button    = 1,
         on_press  = function()
            c:activate{context = 'titlebar', action = 'mouse_move'}
         end
      },
      awful.button{
         modifiers = {},
         button    = 3,
         on_press  = function()
            c:activate{context = 'titlebar', action = 'mouse_resize'}
         end
      },
   }

   awful.titlebar(c, {size=beautiful.titlebar_height}).widget = {
      -- left
      {
         awful.titlebar.widget.closebutton(c),
         awful.titlebar.widget.maximizedbutton(c),
         awful.titlebar.widget.minimizebutton(c),
         awful.titlebar.widget.ontopbutton(c),
         awful.titlebar.widget.stickybutton(c),
         awful.titlebar.widget.floatingbutton(c),
         layout = wibox.layout.fixed.horizontal()
      },
      -- middle
      {
         -- title
         --{
         --   align = 'center',
         --   widget = awful.titlebar.widget.titlewidget(c),
         --},
         buttons = buttons,
         layout  = wibox.layout.flex.horizontal,
      },
      -- right
      {
         --awful.titlebar.widget.iconwidget(c),
         buttons = buttons,
         layout  = wibox.layout.fixed.horizontal,
      },
      layout = wibox.layout.align.horizontal,
   }
end)

