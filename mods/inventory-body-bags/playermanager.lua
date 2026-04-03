local old_ibb_pm_spawned_player = PlayerManager.spawned_player

function PlayerManager:spawned_player(id, ...)
	old_ibb_pm_spawned_player(self, id, ...)

	if id == 1 then
		self:_set_body_bags_amount(tweak_data.player.body_bags.start_amount)
	end
end