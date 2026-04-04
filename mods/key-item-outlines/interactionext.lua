_G.KeyItemOutlines = _G.KeyItemOutlines or {}

-- Returns true if the given carry_id should receive a persistent outline.
-- When "all_carry" is disabled (default) only light / coke_light items
-- (keycards, meth ingredients, cocaine bricks, etc.) are outlined.
-- When "all_carry" is enabled every carriable item gets an outline.
local function kio_should_outline(carry_id)
	if not carry_id or not tweak_data or not tweak_data.carry then return false end
	local item = tweak_data.carry[carry_id]
	if not item then return false end
	if KeyItemOutlines.Settings and KeyItemOutlines.Settings.all_carry then return true end
	local t = item.type
	return t == "light" or t == "coke_light"
end

-- We hook BaseInteractionExt.set_active (which all interaction extensions
-- inherit) and only act on units that have carry_data, i.e. carriable items.
-- Using Hooks:PostHook ensures we run AFTER the vanilla method regardless of
-- whether CarryInteractionExt defines its own set_active override.
Hooks:PostHook(BaseInteractionExt, "set_active", "KIO_SetActive", function(self, active)
	if not _G.KeyItemOutlines or not KeyItemOutlines.Settings or not KeyItemOutlines.Settings.enabled then
		return
	end

	if not alive(self._unit) then return end

	-- Only act on units that expose carry data (i.e. carriable world objects).
	local ok, carry_data = pcall(function() return self._unit:carry_data() end)
	if not ok or not carry_data then return end

	local ok2, carry_id = pcall(function() return carry_data:carry_id() end)
	if not ok2 or not carry_id then return end

	if active then
		if kio_should_outline(carry_id) and not self._kio_contour_id then
			-- "mark_enemy" is guaranteed to exist; it is used by the
			-- vanilla marking system and the auto-marker mod.
			self._kio_contour_id = self._unit:contour():add("mark_enemy")
		end
	else
		if self._kio_contour_id then
			if self._unit:contour() then
				self._unit:contour():remove_by_id(self._kio_contour_id)
			end
			self._kio_contour_id = nil
		end
	end
end)
