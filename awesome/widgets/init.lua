local _M = {}

local awful = require'awful'
local beautiful = require'beautiful'
local wibox = require'wibox'
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local menus = require'widgets.menus'
local bars = require'widgets.bars'
local mod = require'bindings.mod'


function _M.create_layoutbox(s)
   return awful.widget.layoutbox{
      screen = s,
      buttons = {
         awful.button{
            modifiers = {},
            button    = 1,
            on_press  = function() awful.layout.inc(1) end,
         },
         awful.button{
            modifiers = {},
            button    = 3,
            on_press  = function() awful.layout.inc(-1) end,
         },
         awful.button{
            modifiers = {},
            button    = 4,
            on_press  = function() awful.layout.inc(-1) end,
         },
         awful.button{
            modifiers = {},
            button    = 5,
            on_press  = function() awful.layout.inc(1) end,
         },
      }
   }
end

function _M.create_taglist(s)
   return awful.widget.taglist{
      screen = s,
      filter = awful.widget.taglist.filter.all,
      buttons = {
         awful.button{
            modifiers = {},
            button    = 1,
            on_press  = function(t) t:view_only() end,
         },
         awful.button{
            modifiers = {mod.super},
            button    = 1,
            on_press  = function(t)
               if client.focus then
                  client.focus:move_to_tag(t)
               end
            end,
         },
         awful.button{
            modifiers = {},
            button    = 3,
            on_press  = awful.tag.viewtoggle,
         },
         awful.button{
            modifiers = {mod.super},
            button    = 3,
            on_press  = function(t)
               if client.focus then
                  client.focus:toggle_tag(t)
               end
            end
         },
         awful.button{
            modifiers = {},
            button    = 4,
            on_press  = function(t) awful.tag.viewprev(t.screen) end,
         },
         awful.button{
            modifiers = {},
            button    = 5,
            on_press  = function(t) awful.tag.viewnext(t.screen) end,
         },
      }
   }
end

function _M.create_tasklist(s)
   return awful.widget.tasklist{
      screen = s,
      filter = awful.widget.tasklist.filter.currenttags,
      --filter   = awful.widget.tasklist.filter.allscreen,
      layout   = {
        spacing = dpi(3),
        layout  = wibox.layout.fixed.horizontal
      },
      buttons = {
         awful.button{
            modifiers = {},
            button    = 1,
            on_press  = function(c)
               c:activate{context = 'tasklist', action = 'toggle_minimization'}
            end,
         },
         awful.button{
            modifiers = {},
            button    = 3,
            on_press  = function() awful.menu.client_list{theme = {width = 250}} end
         },
         awful.button{
            modifiers = {},
            button    = 4,
            on_press  = function() awful.client.focus.byidx(-1) end
         },
         awful.button{
            modifiers = {},
            button    = 5,
            on_press  = function() awful.client.focus.byidx(1) end
         },
      },
      widget_template = {
        {
            {
                {
                    id = 'text_role',
                    widget = wibox.widget.textbox,
                },
                left = dpi(3),
                right = dpi(3),
                widget = wibox.container.margin
            },
            widget = wibox.container.constraint,
            width = dpi(250), -- Fixed width for each tasklist entry
        },
        id = 'background_role',
        widget = wibox.container.background,
      }
   }
end

_M.launcher = awful.widget.launcher{
   image = beautiful.arch_icon,
   menu = menus.main_menu.main_menu
}


_M.menus=menus
_M.bars=bars
return _M
