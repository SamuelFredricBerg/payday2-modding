_G.DamageMultiplier = _G.DamageMultiplier or {}

local function dm_enabled()
	return _G.DamageMultiplier
		and DamageMultiplier.Settings
		and DamageMultiplier.Settings.enabled
end

local function dm_mul()
	return DamageMultiplier.Settings and DamageMultiplier.Settings.multiplier or 2
end

-- Returns true only for weapons being fired by the local player so that NPC
-- weapons and turrets are not affected.
local function is_player_weapon(weapon)
	return weapon._setup
		and weapon._setup.user_unit
		and managers.player
		and weapon._setup.user_unit == managers.player:player_unit()
end

-- ── Ranged damage ─────────────────────────────────────────────────────────
-- _get_current_damage is called once per shot inside _fire_raycast before
-- any falloff is applied.  Multiplying here affects every hit from that shot.
local master_get_current_damage = RaycastWeaponBase._get_current_damage

function RaycastWeaponBase:_get_current_damage(dmg_mul)
	local damage = master_get_current_damage(self, dmg_mul)
	if dm_enabled() and is_player_weapon(self) then
		damage = damage * dm_mul()
	end
	return damage
end

-- ── Melee damage ──────────────────────────────────────────────────────────
-- melee_damage_multiplier is used by the game to scale melee hits.
-- Multiplying its return value stacks naturally with skill-based bonuses.
local master_melee_dmg_mul = RaycastWeaponBase.melee_damage_multiplier

function RaycastWeaponBase:melee_damage_multiplier()
	local mul = master_melee_dmg_mul(self)
	if dm_enabled() and is_player_weapon(self) then
		mul = mul * dm_mul()
	end
	return mul
end
