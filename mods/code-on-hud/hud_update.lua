Hooks:PostHook(HUDManager, "update", "update_coh", function(self)
	if self._hud_code_display then
		self._hud_code_display:update()
	end
end)