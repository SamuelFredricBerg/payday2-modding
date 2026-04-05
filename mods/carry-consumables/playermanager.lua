_G.CarryConsumables = _G.CarryConsumables or {}
CarryConsumables.stack = CarryConsumables.stack or {}

local function cc_enabled()
	return _G.CarryConsumables and CarryConsumables.Settings and CarryConsumables.Settings.enabled
end

local function cc_max()
	return CarryConsumables.Settings and CarryConsumables.Settings.max_items or 4
end

-- Explicit whitelist of meth-lab ingredient carry IDs.
-- Keycards are special equipment (bank_manager_key), not carry bags,
-- so they are not included here.
local CONSUMABLE_CARRY_IDS = {
	nail_muriatic_acid     = true,
	nail_caustic_soda      = true,
	nail_hydrogen_chloride = true,
}

local function is_consumable_carry(carry_id)
	return carry_id ~= nil and CONSUMABLE_CARRY_IDS[carry_id] == true
end

local master_can_carry  = PlayerManager.can_carry
local master_set_carry  = PlayerManager.set_carry
local master_drop_carry = PlayerManager.drop_carry

-- Allow picking up another consumable item if the stack has room.
function PlayerManager:can_carry(carry_id)
	if not cc_enabled() or not is_consumable_carry(carry_id) then
		return master_can_carry(self, carry_id)
	end
	return #CarryConsumables.stack < cc_max()
end

-- Push the carry ID onto the stack when a consumable item is picked up and carry-consumables is enabled.
function PlayerManager:set_carry(carry_id, ...)
	master_set_carry(self, carry_id, ...)
	if cc_enabled() and is_consumable_carry(carry_id) then
		table.insert(CarryConsumables.stack, carry_id)
	end
end

-- Pop the top of the stack on drop; if more items remain, restore the previous one.
function PlayerManager:drop_carry(...)
	master_drop_carry(self, ...)
	if cc_enabled() and #CarryConsumables.stack > 0 then
		table.remove(CarryConsumables.stack, #CarryConsumables.stack)
		local prev = CarryConsumables.stack[#CarryConsumables.stack]
		if prev then
			-- Restore with safe defaults: multiplier 1, no dye pack.
			master_set_carry(self, prev, 1, false, false, nil)
		end
	end
end
