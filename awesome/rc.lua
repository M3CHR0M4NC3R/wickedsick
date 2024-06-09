-- awesome_mode: api-level=4:screen=on

-- load luarocks if installed
pcall(require, 'luarocks.loader')

-- load theme
local beautiful = require'beautiful'
local gears = require'gears'
local awful = require'awful'
beautiful.init(gears.filesystem.get_configuration_dir() .. 'theme/theme.lua')
--beautiful.init(gears.filesystem.get_themes_dir() .. 'default/theme.lua')

-- load key and mouse bindings
require'bindings'

-- load rules
require'rules'

-- load signals
require'signals'

--load components
require'components.volume-adjust'

--autostarts
awful.spawn.with_shell("picom", false)
