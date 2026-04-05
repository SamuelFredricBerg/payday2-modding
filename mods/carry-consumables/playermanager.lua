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
-- set_carry adds every picked-up item to the stack, so #stack already
-- reflects how many consumable items the player is carrying (including
-- the currently active one).  No need to add get_my_carry_data() here.
function PlayerManager:can_carry(carry_id)
	if not cc_enabled() or not is_consumable_carry(carry_id) then
		return master_can_carry(self, carry_id)
	end
	return #CarryConsumables.stack < cc_max()
end

-- When the player picks up a carry item, record it in the stack so that
-- drop_carry can restore the previous item after the top one is dropped.
function PlayerManager:set_carry(...)
	master_set_carry(self, ...)
	if cc_enabled() then
		local cdata = self:get_my_carry_data()
		if cdata and is_consumable_carry(cdata.carry_id) then
			table.insert(CarryConsumables.stack, cdata)
			CarryConsumables:refresh_hud()
		end
	end
end

-- When the player drops a carry item, pop it from the stack.
-- If more items remain, restore the next one as the active carry.
function PlayerManager:drop_carry(...)
	master_drop_carry(self, ...)
	if cc_enabled() and #CarryConsumables.stack > 0 then
		table.remove(CarryConsumables.stack, #CarryConsumables.stack)
		if #CarryConsumables.stack > 0 then
			local cdata = CarryConsumables.stack[#CarryConsumables.stack]
			master_set_carry(
				self,
				cdata.carry_id,
				cdata.multiplier or 1,
				cdata.dye_initiated,
				cdata.has_dye_pack,
				cdata.dye_value_multiplier
			)
		end
		CarryConsumables:refresh_hud()
	end
end

-- Show the number of stacked items on the HUD using the special-equipment slot.
function CarryConsumables:refresh_hud()
	if not managers.hud then return end
	managers.hud:remove_special_equipment("carry_consumables")
	if #self.stack > 0 then
		managers.hud:add_special_equipment({
			id     = "carry_consumables",
			icon   = "pd2_loot",
			amount = #self.stack
		})
	end
end
