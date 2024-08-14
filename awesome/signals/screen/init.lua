local awful = require'awful'
local beautiful = require'beautiful'
local wibox = require'wibox'

local vars = require'config.vars'
local widgets = require'widgets'
local gears = require'gears'
local function create_bar_timer_top(s)
   return gears.timer({
      timeout=.25,
      autostart=false,
      callback=function() s.wibox_top.visible=false end,
   })
end
local function create_bar_timer_bottom(s)
   return gears.timer({
      timeout=.25,
      autostart=false,
      callback=function() s.wibox_bottom.visible=false end,
   })
end


screen.connect_signal('request::desktop_decoration', function(s)
   awful.tag(vars.tagnames, s, vars.taglayouts)
   s.layoutbox = widgets.create_layoutbox(s)
   s.taglist   = widgets.create_taglist(s)
   s.tasklist  = widgets.create_tasklist(s)
   --create both bars and their timers
   s.wibox_top = widgets.bars.top_bar.create_wibox_top(s)
   s.top_timer = create_bar_timer_top(s)
   s.wibox_bottom = widgets.bars.bottom_bar.create_wibox_bottom(s)
   s.bottom_timer = create_bar_timer_bottom(s)
   --signal catchers; reset timer when mouse re-enters, and disable the bar when the mouse remains gone
   s.wibox_top:connect_signal("mouse::enter", function()
       if s.top_timer.started then
           s.top_timer:stop()
       end
       s.wibox_top.visible = true
   end)
   s.wibox_top:connect_signal("mouse::leave", function()
       s.top_timer:again()
       s.top_timer.callback = function() s.wibar.visible = false end
   end)

   s.wibox_bottom:connect_signal("mouse::enter", function()
       if s.bottom_timer.started then
           s.bottom_timer:stop()
       end
       s.wibox_bottom.visible = true
   end)
   s.wibox_bottom:connect_signal("mouse::leave", function()
       s.bottom_timer:again()
       s.bottom_timer.callback = function() s.wibar.visible = false end
   end)
end)
