local function look_for_code_parts(message)
	message = message:lower()
	return message:find('r') ~= nil, message:find('g') ~= nil, message:find('b') ~= nil
end

local function look_for_code(message)
	local hud_manager = managers.hud
	if not hud_manager or not hud_manager._hud_code_display then
		return
	end

	local msg_length = string.len(message)
	if msg_length == 2 then
		local r, g, b = look_for_code_parts(message)
		if r or g or b then
			hud_manager._hud_code_display.code = message
			hud_manager._hud_code_display.is_part = true
			hud_manager._hud_code_display.is_rgb = false
		end
	elseif msg_length == 3 then
		if tonumber(message) ~= nil and tonumber(message) >= 0 then
			hud_manager._hud_code_display.code = message
			hud_manager._hud_code_display.is_part = false
			hud_manager._hud_code_display.is_rgb = true
		end
	elseif msg_length == 4 then
		if tonumber(message) ~= nil and tonumber(message) >= 0 then
			hud_manager._hud_code_display.code = message
			hud_manager._hud_code_display.is_part = false
			hud_manager._hud_code_display.is_rgb = false
		end
	end
end

Hooks:PostHook(HUDChat, "receive_message", "receive_message_coh", function(self, name, message, color, icon)
	look_for_code(message)
	if string.lower(message) == "close_code" then
		managers.hud._hud_code_display.close_on_next_update = true
	end
end)

Hooks:PostHook(ChatManager, "send_message", "send_message_coh", function(self, channel_id, sender, message)
	look_for_code(message)
	if string.lower(message) == "close_code" then
		if managers.hud then
			managers.hud._hud_code_display.close_on_next_update = true
		end
	end
end)
