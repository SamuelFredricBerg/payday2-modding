local old_ibb_pm_spawned_player = PlayerManager.spawned_player
local old_ibb_pm_can_carry = PlayerManager.can_carry

function PlayerManager:spawned_player(id, ...)
	old_ibb_pm_spawned_player(self, id, ...)

	if id == 1 then
		local start_amount = tweak_data.player.body_bags and tweak_data.player.body_bags.start_amount or 10
		self:_set_body_bags_amount(start_amount)
	end
end

function PlayerManager:can_carry(carry_id, ...)
	if carry_id == "person" then
		return not self:chk_body_bags_depleted()
	end
	if old_ibb_pm_can_carry then
		return old_ibb_pm_can_carry(self, carry_id, ...)
	end
	return false
end
