if not AutoMarker then AutoMarker = {} end
AutoMarker.enabled = not (AutoMarker.enabled ~= false)
if managers.hud then
	managers.hud:show_hint({text = "Auto Marker " .. (AutoMarker.enabled and "On" or "Off")})
end
