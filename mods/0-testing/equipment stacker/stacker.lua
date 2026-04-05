local class_name = "g_special_equipment_stacker"
local mod_name = "Equipment Stacker"
local identifier = string.format("%s_mod_identifier1712", class_name)
local req_script = RequiredScript:gsub(".+/(.+)", "%1")
local loc = _G["g_special_equipment_stacker_loc"]

if not loc or not loc.config or not loc.config.stacker then
	return
end

local host = not Network:is_client()
local singleplayer = Global.game_settings and Global.game_settings.single_player
local loaded = rawget(_G, class_name)
local c = loaded or rawset(_G, class_name, {
	orig_equipment_data = {},
	max_amount = 20,								-- If whitelist is set to false, use this
	amount_to_pickup = 1,							-- If whitelist is set to false, use this
	bypass_identifier = false,						-- Set to true to not check if others have the mod
	identifier_removes_items = true,				-- Set to false to not try to remove your stacks when bypass_identifier is false and others join you
	can_stack_very_special_equipment = true,		-- Set to true to be able to stack most items or false for keycards e.g
	use_whitelist = true,							-- Set to false to stack every possible item
	whitelist = {},
	ignored_obstruction_units = {},
	
	--identifier
	peers_with_mod = {},
	peers_in_lobby = {},
	peer_msg = {},
	notify_mod_allowed = false						-- Does nothing for you
}) and _G[class_name]

