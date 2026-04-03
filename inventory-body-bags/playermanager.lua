local IBB_START_AMOUNT = 10

local old_ibb_pm_spawned_player = PlayerManager.spawned_player
local old_ibb_pm_can_carry = PlayerManager.can_carry
local old_ibb_pm_set_body_bags_amount = PlayerManager._set_body_bags_amount

-- Give the local player body bags at heist start.
-- Calling self:_set_body_bags_amount propagates through the full chain so
-- the game HUD (e.g. vanilla-HUD-plus) also updates correctly.
function PlayerManager:spawned_player(id, ...)
	old_ibb_pm_spawned_player(self, id, ...)

	if id == 1 then
		self:_set_body_bags_amount(IBB_START_AMOUNT)
	end
end

-- Override the internal setter to track our own per-instance counter.
-- Without the Ghost/Cleaner skill the game never initialises its internal
-- body-bag state, so the vanilla _set_body_bags_amount either crashes or
-- silently does nothing.  By maintaining _ibb_bag_count on self we
-- guarantee that chk_body_bags_depleted and get_body_bags_amount always
-- reflect the correct value.  The old chain (including any HUD mods) is
-- still called so they can update their displays.
-- Note: old_ibb_pm_set_body_bags_amount is nil-checked because it is an
-- internal helper that may not exist in all game versions.
function PlayerManager:_set_body_bags_amount(amount)
	self._ibb_bag_count = amount
	if old_ibb_pm_set_body_bags_amount then
		old_ibb_pm_set_body_bags_amount(self, amount)
	end
end

-- Use our per-instance counter for the depletion check so the
-- corpse_dispose interaction (and carry-stacker's guard) sees the correct
-- state.
function PlayerManager:chk_body_bags_depleted()
	return (self._ibb_bag_count or 0) <= 0
end

-- Expose our counter so HUD mods that call get_body_bags_amount() show
-- the right number.
function PlayerManager:get_body_bags_amount()
	return self._ibb_bag_count or 0
end

-- Bypass the Ghost/Cleaner skill check for the "person" carry type that
-- the corpse_dispose interaction requires.
function PlayerManager:can_carry(carry_id, ...)
	if carry_id == "person" then
		return not self:chk_body_bags_depleted()
	end
	if old_ibb_pm_can_carry then
		return old_ibb_pm_can_carry(self, carry_id, ...)
	end
	return false
end
