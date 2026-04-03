local IBB_DEFAULT_START_AMOUNT = 10
local IBB_DEFAULT_MAX_AMOUNT = 15

local function ibb_start_amount()
	return _G.IBB and _G.IBB.Settings and _G.IBB.Settings.start_amount or IBB_DEFAULT_START_AMOUNT
end

local function ibb_max_amount()
	-- Ensure the cap is never lower than the starting amount so
	-- _set_body_bags_amount does not clamp the initial count back to zero.
	local start = ibb_start_amount()
	local max = _G.IBB and _G.IBB.Settings and _G.IBB.Settings.max_amount or IBB_DEFAULT_MAX_AMOUNT
	return math.max(max, start)
end

local old_ibb_pm_spawned_player = PlayerManager.spawned_player
local old_ibb_pm_total_body_bags = PlayerManager.total_body_bags
local old_ibb_pm_max_body_bags = PlayerManager.max_body_bags

-- Return at least ibb_start_amount() bags so the vanilla initialisation in
-- _internal_load() sets _local_player_body_bags to the correct value even
-- when the player does not have the Ghost/Cleaner skill.
function PlayerManager:total_body_bags()
	if old_ibb_pm_total_body_bags then
		return math.max(old_ibb_pm_total_body_bags(self), ibb_start_amount())
	end
	return ibb_start_amount()
end

-- Raise the cap so _set_body_bags_amount does not clamp back to 0.
-- Without the Ghost/Cleaner skill the vanilla max is 0, which prevents
-- any bags from being counted.  Raising it to ibb_max_amount() makes all
-- of the vanilla helpers (_set_body_bags_amount, on_used_body_bag,
-- chk_body_bags_depleted, add_body_bags_amount) work correctly.
function PlayerManager:max_body_bags()
	if old_ibb_pm_max_body_bags then
		return math.max(old_ibb_pm_max_body_bags(self), ibb_max_amount())
	end
	return ibb_max_amount()
end

-- Ensure the correct starting count is applied at heist spawn regardless
-- of any stale carry-over state from a previous heist.
function PlayerManager:spawned_player(id, ...)
	old_ibb_pm_spawned_player(self, id, ...)

	if id == 1 then
		self:_set_body_bags_amount(self:total_body_bags())
	end
end