if not loaded then
	local plate_units = {
		["@ID6fc5dce"] = false, ["@IDc4a2bfd"] = true	--machine (turned off) and safe pickups on counterfeit			
	}
	
	--stacker
	c.whitelist["bank_manager_key"] = {enable = loc.config.stacker.bank_manager_key, max_amount = 2 + loc.config.stacker.amount}
	c.whitelist["hotel_room_key"] = {enable = loc.config.stacker.bank_manager_key, max_amount = 2 + loc.config.stacker.amount}
	c.whitelist["blood_sample"] = {enable = loc.config.stacker.blood_sample, reuse = true, max_amount = 4 + loc.config.stacker.amount}
	c.whitelist["blood_sample_verified"] = {enable = loc.config.stacker.blood_sample_verified, reuse = true, max_amount = 2}
	c.whitelist["gas"] = {enable = loc.config.stacker.gas, max_amount = 2 + loc.config.stacker.amount}
	c.whitelist["liquid_nitrogen"] = {enable = loc.config.stacker.liquid_nitrogen, max_amount = 2}
	c.whitelist["printer_ink"] = {enable = loc.config.stacker.printer_ink, max_amount = 2 + loc.config.stacker.amount}
	c.whitelist["paper_roll"] = {enable = loc.config.stacker.paper_roll, max_amount = 2 + loc.config.stacker.amount}
	c.whitelist["lance_part"] = {enable = loc.config.stacker.lance_part, max_amount = 3 + loc.config.stacker.amount}
	c.whitelist["thermite_paste"] = {enable = loc.config.stacker.thermite_paste, max_amount = 2}
	c.whitelist["thermite"] = {enable = loc.config.stacker.thermite, max_amount = 2, 
		heist = {
			["red2"] = {host = true}
		}
	}
	c.whitelist["circle_cutter"] = {enable = loc.config.stacker.circle_cutter, max_amount = 9, amount_to_pickup = 1}
	c.whitelist["mayan_gold_bar"] = {enable = loc.config.stacker.mayan_gold_bar, max_amount = 16}
	c.whitelist["acid"] = {enable = loc.config.stacker.acid, max_amount = 2 + loc.config.stacker.amount}
	c.whitelist["caustic_soda"] = {enable = loc.config.stacker.caustic_soda, max_amount = 2 + loc.config.stacker.amount}
	c.whitelist["hydrogen_chloride"] = {enable = loc.config.stacker.hydrogen_chloride, max_amount = 2 + loc.config.stacker.amount}
	c.whitelist["harddrive"] = {enable = loc.config.stacker.harddrive, max_amount = 2}
	c.whitelist["planks"] = {enable = loc.config.stacker.planks, max_amount = 2 + loc.config.stacker.amount}
	c.whitelist["boards"] = {enable = loc.config.stacker.boards, max_amount = 2 + loc.config.stacker.amount}
	c.whitelist["c4"] = {enable = loc.config.stacker.c4,
		heist = {
			["dark"] = false,
			["flat"] = {reuse = true, max_amount = 9, amount_to_pickup = 9}, 
			["pbr"] = {reuse = true, max_amount = 6, amount_to_pickup = 6}, 
			["mad"] = {reuse = true, max_amount = 4, amount_to_pickup = 4}, 
			["cage"] = {max_amount = 4, amount_to_pickup = 4},
			["kenaz"] = {reuse = true, amount_to_pickup = 8}	-- max is also taken from amount_to_pickup
		}
	}
	c.whitelist["c4_x3"] = {enable = loc.config.stacker.c4, max_amount = 6, heist = {
			["dark"] = false,
			["moon"] = {reuse = true, amount_to_pickup = 6},
			["rvd2"] = {reuse = true, amount_to_pickup = 3}
		}
	}
	c.whitelist["crowbar"] = {enable = loc.config.stacker.crowbar, 
		heist = {
			["shoutout_raid"] = {max_amount = 4}
		}
	}
	c.whitelist["saw"] = {enable = loc.config.stacker.saw < 3 or false, max_amount = 3, heist = {["jolly"] = true, ["nmh"] = true, ["rvd1"] = true}}
	c.whitelist["evidence"] = {enable = loc.config.stacker.evidence, max_amount = 3 + loc.config.stacker.amount, heist = {["hox_2"] = true}}
	c.whitelist["blow_torch"] = {enable = loc.config.stacker.blow_torch, max_amount = 2, heist = {["pbr"] = false}}
	
	--collector
	c.whitelist["cas_winch_hook"] = {enable = loc.config.collector.winch_hook, max_amount = 1}
	c.whitelist["defibrillator_paddles"] = {enable = loc.config.collector.defibrillator, reuse = true, max_amount = 1, heist = {["sand"] = true}}
	c.whitelist["server"] = {enable = loc.config.collector.harddrive, max_amount = 1, heist = {["framing_frame_3"] = true}}
	c.whitelist["globe"] = {enable = loc.config.collector.mission_objectives, max_amount = 1, heist = {["fex"] = true}}
	c.whitelist["fertilizer"] = {enable = loc.config.collector.mission_objectives, max_amount = 1, heist = {["fex"] = true}}
	c.whitelist["alarm_clock"] = {enable = loc.config.collector.mission_objectives, max_amount = 1, heist = {["fex"] = true}}
	c.whitelist["scythe"] = {enable = loc.config.collector.mission_objectives, max_amount = 1, heist = {["fex"] = true}}
	c.whitelist["wire"] = {enable = loc.config.collector.mission_objectives, max_amount = 1, heist = {["fex"] = true}}
	c.whitelist["diesel"] = {enable = loc.config.collector.mission_objectives, max_amount = 3}
	c.whitelist["plates"] = {enable = loc.config.collector.plates, max_amount = 1, unit_name = plate_units, heist = {
			["pal"] = {reuse = true, amount_to_pickup = 1}
		}
	}
	c.whitelist["stapler"] = {enable = loc.config.collector.secret_items, max_amount = 1}
	c.whitelist["cas_sleeping_gas"] = {enable = loc.config.collector.cas_sleeping_gas, max_amount = 1}
	c.whitelist["cas_usb_key"] = {enable = loc.config.collector.cas_usb_key, max_amount = 1}
	c.whitelist["pex_unloaded_card"] = {enable = loc.config.collector.pex_unloaded_card, max_amount = 1}
	c.whitelist["pex_cutter"] = {enable = loc.config.collector.pex_cutter, max_amount = 1}
	c.whitelist["police_uniform"] = {enable = loc.config.collector.police_uniform, max_amount = 1}
	c.whitelist["keychain"] = {enable = loc.config.collector.keychain, max_amount = 1, heist = {["pex"] = false}}
	c.whitelist["chavez_key"] = {enable = loc.config.collector.keychain, max_amount = 1}
	c.whitelist["chas_keychain_forklift"] = {enable = loc.config.collector.keychain, max_amount = 1}
	c.whitelist["briefcase"] = {enable = loc.config.collector.briefcase, max_amount = 1}
	c.whitelist["adrenaline"] = {enable = loc.config.collector.adrenaline, max_amount = 1}
	c.whitelist["manifest"] = {enable = loc.config.collector.manifest, max_amount = 1}
	c.whitelist["chimichanga"] = {enable = loc.config.collector.chimichanga, max_amount = 1}
	c.whitelist["medallion"] = {enable = loc.config.collector.medallion, max_amount = 1}
	c.whitelist["president_key"] = {enable = loc.config.collector.president_key, max_amount = 1}
	c.whitelist["fire_extinguisher"] = {enable = loc.config.collector.fire_extinguisher, max_amount = 1, heist = {["arena"] = true}}
	c.whitelist["c4_stackable"] = {enable = loc.config.collector.take_disarmed_bomb, reuse = true, heist = {["chas"] = true}}
	c.whitelist["c4_x1"] = {enable = loc.config.collector.use_c4, max_amount = 1, heist = {
			["help"] = {reuse = true, amount_to_pickup = 1}
		}
	}
	c.whitelist["chrome_skull"] = {enable = loc.config.stacker.chrome_skull, max_amount = 1}
	c.whitelist["soda"] = {enable = loc.config.stacker.soda, max_amount = 1}
	c.whitelist["tool"] = {enable = loc.config.stacker.tool, max_amount = 1}
	c.whitelist["hand"] = {enable = loc.config.stacker.collector_hand, max_amount = 1}
	
	function c:count_table(t)
		local count = 0
		for _ in pairs(t) do 
			count = count + 1 
		end
		return count
	end

	function c:heist_id()
		local heist = managers.job and managers.job.current_level_id and managers.job:current_level_id()
		if heist then
			return heist
		end
		return ""
	end

	function c:show_hint(toggle)
		if managers.hud and managers.hud.show_hint and toggle ~= self.notify_mod_allowed and not self.bypass_identifier then
			self.notify_mod_allowed = toggle
			local toggle_s = toggle and "Activated" or "Deactivated"
			local string_f = string.format("%s %s", mod_name, toggle_s)
			managers.hud:show_hint({time = 3, text = string_f})
			
			if not toggle then
				self:remove_equipment()
			end
		end
	end

	function c:remove_equipment()
		--transfer or remove excess equipmentwhen mod not allowed
		if host and self.identifier_removes_items then
			for names, equipments in pairs(self.orig_equipment_data) do
				local equipment = names and tweak_data.equipments.specials[names]
				local special_equipment = managers.player:has_special_equipment(names)
				if equipment and special_equipment and self.use_whitelist and self.orig_equipment_data[names] ~= nil then
					local transfer = self.orig_equipment_data[names].transfer_quantity and self.orig_equipment_data[names].transfer_quantity / 2
					local special_amount = special_equipment.amount and Application:digest_value(special_equipment.amount, false)
					if self.whitelist[names] ~= nil and special_amount and special_amount ~= -1 and special_amount > 1 then
						if transfer and transfer >= special_amount then
							local session = managers.network and managers.network:session()
							local local_id = session and session:local_peer() and session:local_peer():id()
							if session and local_id then
								for x = 1, 4 do
									local is_x_equipment = managers.player:get_synced_equipment_possession(x)
									local no_x_amount = is_x_equipment and not is_x_equipment[names]
									if no_x_amount and session:peer(x) and local_id ~= x and alive(session:peer(x):unit()) then
										local new_amount = special_amount / 2
										session:peer(x):send("give_equipment", names, new_amount, true)
										for i = 1, new_amount - 1 do
											managers.player:remove_special(names)
										end
									end
								end
							end
						else
							for i = 1, special_amount - 1 do
								managers.player:remove_special(names)
							end
						end
					end
					
					if equipment.max_quantity and self.orig_equipment_data[names].max_quantity then
						equipment.max_quantity = self.orig_equipment_data[names].max_quantity
					end
					
					if equipment.quantity and self.orig_equipment_data[names].quantity then
						equipment.quantity = self.orig_equipment_data[names].quantity
					end
				end
			end
		end
	end

	function c:remove_peer(peer_id)
		if self.peers_in_lobby[peer_id] ~= nil then
			self.peers_in_lobby[peer_id] = nil
		end

		if self.peers_with_mod[peer_id] ~= nil then
			self.peers_with_mod[peer_id] = nil
		end
	end

	function c:add_peer_to_mod(peer_id)
		if self.peers_with_mod[peer_id] == nil then
			self.peers_with_mod[peer_id] = peer_id
		end
	end

	function c:add_peer_to_lobby(peer_id)
		if self.peers_in_lobby[peer_id] == nil then
			self.peers_in_lobby[peer_id] = peer_id
		end
	end

	function c:peer_allows_mod()
		local session = managers.network and managers.network:session()
		local local_id = session and session:local_peer() and session:local_peer():id()
		if session and local_id then
			for x = 1, 4 do
				if session:peer(x) and local_id ~= x then
					self:add_peer_to_lobby(x)
				end
			end
		end
		
		if self:count_table(self.peers_in_lobby) > self:count_table(self.peers_with_mod) then
			return false, self:show_hint(false)
		end
		return true, self:show_hint(true)
	end

	function c:check_host_only(collector)
		if loc.config.stacker.toggle or collector then
			if loc.config.stacker.host_only then
				if (singleplayer or host) then
					return true
				end
			else
				return true
			end
		end
	end
	
	function c:allow_mod()
		if self.bypass_identifier then
			return true
		end
		
		if self:check_host_only() then
			local matchmake = managers.network and managers.network.matchmake and managers.network.matchmake.lobby_handler
			local filter_permissions = matchmake and matchmake:get_lobby_data() ~= nil and matchmake:get_lobby_data().permission
			local peer_allows_mod = self:peer_allows_mod()
			if singleplayer or (filter_permissions and tonumber(filter_permissions) ~= 1) or peer_allows_mod then
				return true
			end
		end
	end

	function c:check_whitelist(name)
		if self:allow_mod() and (not self.use_whitelist or self.whitelist[name] ~= nil and self.whitelist[name].enable) then
			local current_amount = managers.player._equipment.specials[name] ~= nil and managers.player._equipment.specials[name].amount and Application:digest_value(managers.player._equipment.specials[name].amount, false)
			local heist_id = self:heist_id()
			if self.use_whitelist and (self.whitelist[name].host or c.whitelist[name].heist and type(c.whitelist[name].heist[heist_id]) == "table" and c.whitelist[name].heist[heist_id].host) and not host then
				return false
			elseif self.use_whitelist and self.whitelist[name].heist and type(self.whitelist[name].heist[heist_id]) == "boolean" and not self.whitelist[name].heist[heist_id] then
				return false
			elseif current_amount and (not self.use_whitelist and current_amount == self.max_amount or self.use_whitelist and (c.whitelist[name].heist and type(c.whitelist[name].heist[heist_id]) == "table" and c.whitelist[name].heist[heist_id].max_amount and current_amount == c.whitelist[name].heist[heist_id].max_amount or self.whitelist[name].max_amount and current_amount == self.whitelist[name].max_amount)) then
				return false
			end
			return true
		end
	end
	 
	function c:check_has_special_equipment_block_name(name, player)
		local equipment = name and tweak_data.equipments.specials[name]
		if equipment and self.can_stack_very_special_equipment and self:check_whitelist(name) and (not player or player:key() == managers.player:player_unit():key()) then
			local t = tweak_data.interaction
			for k, v in pairs(t) do
				if type(k) == "string" and type(t[k]) == "table" then
					if type(t[k].special_equipment_block) == "string" and t[k].special_equipment_block == name then
						return true
					elseif type(t[k].special_equipment_block) == "table" and t[k].special_equipment_block[name] ~= nil then
						return true
					end
				end
			end
		end
	end

	function c:set_max_amount(equipment, name, amount, pickup)
		if type(amount) ~= "nil" then
			equipment.max_quantity = amount or self.max_amount
		end
		
		if type(pickup) ~= "nil" then
			equipment.quantity = pickup or self.amount_to_pickup
		end
	end
