local awful = require'awful'
local hotkeys_popup = require'awful.hotkeys_popup'
require'awful.hotkeys_popup.keys'
local menubar = require'menubar'
local revelation = require('modules.revelation')
local switcher = require('modules.awesome-switcher')

local apps = require'config.apps'
local mod = require'bindings.mod'
local widgets = require'widgets'
local gears = require'gears'

menubar.utils.terminal = apps.terminal
revelation.init()
--revelation settings :D

-- general awesome keys
awful.keyboard.append_global_keybindings{
   awful.key{
      modifiers   = {mod.super},
      key         = 's',
      description = 'show help',
      group       = 'awesome',
      on_press    = hotkeys_popup.show_help,
   },
   awful.key{
      modifiers   = {mod.super},
      key         = 'w',
      description = 'show main menu',
      group       = 'awesome',
      on_press    = function() widgets.mainmenu:show() end,
   },
   awful.key{
      modifiers   = {mod.super, mod.shift},
      key         = 'w',
      description = 'show window menu',
      group       = 'awesome',
      on_press    = function() widgets.windowmenu:show() end,
   },
   awful.key{
      modifiers   = {mod.super, mod.ctrl},
      key         = 'r',
      description = 'reload awesome',
      group       = 'awesome',
      on_press    = awesome.restart,
   },
   awful.key{
      modifiers   = {mod.super, mod.shift},
      key         = 'q',
      description = 'quit awesome',
      group       = 'awesome',
      on_press    = awesome.quit,
   },
   awful.key{
      modifiers   = {mod.super},
      key         = 'x',
      description = 'lua execute prompt',
      group       = 'awesome',
      on_press    = function()
         awful.prompt.run{
            prompt = 'Run Lua code: ',
            textbox = awful.screen.focused().promptbox.widget,
            exe_callback = awful.util.eval,
            history_path = awful.util.get_cache_dir() .. '/history_eval'
         }
      end,
   },
   awful.key{
      modifiers   = {mod.super},
      key         = 'Return',
      description = 'open a terminal',
      group       = 'launcher',
      on_press    = function() awful.spawn(apps.terminal) end,
   },
   awful.key{
      modifiers   = {mod.super},
      key         = 'f',
      description = 'open file browser',
      group       = 'launcher',
      on_press    = function() awful.spawn(apps.fileapp) end,
      --on_press    = function() awful.spawn(apps.terminal_folder_cmd) end,
   },
   --awful.key{
   --   modifiers   = {mod.super},
   --   key         = 'r',
   --   description = 'run prompt',
   --   group       = 'launcher',
   --   on_press    = function() awful.screen.focused().promptbox:run() end,
   --},
   awful.key{
      modifiers   = {mod.super},
      key         = 'space',
      description = 'show the application launcher',
      group       = 'launcher',
      --on_press    = function() menubar.show() end,
      on_press    = function() awful.spawn('rofi -show drun') end,
   },
   awful.key{
      modifiers   = {mod.super},
      key         = 'r',
      description = 'open radio selector',
      group       = 'launcher',
      on_press    = function() awful.spawn(gears.filesystem.get_configuration_dir() .. 'scripts/rofi-radio.sh', false) end,
   },
}

-- tags related keybindings
awful.keyboard.append_global_keybindings{
   awful.key{
      modifiers   = {mod.super},
      key         = 'Left',
      description = 'view previous',
      group       = 'tag',
      on_press    = awful.tag.viewprev,
   },
   awful.key{
      modifiers   = {mod.super},
      key         = 'Right',
      description = 'view next',
      group       = 'tag',
      on_press    = awful.tag.viewnext,
   },
   awful.key{
      modifiers   = {mod.super},
      key         = 'Escape',
      description = 'go back',
      group       = 'tag',
      on_press    = awful.tag.history.restore,
   },
}

