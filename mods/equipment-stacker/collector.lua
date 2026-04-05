local mod_ids = Idstring(ModPath):key()
local loc = _G["g_special_equipment_stacker_loc"]

if not loc.config.collector or not loc.config.stacker then
	return
end

local c = _G["g_special_equipment_stacker"]
local enable_collector = loc.config.collector.toggle
local enable_misc = loc.config.collector.extra_toggle
local range = loc.config.collector.range
local pickup_delay = loc.config.collector.delay

local host = not Network:is_client()
local delay = 0
local used_units = {}
local states = {
	["standard"] = true,
	["carry"] = true
}
local deposit_box_units = {
	["@ID50aac55"] = true, ["@IDe4bc870"] = true, ["@ID51da6d6"] = true, ["@ID8d8c766"] = true,
	["@ID5dcd177"] = true, ["@IDd2d7c5a"] = true, ["@ID7999172"] = true, ["@IDa95e021"] = true, 
	["@IDe93c9b2"] = true						
}

local whitelist_units = {
	["@ID7160913"] = loc.config.collector.secret_items																							--sangres present
}

--add units that you don't want to collect
local blocked_unit_range = {
	["kosugi"] = {	--thermite paste units
		["@ID4053c1d"] = true
		--["@IDcddc222"] = true
	}
}