end

if string.lower(req_script) == string.lower("interactionext") and _G["BaseInteractionExt"] ~= nil then
	local orig_func_b_can_interact = BaseInteractionExt.can_interact
	local orig_func_b_can_select = BaseInteractionExt.can_select
	
	function UseInteractionExt:can_select(player, ...) 
		return orig_func_b_can_select(self, player, ...) or c:check_has_special_equipment_block_name(self._tweak_data.special_equipment_block, player)
	end

	function UseInteractionExt:can_interact(player, ...)
		return orig_func_b_can_interact(self, player, ...) or c:check_has_special_equipment_block_name(self._tweak_data.special_equipment_block, player)
	end
elseif string.lower(req_script) == string.lower("PlayerManager") and _G["PlayerManager"] ~= nil then
	Hooks:PreHook(PlayerManager, "add_special", class_name.."4", function(self, params)
		if c:allow_mod() then
			local name = params.equipment or params.name
			local equipment = name and tweak_data.equipments.specials[name]
			if equipment and (not equipment.max_quantity or equipment.max_quantity <= 1 or not equipment.quantity or equipment.quantity <= 0) then
				if c:check_whitelist(name) then
					if c.orig_equipment_data[name] == nil then
						c.orig_equipment_data[name] = {max_quantity = equipment.max_quantity, quantity = equipment.quantity, transfer_quantity = equipment.transfer_quantity}
					end
					local heist_id = c:heist_id()
					c:set_max_amount(equipment, name, (c.use_whitelist and (c.whitelist[name].heist and type(c.whitelist[name].heist[heist_id]) == "table" and c.whitelist[name].heist[heist_id].max_amount or c.whitelist[name].max_amount) or not c.use_whitelist and false or equipment.max_quantity), (c.use_whitelist and (c.whitelist[name].heist and (type(c.whitelist[name].heist[heist_id]) == "number" and c.whitelist[name].heist[heist_id] or type(c.whitelist[name].heist[heist_id]) == "table" and c.whitelist[name].heist[heist_id].amount_to_pickup) or not c.use_whitelist and c.whitelist[name].amount_to_pickup or equipment.quantity) or false))
				end
			end
		end
	end)