-- focus related keybindings
awful.keyboard.append_global_keybindings{
   awful.key{
      modifiers   = {mod.super},
      key         = 'h',
      description = 'focus next by index',
      group       = 'client',
      on_press    = function() awful.client.focus.bydirection("left") end,
   },
   awful.key{
      modifiers   = {mod.super},
      key         = 'j',
      description = 'focus next by index',
      group       = 'client',
      on_press    = function() awful.client.focus.bydirection("down") end,
   },
   awful.key{
      modifiers   = {mod.super},
      key         = 'k',
      description = 'focus next by index',
      group       = 'client',
      on_press    = function() awful.client.focus.bydirection("up") end,
   },
   awful.key{
      modifiers   = {mod.super},
      key         = 'l',
      description = 'focus next by index',
      group       = 'client',
      on_press    = function() awful.client.focus.bydirection("right") end,
   },
   awful.key{
      modifiers   = {mod.super},
      key         = 'd',
      description = 'revelation (current tag)',
      group       = 'client',
      on_press    = function () revelation({curr_tag_only=true}) end,
   },
   awful.key{
      modifiers   = {mod.super, mod.shift},
      key         = 'd',
      description = 'revelation (all tags)',
      group       = 'client',
      on_press    = function () revelation() end,
   },
   awful.key{
      modifiers = {mod.super},
      key = 'Tab',
      description = 'window switcher',
      group = 'client',
      on_press = function()
          switcher.switch( 1, "Mod4", "Super_L", "Shift", "Tab")
      end
   },
   awful.key{
      modifiers = {mod.super, "Shift"},
      key = 'Tab',
      description = 'window switcher',
      group = 'client',
      on_press = function()
          switcher.switch( -1, "Mod4", "Super_L", "Shift", "Tab")
      end
   },
   awful.key{
      modifiers   = {mod.super, mod.ctrl},
      key         = 'j',
      description = 'focus the next screen',
      group       = 'screen',
      on_press    = function() awful.screen.focus_relative(1) end,
   },
   awful.key{
      modifiers   = {mod.super, mod.ctrl},
      key         = 'k',
      description = 'focus the previous screen',
      group       = 'screen',
      on_press    = function() awful.screen.focus_relative(-1) end,
   },
   awful.key{
      modifiers   = {mod.super, mod.ctrl},
      key         = 'n',
      description = 'restore minimized',
      group       = 'client',
      on_press    = function()
         local c = awful.client.restore()
         if c then
            c:active{raise = true, context = 'key.unminimize'}
         end
      end,
   },
}

-- layout related keybindings
awful.keyboard.append_global_keybindings{
   awful.key{
      modifiers   = {mod.super, mod.shift},
      key         = 'h',
      description = 'swap window',
      group       = 'client',
      on_press    = function() awful.client.swap.bydirection("left") end,
   },
   awful.key{
      modifiers   = {mod.super, mod.shift},
      key         = 'j',
      description = 'swap window',
      group       = 'client',
      on_press    = function() awful.client.swap.bydirection("down") end,
   },
   awful.key{
      modifiers   = {mod.super, mod.shift},
      key         = 'k',
      description = 'swap window',
      group       = 'client',
      on_press    = function() awful.client.swap.bydirection("up") end,
   },
   awful.key{
      modifiers   = {mod.super, mod.shift},
      key         = 'l',
      description = 'swap window',
      group       = 'client',
      on_press    = function() awful.client.swap.bydirection("right") end,
   },
   awful.key{
      modifiers   = {mod.super},
      key         = 'u',
      description = 'jump to urgent client',
      group       = 'client',
      on_press    = awful.client.urgent.jumpto,
   },
   --awful.key{
   --   modifiers   = {mod.super},
   --   key         = 'l',
   --   description = 'increase master width factor',
   --   group       = 'layout',
   --   on_press    = function() awful.tag.incmwfact(0.05) end,
   --},
   --awful.key{
   --   modifiers   = {mod.super},
   --   key         = 'h',
   --   description = 'decrease master width factor',
   --   group       = 'layout',
   --   on_press    = function() awful.tag.incmwfact(-0.05) end,
   --},
   --awful.key{
   --   modifiers   = {mod.super, mod.shift},
   --   key         = 'h',
   --   description = 'increase the number of master clients',
   --   group       = 'layout',
   --   on_press    = function() awful.tag.incnmaster(1, nil, true) end,
   --},
   --awful.key{
   --   modifiers   = {mod.super, mod.shift},
   --   key         = 'l',
   --   description = 'decrease the number of master clients',
   --   group       = 'layout',
   --   on_press    = function() awful.tag.incnmaster(-1, nil, true) end,
   --},
   awful.key{
      modifiers   = {mod.super, mod.ctrl},
      key         = 'h',
      description = 'increase the number of columns',
      group       = 'layout',
      on_press    = function() awful.tag.incncol(1, nil, true) end,
   },
   awful.key{
      modifiers   = {mod.super, mod.ctrl},
      key         = 'l',
      description = 'decrease the number of columns',
      group       = 'layout',
      on_press    = function() awful.tag.incncol(-1, nil, true) end,
   },
   awful.key{
      modifiers   = {mod.super},
      key         = 'y',
      description = 'select next',
      group       = 'layout',
      on_press    = function() awful.layout.inc(1) end,
   },
   awful.key{
      modifiers   = {mod.super, mod.shift},
      key         = 'y',
      description = 'select previous',
      group       = 'layout',
      on_press    = function() awful.layout.inc(-1) end,
   },
}

