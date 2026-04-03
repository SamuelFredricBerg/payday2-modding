local IBB_START_AMOUNT = 10
local IBB_MAX_AMOUNT = 99

local old_ibb_pm_spawned_player = PlayerManager.spawned_player
local old_ibb_pm_total_body_bags = PlayerManager.total_body_bags
local old_ibb_pm_max_body_bags = PlayerManager.max_body_bags

-- Return at least IBB_START_AMOUNT bags so the vanilla initialisation in
-- _internal_load() sets _local_player_body_bags to the correct value even
-- when the player does not have the Ghost/Cleaner skill.
function PlayerManager:total_body_bags()
	if old_ibb_pm_total_body_bags then
		return math.max(old_ibb_pm_total_body_bags(self), IBB_START_AMOUNT)
	end
	return IBB_START_AMOUNT
end

-- Raise the cap so _set_body_bags_amount does not clamp back to 0.
-- Without the Ghost/Cleaner skill the vanilla max is 0, which prevents
-- any bags from being counted.  Raising it to IBB_MAX_AMOUNT makes all
-- of the vanilla helpers (_set_body_bags_amount, on_used_body_bag,
-- chk_body_bags_depleted, add_body_bags_amount) work correctly.
function PlayerManager:max_body_bags()
	if old_ibb_pm_max_body_bags then
		return math.max(old_ibb_pm_max_body_bags(self), IBB_MAX_AMOUNT)
	end
	return IBB_MAX_AMOUNT
end

-- Ensure the correct starting count is applied at heist spawn regardless
-- of any stale carry-over state from a previous heist.
function PlayerManager:spawned_player(id, ...)
	old_ibb_pm_spawned_player(self, id, ...)

	if id == 1 then
		self:_set_body_bags_amount(self:total_body_bags())
	end
end
