local _M = {}

local awful = require'awful'
local hotkeys_popup = require'awful.hotkeys_popup'
local beautiful = require'beautiful'
local wibox = require'wibox'
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require'gears'

--import battery widget from external library
--local battery_widget = require('modules.battery-widget')

local apps = require'config.apps'
local mod = require'bindings.mod'

_M.awesomemenu = {
   {'hotkeys', function() hotkeys_popup.show_help(nil, awful.screen.focused()) end},
   {'manual', apps.manual_cmd},
   {'edit config', apps.terminal .. " -e zsh -c \'cd .config/awesome && nvim\'"},
   {'edit settings', apps.terminal .. " -e zsh -c \'cd .config/awesome && nvim theme/usersettings.lua\'"},
   {'restart', awesome.restart},
}

_M.settings = {
   {'audio', apps.terminal .. ' -e pamix'},
   {'wallpaper', 'nitrogen'},
   {'displays', 'arandr'},
   {'bluetooth', apps.terminal .. ' -e bluetui'},
   {'network', apps.terminal .. ' -e nmtui'}
}

_M.powermenu = {
   {'lock', gears.filesystem.get_configuration_dir() .. 'scripts/lock.sh'},
   {'suspend', 'systemctl suspend'},
   {'restart', 'reboot'},
   {'log out', function() awesome.quit() end},
}

_M.mainmenu = awful.menu{
   items = {
      {'awesome', _M.awesomemenu},
      {'settings', _M.settings},
      {'open terminal', apps.terminal},
      {'power', _M.powermenu},
   }
}

_M.launcher = awful.widget.launcher{
   image = beautiful.arch_icon,
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
-- Create a textbox widget to display the current tag name
local current_tag_widget = wibox.widget{
   widget = wibox.widget.textbox,
   align = "center",
   valign = "center",
   bg = beautiful.colors.text,
   buttons = {
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
      },
   font = beautiful.font,
}

-- Function to update the tag name
local function update_tag_name()
    local s = awful.screen.focused()
    local tag = s.selected_tag
    if tag then
        current_tag_widget.text = tag.name
    else
        current_tag_widget.text = "No Tag"
    end
end
tag.connect_signal("property::selected", function()
    update_tag_name()
end)
local client_class_widget = wibox.widget{
    widget = wibox.widget.textbox,
    font = beautiful.font,
}
local spotlight_widget = wibox.widget{
   widget = wibox.widget.textbox,
   font = beautiful.font,
   text = "",
   buttons = {
         awful.button{
            modifiers = {},
            button    = 1,
            on_press  = function() awful.spawn('rofi -show drun') end,
         },
   }
}


-- Function to update the wm_class
local function update_client_class()
    local c = client.focus
    if c then
        client_class_widget.text = c.class or "No Class"
    else
        client_class_widget.text = "Desktop"
    end
end
client.connect_signal("focus", function()
    update_client_class()
end)
client.connect_signal("unfocus", function()
    update_client_class()
end)

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

function _M.create_wibox_top(s)
   return awful.wibar{
   screen = s,
   position = 'top',
   height = beautiful.statusbar_height,
   bg = beautiful.statusbar_background,
   widget = {
        layout = wibox.layout.align.horizontal,
         expand = "none",
        -- Left widgets
        {
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(10),
            _M.launcher,
            client_class_widget,
            s.promptbox,
        },
        -- Middle widgets (centered taglist)
        {
            layout = wibox.layout.flex.horizontal,
            s.taglist,
            --current_tag_widget,
        },
        -- Right widgets
        {
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(10),
            spotlight_widget,
            _M.textclock,
            s.layoutbox,
        }
    }
}

end
function _M.create_wibox_bottom(s)
   return awful.wibar{
      screen = s,
      position = 'bottom',
      height=beautiful.statusbar_height,
      bg=beautiful.statusbar_background,
      widget = {
        layout = wibox.layout.align.horizontal,
        -- Left widgets
        {
            layout = wibox.layout.fixed.horizontal,
            -- Add your left widgets here
        },
        -- Middle widgets
        {
            layout = wibox.container.place,
            halign = "center",
            content_fill_vertical = true,
            s.tasklist,
        },
        -- Right widgets
        {
            layout = wibox.layout.fixed.horizontal,
            -- Add your right widgets here
        },
      }
   }
end

return _M