local whitelist = {
	["money_wrap_single_bundle"] = {enable = loc.config.collector.small_loot},																	--loose money bundles
	["money_wrap_single_bundle_active"] = {enable = loc.config.collector.small_loot},															--loose money bundles grin casino
	["money_wrap_single_chas"] = {enable = loc.config.collector.small_loot},																	--tablet loot
	["tiara_pickup"] = {enable = loc.config.collector.small_loot},																				--tiara
	["sand_ipad"] = {enable = loc.config.collector.small_loot},																					--ukrainian prisoner tablet loot
	["diamond_pickup_pal"] = {enable = loc.config.collector.small_loot},																		--counterfeit necklaces
	["safe_loot_pickup"] = {enable = loc.config.collector.small_loot},																			--neckless in diamond store
	["diamond_pickup"] = {enable = loc.config.collector.small_loot},																			--jewelry diamond store
	["cas_chips_pile"] = {enable = loc.config.collector.small_loot},																			--loose chips grin casino
	["suburbia_necklace_pickup"] = {enable = loc.config.collector.small_loot},																	--necklace jewelry
	["diamond_single_pickup_axis"] = {enable = loc.config.collector.small_loot}, 																--sapphires diamond heist
	["diamond_pickup_axis"] = {enable = loc.config.collector.small_loot, reuse = true},															--jewelry diamond heist
	["mus_pku_artifact"] = {enable = loc.config.collector.small_loot},																			--museum bracelet artifacts
	["red_take_envelope"] = {enable = loc.config.collector.small_loot},   																		--content in safe on first world bank
	["pickup_tablet"] = {enable = loc.config.collector.small_loot},																				--tablet on stealing xmas
	["pickup_phone"] = {enable = loc.config.collector.small_loot},																				--phone on stealing xmas
	["winning_slip"] = {enable = loc.config.collector.small_loot},																				--slot machine ticket
	["gage_assignment"] = {enable = loc.config.collector.secret_items},																			--gage packages
	["press_place_stapler"] = {enable = loc.config.collector.secret_items, name_id = "A Stapler"},												--breakin' feds place stapler
	["hold_take_wrench"] = {enable = loc.config.collector.secret_items, name_id = "A Wrench"},													--shacklethorne wrench
	["hold_take_blueprints"] = {enable = loc.config.collector.secret_items, name_id = "A Blueprint"},											--big oil blueprints
	["take_confidential_folder"] = {enable = loc.config.collector.secret_items, name_id = "A Confidential Folder"},								--big oil confidential folder
	["take_confidential_folder_event"] = {enable = loc.config.collector.secret_items, name_id = "A Confidential Folder"},						--train heist files
	["hold_take_mask"] = {enable = loc.config.collector.secret_items, name_id = "A Mask"},														--stealing xmas hidden masks
	["xm20_int_mask"] = {enable = loc.config.collector.secret_items, reuse = true, name_id = "A Mega Mask"},									--sangres mega mask
	["press_take_folder"] = {enable = loc.config.collector.secret_items, name_id = "A War Document"},											--war document transport
	["hold_pick_up_turtle"] = {enable = loc.config.collector.secret_items, name_id = "A Turtle"},												--turtle heat street
	["press_pick_up"] = {enable = loc.config.collector.secret_items, name_id = "A Gungeon Statue"},												--enter the gungeon statues
	["pick_up_item"] = {enable = loc.config.collector.secret_items, name_id = "A 8th Anniversary Item"},										--8th anniversary items
	["ring_band"] = {enable = loc.config.collector.secret_items, name_id = "A Ring"},															--rings birth of sky
	["mex_pickup_murky_uniforms"] = {enable = loc.config.collector.secret_items, name_id = "A Murky Uniform"},									--murky uniforms border crossing
	["pex_medal"] = {enable = loc.config.collector.secret_items, name_id = "A Medal"},															--medals tijuana
	["hold_take_missing_animal_poster"] = {enable = loc.config.collector.secret_items, name_id = "A Poster"},									--missing animal posters heat street
	["glc_hold_take_handcuffs"] = {enable = loc.config.collector.secret_items, name_id = "Handcuffs"},											--cuffs green bridge
	["hold_pku_knife"] = {enable = loc.config.collector.secret_items, name_id = "A Knife"},														--aftershock knife
	["fex_take_churros"] = {enable = loc.config.collector.secret_items, name_id = "A Churro"},													--buluc's churro
	["pickup_keys"] = {enable = loc.config.collector.secret_items, name_id = "A Arbiter Key"},													--arbiter weapon keys
	["pickup_case"] = {enable = loc.config.collector.secret_items, name_id = "A Arbiter Case"},													--arbiter weapon case
	["bex_take_record_tape"] = {enable = loc.config.collector.secret_items, name_id = "Cassette Tape"},											--tape in deposit boxes on san martin
	["pickup_asset"] = {enable = loc.config.collector.secret_items, name_id = "A Plane Key"},               									--big oil plane keys
	["cash_register"] = {enable = loc.config.collector.cash_register},																			--cash register
	["requires_ecm_jammer_atm"] = {enable = loc.config.collector.requires_ecm_jammer_atm, stealth = true},										--place ecm on atm
	["grenade_briefcase"] = {enable = loc.config.collector.requires_ecm_jammer_atm},															--grenade briefcase go bank, invisible_interaction_open
	["sand_start_defibrillator"] = {enable = loc.config.collector.defibrillator, reuse = true},													--start defibrillator on ukraine prisoner
	["sand_take_paddles"] = {enable = loc.config.collector.defibrillator, reuse = true},														--take paddles on ukraine prisoner
	["sand_place_paddles"] = {enable = loc.config.collector.defibrillator, reuse = true},														--place paddles on ukraine prisoner
	["sand_use_paddles"] = {enable = loc.config.collector.defibrillator, reuse = true},															--use paddles on vlad ukraine prisoner
	["stash_planks_pickup"] = {enable = loc.config.collector.planks},																			--barricade planks
	["pickup_boards"] = {enable = loc.config.collector.planks},																					--barricade boards
	["hold_take_gas_can"] = {enable = loc.config.collector.gas_can},																			--gas can grin casino
	["hold_remove_bug"] = {enable = loc.config.collector.hold_remove_bug},																		--scarface microphone recorder
	["press_take_liquid_nitrogen"] = {enable = loc.config.collector.liquid_nitrogen},															--reservoir dogs liquid nitrogen
	["stash_server_pickup"] = {enable = loc.config.collector.harddrive},																		--framing frame hard drive
	["pickup_harddrive"] = {enable = loc.config.collector.harddrive},																			--hard drive murky station
    ["use_computer"] = {enable = loc.config.collector.mission_objectives, heist = {["framing_frame_3"] = true}},								--framing frame and other heists laptop
	["iphone_answer"] = {enable = loc.config.collector.mission_objectives, heist = {["framing_frame_2"] = true}},								--answer phone framing frame
	["hospital_phone"] = {enable = loc.config.collector.pickup_phone},																			--phone go bank
	["press_insert_sample"] = {enable = loc.config.collector.use_sample, reuse = true},															--use blood sample with validation machine
	["hold_stash_vial"] = {enable = loc.config.collector.use_sample, reuse = true},																--use blood sample with cooler
	["circuit_breaker"] = {enable = loc.config.collector.use_circuit_breaker, reuse = true},													--use circuit breaker
	["hold_circuit_breaker"] = {enable = loc.config.collector.use_circuit_breaker, reuse = true},												--use circuit breaker
	["hold_open_xmas_present"] = {enable = loc.config.collector.hold_open_xmas_present},														--open xmas presents
	["stn_int_place_camera"] = {enable = loc.config.collector.fire_camera, reuse = true},														--firestarter camera place
	["stn_int_take_camera"] = {enable = loc.config.collector.fire_camera, reuse = true},														--firestarter camera take
	["mex_red_room_key"] = {enable = loc.config.collector.fire_camera, reuse = true},															--firestarter camera take
	["lockpick_locker"] = {enable = loc.config.collector.lockpick_locker},																		--pick lockers
	["c4_consume_x1"] = {enable = loc.config.collector.use_c4, reuse = true, heist = {["help"] = true}},										--use c4 prison nightmare
    ["hold_hand_over_chrome_skull"] = {enable = loc.config.collector.chrome_skull, reuse = true},        			 						    --biker heist chrome skull give
    ["hold_born_take_bike_part_y_axis"] = {enable = loc.config.collector.chrome_skull, reuse = true},       									--biker heist chrome skull take
    ["hold_hand_over_tool"] = {enable = loc.config.collector.tool, reuse = true},                         									    --biker heist mechanic tools give
    ["hold_born_search_tools"] = {enable = loc.config.collector.tool, reuse = true},                     			 						    --biker heist mechanic tools search
    ["hold_hand_over_soda"] = {enable = loc.config.collector.soda, reuse = true},                         						    			--biker heist soda give
	["hold_born_receive_item_blow_torch"] = {enable = loc.config.collector.blow_torch, reuse = true},         									--biker heist blow torch
	["hold_search_c4"] = {enable = loc.config.collector.alesso_c4},         																	--search alesso heist c4
	["cas_open_briefcase"] = {enable = loc.config.collector.golden_grin_code},																	--golden grin code briefcases
	["take_keys"] = {enable = loc.config.collector.keychain, reuse = true},																		--place flare (103-107)
	["fex_hold_search_for_clue"] = {enable = loc.config.collector.buluc_clue},																	--buluc's clues
	["fex_pickup_harddrive"] = {enable = loc.config.collector.harddrive, heist = {["fex"] = true}},												--buluc's hd
	["use_flare"] = {enable = loc.config.collector.flare, reuse = true},																		--flare
	["place_flare"] = {enable = loc.config.collector.flare, reuse = true},																		--flare
	["ignite_flare"] = {enable = loc.config.collector.flare, reuse = true},																		--flare
	["bex_activate_flare"] = {enable = loc.config.collector.flare, reuse = true},																--flare
	["hold_open_door"] = {enable = loc.config.collector.closet},																				--cabin closets
	["weapon_case"] = {enable = loc.config.collector.weapon_case},																				--open weapon case
	["weapon_case_axis_z"] = {enable = loc.config.collector.weapon_case},																		--open weapon case
	["weapon_case_not_active"] = {enable = loc.config.collector.weapon_case},																	--open weapon case
	["interaction_ball"] = {enable = loc.config.collector.counterfeit_hose},																	--pull conterfeit water hose
	["disarm_bomb"] = {enable = loc.config.collector.disarm_bomb, reuse = true, heist = {["chas"] = true}},										--disarm bomb
	["press_c4_pku"] = {enable = loc.config.collector.take_disarmed_bomb, reuse = true, heist = {["chas"] = true}},								--take disarmed bomb
	["money_briefcase"] = {enable = loc.config.collector.money_briefcase, reuse = true, heist = {["alex_3"] = true, ["mia_1"] = true}},			--open money briefcase
	["invisible_interaction_open"] = {																											--take loot from atm
		enable = loc.config.collector.requires_ecm_jammer_atm, 
		complicated = true
	},
	["pick_lock_hard_no_skill"] = {																												--deposit boxes
		enable = loc.config.collector.deposit_boxes, stealth = true, unit_name = deposit_box_units
	},
	["pick_lock_deposit_transport"] = {																											--deposit boxes
		enable = loc.config.collector.deposit_boxes, stealth = true, unit_name = deposit_box_units
	}
}
local function is_reusable(name)
	local heist_id = c:heist_id()
	if not c:allow_mod() then
		return false
	elseif c.whitelist[name] ~= nil and (c.whitelist[name].reuse or c.whitelist[name].heist and type(c.whitelist[name].heist[heist_id]) == "table" and c.whitelist[name].heist[heist_id].reuse) then
		return true
	elseif whitelist[name] ~= nil and (whitelist[name].reuse or whitelist[name].heist and type(whitelist[name].heist[heist_id]) == "table" and whitelist[name].heist[heist_id].reuse) then
		return true
	end
