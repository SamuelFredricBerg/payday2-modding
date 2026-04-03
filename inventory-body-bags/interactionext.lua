local old_ibb_iie_interact_blocked = IntimitateInteractionExt._interact_blocked

function IntimitateInteractionExt:_interact_blocked(player)
	if self.tweak_data == "corpse_dispose" then
		if managers.player:chk_body_bags_depleted() then
			return true, nil, "body_bag_limit_reached"
		end
		return not managers.player:can_carry("person")
	end
	return old_ibb_iie_interact_blocked(self, player)
end
