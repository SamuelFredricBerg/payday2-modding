-- local old_antitaser_init = PlayerTweakData.init

-- function PlayerTweakData:init(tweak_data)
--     old_antitaser_init(self, tweak_data)
-- 	self.damage.TASED_TIME = 999
-- 	self.damage.TASED_RECOVER_TIME = 0
-- end

function PlayerDamage:damage_tase(attack_data)
	-- Prevent the player from entering the tased state
end