local old_noflash_init = CharacterTweakData.init

function CharacterTweakData:init(tweak_data)
	old_noflash_init(self, tweak_data)
	self.flashbang_multiplier = 0
end

function PlayerDamage:on_flashbanged(sound_eff_mul, skip_explosion_sfx)
	-- Prevent flash tinnitus sound effect
end