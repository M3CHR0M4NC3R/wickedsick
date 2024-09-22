local awful = require'awful'
require'awful.autofocus'
local wibox = require'wibox'
local gears = require'gears'
local beautiful = require'beautiful'
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
--client.connect_signal('mouse::enter', function(c)
--   c:activate{context = 'mouse_enter', raise = false}
--end)
--rounded corners
client.connect_signal("manage", function (c)
    c.shape = function(cr,w,h)
        gears.shape.rounded_rect(cr,w,h,beautiful.corner_radius)
    end
end)
client.connect_signal("request::manage", function(c)
	if c.maximized then
		c.x = c.screen.workarea.x
		c.y = c.screen.workarea.y
		c.width = c.screen.workarea.width
		c.height = c.screen.workarea.height
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
   awful.titlebar(c, {size=beautiful.titlebar_height,position="left"}).widget = {
   -- Top ---
      {
	      {
            {
               awful.titlebar.widget.closebutton    (c),
               awful.titlebar.widget.maximizedbutton(c),
               awful.titlebar.widget.minimizebutton (c),
               awful.titlebar.widget.stickybutton   (c),
               awful.titlebar.widget.ontopbutton    (c),
               awful.titlebar.widget.floatingbutton (c),
               layout = wibox.layout.fixed.vertical
            },
            layout = wibox.layout.fixed.vertical
         },
	      top = 10,
	      widget = wibox.container.margin,
         },
         {
            buttons = buttons,
            layout = wibox.layout.flex.vertical
         },
	      {
            {
               {
                  --awful.titlebar.widget.iconwidget(c),
		            layout = wibox.layout.align.vertical
               },
               layout = wibox.layout.align.vertical
    	      },
	         bottom = 10,
	         widget = wibox.container.margin,
            },
            layout = wibox.layout.align.vertical
         }
      end)