elseif string.lower(req_script) == string.lower("GamePlayCentralManager") and _G["GamePlayCentralManager"] ~= nil then
	Hooks:PostHook(GamePlayCentralManager, 'start_heist_timer', class_name.."5", function(self)
		if loc.config.stacker.saw == 2 and c:allow_mod() and host then
			local heist_id = c:heist_id()
			if heist_id == "nmh" then
				managers.player:add_special({name = "saw", amount = 2, silent = true})
			elseif heist_id == "jolly" then
				managers.player:add_special({name = "saw", amount = 1, silent = true})
			elseif heist_id == "rvd1" then
				managers.player:add_special({name = "saw", amount = 2, silent = true})
			end
		end
	end)
elseif string.lower(req_script) == string.lower("coremissionscriptelement") and _G["MissionScriptElement"] ~= nil then
	local orig_function_init = MissionScriptElement.init
	function MissionScriptElement:init(...)
		orig_function_init(self, ...)
		if loc.config.stacker.saw == 2 and c:heist_id() == "nmh" and self._id == 102330 then
			self._values.enabled = false
		end
	end
elseif string.lower(req_script) == string.lower("networkaccountsteam") and not c.bypass_identifier then
	--create identifier host side
	Hooks:PostHook(NetworkAccountSTEAM, '_set_presences', class_name.."7", function(self)
		if SystemInfo:distribution() == Idstring("STEAM") then
			Steam:set_rich_presence(identifier, 1)
		end
	end)
