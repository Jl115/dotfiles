hs = hs

-- hammerspoon can be your next app launcher!!!!
f20Tap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
  if event:getKeyCode() == 90 then -- F20
	hs.application.launchOrFocus("Arc")
    return true
  end
end)


hs.hotkey.bind({}, "F19", function()
	hs.application.launchOrFocus("WezTerm")
end)

hs.hotkey.bind({}, "F18", function()
	hs.application.launchOrFocus("Warp")
end)

hs.hotkey.bind({}, "F17", function()
	hs.application.launchOrFocus("Finder")
end)

hs.hotkey.bind({}, "F16", function()
	hs.application.launchOrFocus("pgAdmin 4")
end)

hs.hotkey.bind({}, "F15", function()
	hs.application.launchOrFocus("Slack")
end)

hs.hotkey.bind({ "alt", "shift" }, "R", function()
	hs.reload()
end)


--* INIT
f20Tap:start()
hs.alert.show("Config loaded")
