local old_ibb_ptd_init = PlayerTweakData.init

function PlayerTweakData:init(tweak_data)
	old_ibb_ptd_init(self, tweak_data)

	if not self.body_bags then
		self.body_bags = {}
	end

	-- Sets max carrying capacity
	self.body_bags.max_amount = 99

	-- Sets how many you spawn with
	self.body_bags.start_amount = 10
end