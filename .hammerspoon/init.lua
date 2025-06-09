hs = hs

local super = { "cmd", "ctrl", "alt", "shift" }

hs.hotkey.bind(super, "t", function()
	hs.application.launchOrFocus("WezTerm")
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
	hs.application.launchOrFocus("pgAdmin 4")
end)

hs.hotkey.bind(super, "s", function()
	hs.application.launchOrFocus("Slack")
end)

hs.hotkey.bind({ "alt", "shift" }, "R", function()
	hs.reload()
end)

--* INIT
hs.alert.show("Config loaded")
