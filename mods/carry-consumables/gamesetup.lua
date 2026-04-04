-- Reset the carry stack when a new heist begins so stale state never
-- carries over from a previous mission.
_G.CarryConsumables = _G.CarryConsumables or {}

Hooks:PostHook(GameSetup, "setup_game_state_machine", "CarryConsumables_ResetStack", function(self)
	if _G.BLT_CarryStacker then return end
	CarryConsumables.stack = {}
	if managers.hud then
		managers.hud:remove_special_equipment("carry_consumables")
	end
end)
