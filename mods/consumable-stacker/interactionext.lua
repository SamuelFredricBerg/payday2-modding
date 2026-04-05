--[[
	consumable-stacker — interactionext.lua
	Hooked on: lib/units/interactions/interactionext

	Overrides CarryInteractionExt so that the player can pick up a
	consumable carry (ingredient, crowbar, keycard) even while already
	holding one, as long as the stack is not full.
]]

local cs_old_CIE_interact_blocked = CarryInteractionExt._interact_blocked
local cs_old_CIE_can_select       = CarryInteractionExt.can_select

-- Safe accessor: returns the carry_id of a unit's carry component, or nil.
local function cs_carry_id(unit)
	local cd = unit and unit.carry_data and unit:carry_data()
	return cd and cd:carry_id()
end

--[[
	Returns true when the mod is enabled, the player is currently holding
	a consumable carry, and there is room in the stack for one more.
]]
local function cs_can_stack()
	if not (ConsumableStacker and ConsumableStacker.Settings.enabled) then
		return false
	end
	local current = managers.player:get_my_carry_data()
	if not (current and ConsumableStacker.CONSUMABLE_CARRY_IDS[current.carry_id]) then
		-- Player is not holding a consumable right now; vanilla logic applies.
		return false
	end
	-- Allow up to (max_stack - 1) extras on top of the one in hand.
	return #ConsumableStacker.stack < ConsumableStacker.Settings.max_stack - 1
end

-- ─── CarryInteractionExt._interact_blocked ───────────────────────────────────

function CarryInteractionExt:_interact_blocked(player)
	local carry_id = cs_carry_id(self._unit)
	if carry_id
			and ConsumableStacker
			and ConsumableStacker.CONSUMABLE_CARRY_IDS[carry_id]
			and cs_can_stack() then
		return false
	end
	if cs_old_CIE_interact_blocked then
		return cs_old_CIE_interact_blocked(self, player)
	end
	return false
end

-- ─── CarryInteractionExt.can_select ─────────────────────────────────────────

function CarryInteractionExt:can_select(player)
	local carry_id = cs_carry_id(self._unit)
	if carry_id
			and ConsumableStacker
			and ConsumableStacker.CONSUMABLE_CARRY_IDS[carry_id]
			and cs_can_stack() then
		return true
	end
	if cs_old_CIE_can_select then
		return cs_old_CIE_can_select(self, player)
	end
	return true
end
