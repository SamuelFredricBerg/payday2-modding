_G.MorePagers = _G.MorePagers or { enabled = true }
MorePagers.enabled = not MorePagers.enabled
if managers.hud then
	managers.hud:show_hint({text = "More Pagers " .. (MorePagers.enabled and "On" or "Off")})
end
