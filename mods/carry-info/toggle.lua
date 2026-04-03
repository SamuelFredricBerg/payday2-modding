_G.CarryInfo = _G.CarryInfo or { enabled = true }
CarryInfo.enabled = not CarryInfo.enabled
if managers.hud then
	managers.hud:show_hint({text = "Carry Info " .. (CarryInfo.enabled and "On" or "Off")})
end
