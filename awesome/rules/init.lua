local awful = require'awful'
local ruled = require'ruled'
local beautiful = require'beautiful'

ruled.client.connect_signal('request::rules', function()
   -- All clients will match this rule.
   ruled.client.append_rule{
      id         = 'global',
      rule       = {},
      properties = {
         focus     = awful.client.focus.filter,
         raise     = true,
         screen    = awful.screen.preferred,
         placement = awful.placement.no_overlap + awful.placement.no_offscreen + awful.placement.centered
      }
   }

   -- Floating clients.
   ruled.client.append_rule{
      id = 'floating',
      rule_any = {
         instance = {'copyq', 'pinentry'},
         class = {
            'Arandr',
            'Blueman-manager',
            'Gpick',
            'Kruler',
            'Sxiv',
            'Tor Browser',
            'Wpa_gui',
            'veromix',
            'xtightvncviewer',
            'pcmanfm-qt',
            'pcmanfm',
            'nitrogen',
            'mpv',
            'zenity',
            'median xl launcher exe',
         },
         -- Note that the name property shown in xprop might be set slightly after creation of the client
         -- and the name shown there might not match defined rules here.
         name = {
            'Event Tester',  -- xev.
            'D2Stats',
         },
         role = {
            'AlarmWindow',    -- Thunderbird's calendar.
            'ConfigManager',  -- Thunderbird's about:config.
            'pop-up',         -- e.g. Google Chrome's (detached) Developer Tools.
         }
      },
      properties = {floating = true}
   }
   ruled.client.append_rule{
      id = 'pcman desktop',
      rule = {name = 'pcmanfm-desktop0'},
      properties = {
         sticky = true,
         border_width = 0,
         fullscreen=true,
         below=true
      }
   }

   -- Add titlebars to normal clients and dialogs
   ruled.client.append_rule{
      id         = 'titlebars',
      rule_any   = {type = {'normal', 'dialog'}},
      except_any={class={
         'steam',
         'blanket',
         'zenity',
         'Zathura',
         'Alacritty'
         }
      },
      properties = {titlebars_enabled = beautiful.titlebars_enabled},
   }


   ruled.client.append_rule {
      rule = { class = "Plank" },
      properties = {
          border_width = 3,
          floating = true,
          sticky = true,
          ontop = true,
          focusable = true,
          below = false
      }
   }
end)