awful.keyboard.append_global_keybindings{
   awful.key{
      modifiers   = {mod.super},
      keygroup    = 'numrow',
      description = 'only view tag',
      group       = 'tag',
      on_press    = function(index)
         local screen = awful.screen.focused()
         local tag = screen.tags[index]
         if tag then
            tag:view_only()
         end
      end
   },
   awful.key{
      modifiers   = {mod.super, mod.ctrl},
      keygroup    = 'numrow',
      description = 'toggle tag',
      group       = 'tag',
      on_press    = function(index)
         local screen = awful.screen.focused()
         local tag = screen.tags[index]
         if tag then
            awful.tag.viewtoggle(tag)
         end
      end
   },
   awful.key{
      modifiers   = {mod.super, mod.shift},
      keygroup    = 'numrow',
      description = 'move focused client to tag',
      group       = 'tag',
      on_press    = function(index)
         if client.focus then
            local tag = client.focus.screen.tags[index]
            if tag then
               client.focus:move_to_tag(tag)
            end
         end
      end
   },
   awful.key {
      modifiers   = {mod.super, mod.ctrl, mod.shift},
      keygroup    = 'numrow',
      description = 'toggle focused client on tag',
      group       = 'tag',
      on_press    = function(index)
         if client.focus then
            local tag = client.focus.screen.tags[index]
            if tag then
               client.focus:toggle_tag(tag)
            end
         end
      end,
   },
   awful.key{
      modifiers   = {mod.super},
      keygroup    = 'numpad',
      description = 'select layout directly',
      group       = 'layout',
      on_press    = function(index)
         local tag = awful.screen.focused().selected_tag
         if tag then
            tag.layout = tag.layouts[index] or tag.layout
         end
      end
   },
   awful.key{
      modifiers   = {},
      key         = 'Print',
      description = 'screenshot',
      group       = 'system',
      on_press    = function() awful.spawn('flameshot gui', false) end,
   },
   awful.key{
      modifiers   = {},
      key         = 'XF86MonBrightnessUp',
      description = 'increase brightness',
      group       = 'system',
      on_press    = function() awful.spawn(gears.filesystem.get_configuration_dir() .. 'scripts/brightness.sh up', false) end,
   },
   awful.key{
      modifiers   = {},
      key         = 'XF86MonBrightnessDown',
      description = 'decrease brightness',
      group       = 'system',
      on_press    = function() awful.spawn(gears.filesystem.get_configuration_dir() .. 'scripts/brightness.sh down', false) end,
   },
   awful.key{
      modifiers   = {},
      key         = 'XF86AudioRaiseVolume',
      description = 'increase volume',
      group       = 'system',
      on_press    = function() awful.spawn(gears.filesystem.get_configuration_dir() .. 'scripts/volume.sh up', false)
      awesome.emit_signal("volume_change")
       end,
   },
   awful.key{
      modifiers   = {},
      key         = 'XF86AudioLowerVolume',
      description = 'decrease volume',
      group       = 'system',
      on_press    = function() awful.spawn(gears.filesystem.get_configuration_dir() .. 'scripts/volume.sh down', false)
      awesome.emit_signal("volume_change")
      end,
   },
   awful.key{
      modifiers   = {},
      key         = 'XF86AudioMute',
      description = 'mute volume',
      group       = 'system',
      on_press    = function() awful.spawn(gears.filesystem.get_configuration_dir() .. 'scripts/volume.sh mute', false)
      --awesome.emit_signal("volume_change")
      end,
   },
   awful.key{
      modifiers   = {},
      key         = 'XF86AudioPlay',
      description = 'pause media',
      group       = 'system',
      on_press    = function() awful.spawn('playerctl play-pause', false) end,
   },
--this is for hhkb users without pause keys
   awful.key{
      modifiers   = {},
      key         = 'XF86Eject',
      description = 'pause media',
      group       = 'system',
      on_press    = function() awful.spawn('playerctl play-pause', false) end,
   },
   awful.key{
      modifiers   = {},
      key         = 'XF86AudioNext',
      description = 'skip media',
      group       = 'system',
      on_press    = function() awful.spawn('playerctl skip', false) end,
   },
   awful.key{
      modifiers   = {},
      key         = 'XF86AudioPrev',
      description = 'previous media',
      group       = 'system',
      on_press    = function() awful.spawn('playerctl previous', false) end,
   },
}
