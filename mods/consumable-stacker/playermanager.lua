--[[
	consumable-stacker — playermanager.lua
	Hooked on: lib/managers/playermanager

	Overrides set_carry and drop_carry so that extra consumable carries
	are queued and automatically restored one-by-one as the player uses
	each item at its objective.

	Also clears the stack on heist spawn so stale data never carries over
	from a previous heist.
]]

local cs_old_PM_set_carry      = PlayerManager.set_carry
local cs_old_PM_drop_carry     = PlayerManager.drop_carry
local cs_old_PM_spawned_player = PlayerManager.spawned_player

-- ─── PlayerManager.set_carry ────────────────────────────────────────────────

--[[
	When the player picks up a consumable carry while already holding one,
	push the new carry onto the stack instead of replacing the current one.
	The world unit has already been removed by the interaction at this point,
	so the item data must be saved here to be restored later.
]]
function PlayerManager:set_carry(carry_id, ...)
	if ConsumableStacker
			and ConsumableStacker.Settings.enabled
			and carry_id
			and ConsumableStacker.CONSUMABLE_CARRY_IDS[carry_id] then
		local current = self:get_my_carry_data()
		if current and ConsumableStacker.CONSUMABLE_CARRY_IDS[current.carry_id] then
			-- Already holding a consumable; queue the new one for later.
			table.insert(ConsumableStacker.stack, { carry_id = carry_id, args = {...} })
			return
		end
	end
	cs_old_PM_set_carry(self, carry_id, ...)
end

-- ─── PlayerManager.drop_carry ───────────────────────────────────────────────

--[[
	When the player drops (uses/consumes) a consumable carry, automatically
	restore the next queued item so the player can immediately use it.
]]
function PlayerManager:drop_carry(...)
	if ConsumableStacker and ConsumableStacker.Settings.enabled then
		local current       = self:get_my_carry_data()
		local is_consumable = current and ConsumableStacker.CONSUMABLE_CARRY_IDS[current.carry_id]

		cs_old_PM_drop_carry(self, ...)

		if is_consumable and #ConsumableStacker.stack > 0 then
			local next_item = table.remove(ConsumableStacker.stack, 1)
			cs_old_PM_set_carry(self, next_item.carry_id, unpack(next_item.args or {}))
		end
	else
		cs_old_PM_drop_carry(self, ...)
	end
end

-- ─── PlayerManager.spawned_player ───────────────────────────────────────────

--[[
	Clear the consumable stack when the local player spawns (heist start /
	respawn) so no stale items survive between heists.
]]
function PlayerManager:spawned_player(id, ...)
	cs_old_PM_spawned_player(self, id, ...)
	if id == 1 and ConsumableStacker then
		ConsumableStacker.stack = {}
	end
end