elseif string.lower(req_script) == string.lower("BaseNetworkSession") and not c.bypass_identifier then
	Hooks:PostHook(BaseNetworkSession, 'on_load_complete', class_name.."8", function(self, simulation)
		if SystemInfo:distribution() == Idstring("STEAM") and not simulation then
			Steam:set_rich_presence(identifier, 1)
			
			--client side join check for identifier
			if c:check_host_only() then
				for peer_id, peer in pairs(self._peers) do
					DelayedCalls:Add("on_load_complete_client"..tostring(peer._user_id or math.random()), 10, function()
						if peer and peer:ip_verified() then
							local user = Steam:user(peer:ip())
							if user and user:rich_presence(identifier) == "1" then
								c:add_peer_to_mod(peer_id)
								if managers.chat and c.peer_msg[peer:user_id()] == nil and c:count_table(c.peers_in_lobby) == c:count_table(c.peers_with_mod) then
									c.peer_msg[peer:user_id()] = true
									managers.chat:feed_system_message(ChatManager.GAME, string.format("'%s' detected from %s.", mod_name, peer:name()))
								end
							end
						end
					end)
				end
			end
		end
	end)

	--remove peer on leave/disconnect client/host
	Hooks:PostHook(BaseNetworkSession, '_on_peer_removed', class_name.."9", function(self, peer, peer_id)
		c:remove_peer(peer_id)
	end)
elseif string.lower(req_script) == string.lower("NetworkManager") and not c.bypass_identifier then	
	Hooks:PostHook(NetworkManager, 'on_peer_added', class_name.."10", function(self, peer, peer_id)
		local local_id = self:session() and self:session():local_peer() and self:session():local_peer():id()
		if SystemInfo:distribution() == Idstring("STEAM") and peer and local_id and local_id ~= peer_id then
			c:add_peer_to_lobby(peer_id)
			
			--host/client side check for identifier
			if host and c:check_host_only() then
				DelayedCalls:Add("on_load_complete_host"..tostring(peer._user_id or math.random()), 10, function()
					local user = peer:ip_verified() and Steam:user(peer:ip())
					if user then
						if user:rich_presence(identifier) == "1" then
							c:add_peer_to_mod(peer_id)
							if c.peer_msg[peer:user_id()] == nil and c:count_table(c.peers_in_lobby) == c:count_table(c.peers_with_mod) then
								c.peer_msg[peer:user_id()] = true
								managers.chat:feed_system_message(ChatManager.GAME, string.format("%s also got '%s' mod installed!", peer:name(), mod_name))
							end
						end
					end
				end)
			end
		end
	end)
end