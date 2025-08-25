local m = {}
function m.launchOrFallback(primary, fallback)
	if hs.application.find(primary) then
		hs.application.launchOrFocus(primary)
	else
		hs.application.launchOrFocus(fallback)
	end
end

return m