end

local function show_msg(tweak_table, name)
	if loc.config.collector.secret_items and whitelist[name] ~= nil and whitelist[name].name_id then
		local item_name = whitelist[name].name_id
		local prefix = "You picked up"
		local string_f = string.format("%s %s", prefix, item_name)
		managers.hud:show_hint({time = 5, text = string_f})
	end
end

local function can_interact_unit(unit_id, tweak)
	if whitelist_units[unit_id] then
		return true
	elseif whitelist[tweak] ~= nil and (not whitelist[tweak].unit_name or whitelist[tweak].unit_name[unit_id]) then
		return true
	end
end

local function can_pickup_unit(unit_id, equipment_name)
	if not c.use_whitelist or c.whitelist[equipment_name] ~= nil and (not c.whitelist[equipment_name].unit_name or c.whitelist[equipment_name].unit_name[unit_id]) then
		return true
	end
end

local function can_interact_item(name, tweak_table)
	if enable_misc and whitelist[name] and (whitelist[name].enable or whitelist[name].complicated) then
		local whisper = managers.groupai and managers.groupai:state() and managers.groupai:state():whisper_mode()
		if tweak_table.timer and tonumber(tweak_table.timer) > 2 and not host then
			return false
		elseif whitelist[name].heist and type(whitelist[name].heist[c:heist_id()]) == "boolean" and not whitelist[name].heist[c:heist_id()] then
			return false
		elseif whitelist[name].stealth and not whisper then
			return false
		end
		return true
	end
