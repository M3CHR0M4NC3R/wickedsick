local awful = require'awful'

local vars = require'config.vars'

--tag.connect_signal('request::default_layouts', function()
--   awful.layout.append_default_layouts(vars.layouts)
--end)

--for i, t in ipairs(vars.tags) do
--  local tag = awful.tag.add(t.name, { screen = s, layout = t.layouts[1], layouts = t.layouts })
--  if i == 1 then
--    tag.selected = true
--  end
--end

