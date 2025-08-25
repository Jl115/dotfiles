hs = hs

--* MODULES
local finder = require("utils.finder")

local super = { "cmd", "ctrl", "alt", "shift" }

hs.hotkey.bind(super, "t", function()
	hs.application.launchOrFocus("kitty")
end)

hs.hotkey.bind(super, "o", function()
	hs.application.launchOrFocus("Arc")
end)

hs.hotkey.bind(super, "w", function()
	hs.application.launchOrFocus("Warp")
end)

hs.hotkey.bind(super, "l", function()
	hs.application.launchOrFocus("Finder")
end)

hs.hotkey.bind(super, "p", function()
	finder.launchOrFallback("pgAdmin 4", "dbeaver")
end)

hs.hotkey.bind(super, "s", function()
	hs.application.launchOrFocus("Slack")
end)

hs.hotkey.bind(super, "n", function()
	hs.application.launchOrFocus("Agenda")
end)

hs.hotkey.bind({ "alt", "shift" }, "R", function()
	hs.reload()
end)

--* INIT
hs.alert.show("Config loaded")
