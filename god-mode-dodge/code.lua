_G.GodMode = _G.GodMode or { enabled = true }

if RequiredScript == "lib/units/beings/player/playerdamage" then
	local old_godmodenohit_init = PlayerDamage.init

	function PlayerDamage:init(unit)
		old_godmodenohit_init(self, unit)
		if GodMode.enabled then
			self._invulnerable = true
		end
	end
end