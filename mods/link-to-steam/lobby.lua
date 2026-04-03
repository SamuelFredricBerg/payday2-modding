function ContractBoxGui:mouse_pressed(button, x, y)
	if not self:can_take_input() then
		return
	end
	if button == Idstring("0") then
		local used = false
		local pointer = "arrow"
		if self._peers and SystemInfo:platform() == Idstring("WIN32") and MenuCallbackHandler:is_overlay_enabled() then
			for peer_id, object in pairs(self._peers) do
				if alive(object) and object:inside(x, y) then
					local peer = managers.network:session() and managers.network:session():peer(peer_id)
					if peer then
						-- Obtém Steam ID através do account_id
						if peer.account_id and peer:account_id() then
							local steam_id64 = tostring(peer:account_id())
							if steam_id64 and steam_id64:len() > 10 then
								Steam:overlay_activate("url", "https://steamcommunity.com/profiles/" .. steam_id64 .. "/")
								return
							end
						end
						return
					end
				end
			end
		end
	end
end