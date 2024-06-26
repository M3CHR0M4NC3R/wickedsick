local _M = {}

local awful = require'awful'
local hotkeys_popup = require'awful.hotkeys_popup'
local beautiful = require'beautiful'
local wibox = require'wibox'
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

--import battery widget from external library
local battery_widget = require('modules.battery-widget')

local apps = require'config.apps'
local mod = require'bindings.mod'

_M.awesomemenu = {
   {'hotkeys', function() hotkeys_popup.show_help(nil, awful.screen.focused()) end},
   {'manual', apps.manual_cmd},
   {'edit config', apps.terminal_folder_cmd .. ' .config/awesome '},
   {'restart', awesome.restart},
   {'quit', function() awesome.quit() end},
}

_M.powermenu = {
   {'suspend', 'systemctl suspend'},
   {'shut down', 'shutdown now'},
}

_M.mainmenu = awful.menu{
   items = {
      {'awesome', _M.awesomemenu, beautiful.awesome_icon},
      {'open terminal', apps.terminal},
      {'power', _M.powermenu, beautiful.awesome_icon},
   }
}

_M.launcher = awful.widget.launcher{
   image = beautiful.awesome_icon,
   menu = _M.mainmenu
}

_M.keyboardlayout = awful.widget.keyboardlayout()
_M.textclock      = wibox.widget.textclock('%a %b %d, %I:%M%P')


function _M.create_promptbox() return awful.widget.prompt() end

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
      layout   = {
        spacing = dpi(5),
        layout  = wibox.layout.fixed.horizontal
      },
      --widget_template = {
      --  {
      --      {
      --          {
      --              id     = "text_role",
      --              widget = wibox.widget.textbox,
      --          },
      --          layout = wibox.layout.fixed.horizontal,
      --      },
      --      left  = dpi(3),
      --      right = dpi(3),
      --      widget = wibox.container.margin
      --  },
      --  id     = "background_role",
      --  widget = wibox.container.background,
      --},
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
      }
   }
end

function _M.create_wibox(s)
   return awful.wibar{
      screen = s,
      position = 'top',
      height=beautiful.statusbar_height,
      widget = {
         layout = wibox.layout.align.horizontal,
         -- left widgets
         {
            layout = wibox.layout.fixed.horizontal,
            _M.launcher,
            s.taglist,
            s.promptbox,
         },
         -- middle widgets
         s.tasklist,
         -- right widgets
         {
            layout = wibox.layout.fixed.horizontal,
            battery_widget {adapter = "BAT0",},
            wibox.widget.systray(),
            _M.textclock,
            s.layoutbox,
         }
      }
   }
end

return _M
