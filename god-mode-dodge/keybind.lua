GodMode.enabled = not GodMode.enabled
if GodMode.enabled then
	managers.hud:show_hint({text = "God Mode On"})
else
	managers.hud:show_hint({text = "God Mode Off"})
end

local player = managers.player:player_unit()
if player and alive(player) then
	player:character_damage()._invulnerable = GodMode.enabled
end
