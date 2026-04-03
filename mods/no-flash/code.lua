-- local old_noflashgab_init = CharacterTweakData.init

-- function CharacterTweakData:init(tweak_data)
-- old_noflashgab_init(self, tweak_data)
-- self.flashbang_multiplier = 0
-- self.concussion_multiplier = 0
-- end

if RequiredScript == "lib/tweak_data/charactertweakdata" then
	local old_noflash_init = CharacterTweakData.init

	function CharacterTweakData:init(tweak_data)
		old_noflash_init(self, tweak_data)
		self.flashbang_multiplier = 0
	end
elseif RequiredScript == "lib/units/beings/player/playerdamage" then
	function PlayerDamage:on_flashbanged(sound_eff_mul, skip_explosion_sfx)
		-- Prevent flash tinnitus sound effect
	end
end