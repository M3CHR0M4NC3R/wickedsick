local _M = {}

local awful = require'awful'
local beautiful = require'beautiful'
local wibox = require'wibox'
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local menus = require'widgets.menus'
local bars = require'widgets.bars'
local mod = require'bindings.mod'
local gears = require'gears'
local bling = require'modules.bling'

bling.widget.tag_preview.enable {
   show_client_content = true,  -- Whether or not to show the client content
   
   x = (awful.screen.focused().geometry.width/2)-(awful.screen.focused().geometry.width/2)*.25,                       -- The x-coord of the popup
   y = 80,                       -- The y-coord of the popup
   scale = 0.25,                 -- The scale of the previews compared to the screen
   honor_padding = false,        -- Honor padding when creating widget size
   honor_workarea = false,       -- Honor work area when creating widget size
   background_widget = wibox.widget {    -- Set a background image (like a wallpaper) for the widget 
       image = beautiful.wallpaper,
       horizontal_fit_policy = "fit",
       vertical_fit_policy   = "fit",
       widget = wibox.widget.imagebox
   }
}


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

local taglist_buttons = {
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

function _M.create_taglist(s)
   return awful.widget.taglist{
      screen = s,
      filter = awful.widget.taglist.filter.all,
      buttons = taglist_buttons
   }
end
function _M.create_taglist2(s)
   return awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    widget_template = {
        {
            {
                {
                    {
                        {
                            id     = 'text_role',
                            widget = wibox.widget.textbox,
                        },
                        margins = 5,
                        widget  = wibox.container.margin,
                    },
                    widget = wibox.container.background,
                },
                {
                    id     = 'text_role',
                    widget = wibox.widget.textbox,
                },
                layout = wibox.layout.fixed.horizontal,
            },
            widget = wibox.container.margin
        },
        id     = 'background_role',
        widget = wibox.container.background,
        -- Add support for hover colors and an index label
        create_callback = function(self, c3, index, objects) --luacheck: no unused args
            self:get_children_by_id('text_role')[1].markup = '<b> '..index..' </b>'
            self:connect_signal('mouse::enter', function()

                -- BLING: Only show widget when there are clients in the tag
                if #c3:clients() > 0 then
                    -- BLING: Update the widget with the new tag
                    awesome.emit_signal("bling::tag_preview::update", c3)
                    -- BLING: Show the widget
                    awesome.emit_signal("bling::tag_preview::visibility", s, true)
                end

                if self.bg ~= beautiful.taglist_bg_focus then
                    self.backup     = self.bg
                    self.has_backup = true
                end
                self.bg = beautiful.taglist_bg_focus
            end)
            self:connect_signal('mouse::leave', function()

                -- BLING: Turn the widget off
                awesome.emit_signal("bling::tag_preview::visibility", s, false)

                if self.has_backup then self.bg = self.backup end
            end)
        end,
        update_callback = function(self, c3, index, objects) --luacheck: no unused args
            self:get_children_by_id('text_role')[1].markup = '<b> '..index..' </b>'
        end,
    },
    buttons = taglist_buttons
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



_M.menus=menus
_M.bars=bars
return _M