end

local function can_pickup_item(name)
	if enable_collector and (not c.use_whitelist or c.whitelist[name] and c.whitelist[name].enable) then
		local can_pickup, has_max_quantity = managers.player:can_pickup_equipment(name)
		if c.use_whitelist and c.whitelist[name].host and not host then
			return false
		elseif c.use_whitelist and c.whitelist[name].heist and type(c.whitelist[name].heist[c:heist_id()]) == "boolean" and not c.whitelist[name].heist[c:heist_id()] then
			return false
		elseif not can_pickup then
			return false
		end
		return true
	end
end

local function check_obstruction(unit, interaction, player_unit, movement)
	if c.ignored_obstruction_units[unit:id()] then
		return
	end

	local check_objects = not loc.config.collector.interact_through_walls and unit:raycast("ray", interaction:interact_position(), movement:m_head_pos(), "slot_mask", managers.slot:get_mask("bullet_impact_targets"), "thickness_mask", managers.slot:get_mask("interaction_obstruction"))

	if not check_objects then
		return true
	else
		local distance = mvector3.distance(player_unit:position(), unit:position()) -- wall thickness

		if not interaction:interact_axis() or distance < 50 then
			return true
		end
	end
	
	c.ignored_obstruction_units[unit:id()] = true
end

local function find_blocked_unit_range(unit)
	local heist_id = c:heist_id()
	local unit_id = string.sub(unit:name():t(), 1, 10)
	if not used_units[unit:key()] and blocked_unit_range[heist_id] and blocked_unit_range[heist_id][unit_id] then
		used_units[unit:key()] = true
	end
end

local function collector(self)
	local player_unit = self._unit

	for _, unit in pairs(World:find_units_quick("sphere", player_unit:camera()._m_cam_pos, range, 1, 14, 20)) do
		local interaction = alive(unit) and unit.interaction and unit:interaction()
		local tweak = interaction and interaction:active() and not interaction:disabled() and interaction.tweak_data

		if type(tweak) == "string" then
			local tweak_table = tweak_data.interaction[tweak]
			local raycast = tweak_table and check_obstruction(unit, interaction, player_unit, self)

			if raycast and (states[self._current_state_name] or tweak_table.requires_mask_off_upgrade) then
				local equipment_name = interaction._special_equipment or type(tweak_table.special_equipment_block) == "string" and tweak_table.special_equipment_block
				find_blocked_unit_range(unit)

				if (not used_units[unit:key()] or is_reusable(equipment_name or tweak)) then
					--managers.mission._fading_debug_output:script().log(string.format("%s %s", tostring(equipment_name or 0), tostring(tweak or 0)), Color.green)
					local unit_id = string.sub(unit:name():t(), 1, 10)
					
					if (equipment_name and can_pickup_item(equipment_name) and can_pickup_unit(unit_id, equipment_name) or not equipment_name and can_interact_item(tweak, tweak_table) and can_interact_unit(unit_id, tweak)) then
						used_units[unit:key()] = true
						return interaction:interact(player_unit), show_msg(tweak_table, tweak)
					end
				end
			end
		end
	end
end

Hooks:PostHook(PlayerMovement, "update", "1_"..Idstring(mod_ids):key(), function(self, unit, t, ...)
	if alive(self._unit) and (not delay or t - delay > pickup_delay) and (enable_collector or enable_misc) and c:check_host_only(true) then
		delay = t
		collector(self)
	end
end)