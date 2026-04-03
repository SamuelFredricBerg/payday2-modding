local old_ibb_iie_can_select = IntimitateInteractionExt.can_select
local old_ibb_iie_can_interact = IntimitateInteractionExt.can_interact
local old_ibb_iie_interact_blocked = IntimitateInteractionExt._interact_blocked

-- Show the corpse_dispose prompt whenever the player has body bags,
-- bypassing the Ghost/Cleaner skill gate in BaseInteractionExt.can_select.
function IntimitateInteractionExt:can_select(player)
	if self.tweak_data == "corpse_dispose" then
		return not managers.player:chk_body_bags_depleted()
	end
	if old_ibb_iie_can_select then
		return old_ibb_iie_can_select(self, player)
	end
	return true
end

-- Allow the interaction to execute when the player has body bags,
-- bypassing the Ghost/Cleaner skill gate in BaseInteractionExt.can_interact.
-- This is called both during the interaction countdown (interact_start) and
-- inside interact() itself.
function IntimitateInteractionExt:can_interact(player)
	if self.tweak_data == "corpse_dispose" then
		return not managers.player:chk_body_bags_depleted()
	end
	if old_ibb_iie_can_interact then
		return old_ibb_iie_can_interact(self, player)
	end
	return true
end

function IntimitateInteractionExt:_interact_blocked(player)
	if self.tweak_data == "corpse_dispose" then
		if managers.player:chk_body_bags_depleted() then
			return true, nil, "body_bag_limit_reached"
		end
		return false
	end
	return old_ibb_iie_interact_blocked(self, player)
end
