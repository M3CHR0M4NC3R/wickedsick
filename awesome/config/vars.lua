local _M = {}

local awful = require'awful'

_M.layouts = {
   awful.layout.suit.tile,
   awful.layout.suit.floating,
   awful.layout.suit.tile.left,
   awful.layout.suit.tile.bottom,
   awful.layout.suit.tile.top,
   awful.layout.suit.fair,
   awful.layout.suit.fair.horizontal,
   awful.layout.suit.spiral,
   awful.layout.suit.spiral.dwindle,
   awful.layout.suit.max,
   awful.layout.suit.max.fullscreen,
   awful.layout.suit.magnifier,
   awful.layout.suit.corner.nw,
}

_M.tags = {
   {name='', layouts={ awful.layout.suit.floating, awful.layout.suit.tile } },
   {name='', layouts=_M.layouts},
   {name='', layouts=_M.layouts},
   {name='', layouts=_M.layouts},
   {name='', layouts=_M.layouts},
   {name='', layouts=_M.layouts},
   {name='', layouts=_M.layouts}
}

local function get_tag_names()
    local names = {}
    for _, tag in ipairs(_M.tags) do
        table.insert(names, tag.name)
    end
    return names
end
local function get_tag_layouts()
    local layouts = {}
    for _, tag in ipairs(_M.tags) do
        table.insert(layouts, tag.layouts[1])
    end
    return layouts
end

_M.tagnames = get_tag_names()
_M.taglayouts = get_tag_layouts()

return _M
