local old_ibb_iie_can_select = IntimitateInteractionExt.can_select
local old_ibb_iie_interact_blocked = IntimitateInteractionExt._interact_blocked

function IntimitateInteractionExt:can_select(player)
	if self.tweak_data == "corpse_dispose" then
		return not managers.player:chk_body_bags_depleted()
	end
	return old_ibb_iie_can_select(self, player)
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
