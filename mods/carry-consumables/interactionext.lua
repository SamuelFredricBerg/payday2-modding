-- Skip if carry-stacker is already loaded; it already overrides these methods.
if _G.BLT_CarryStacker then return end

_G.CarryConsumables = _G.CarryConsumables or {}

local function cc_enabled()
	return _G.CarryConsumables and CarryConsumables.Settings and CarryConsumables.Settings.enabled
end

-- CarryInteractionExt handles the physical pickup of carry bags in the world.
if CarryInteractionExt then
	local master_interact_blocked = CarryInteractionExt._interact_blocked
	local master_can_select       = CarryInteractionExt.can_select

	-- Block the interaction when the player is already at the stack limit.
	function CarryInteractionExt:_interact_blocked(player)
		if cc_enabled() then
			return not managers.player:can_carry(self._unit:carry_data():carry_id())
		end
		if master_interact_blocked then
			return master_interact_blocked(self, player)
		end
		return false
	end

	-- Allow the "PICK UP" prompt to appear when the stack still has room.
	function CarryInteractionExt:can_select(player)
		if cc_enabled() then
			return CarryInteractionExt.super.can_select(self, player)
				and managers.player:can_carry(self._unit:carry_data():carry_id())
		end
		if master_can_select then
			return master_can_select(self, player)
		end
		return CarryInteractionExt.super.can_select(self, player)
	end
end
