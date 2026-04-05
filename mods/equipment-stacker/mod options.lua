local class_name = "g_special_equipment_stacker"
local loc = _G[class_name.."_loc"]

if not loc.config.stacker or not loc.config.collector then
	return
end

Hooks:Add("LocalizationManagerPostInit", class_name.."Loc", function(loc)
	local string_f = "Toggle if this item will stack and collect or not."
	local string_f_2 = "Toggle if this item should be collected/interacted with."
	
	LocalizationManager:add_localized_strings({
		[class_name.."_menu_title"] = "Equipment Stacker",
		[class_name.."_menu_desc"] = "Toggle item stacks.",
		
		
		["toggle_stacker_title"] = "Toggle Stacker",
		["toggle_stacker_desc"] = "Toggle if you want to stack equipment or not.",
		["toggle_host_title"] = "Toggle Stacker/Collector Host",
		["toggle_host_desc"] = "Toggle if you want to stack/collect equipment when host and singleplayer only or not.",
		["stacker_amount_title"] = "Equipment Stack Amount",
		["stacker_amount_desc"] = "Stack more then default values, this adds the value on top of the values bellow. Works only for some equipment.",
		["collector_toggle_title"] = "Equipment Collector",
		["collector_toggle_desc"] = "Automatically collect special equipment around a radious of default 30 meter.",
		["collector_toggle_extra_title"] = "Misc Collector",
		["collector_toggle_extra_desc"] = "Automatically collect and interact with various other items listed bellow at a range of default 30 meter.",
		["collector_range_title"] = "Collector Range",
		["collector_range_desc"] = "The range between you and the item in meter.",
		["collector_delay_title"] = "Collector Delay",
		["collector_delay_desc"] = "The delay from when you are in range of an item to the item is getting collected in milliseconds.",
		["collector_wall_hack_title"] = "Collector Through Walls",
		["collector_wall_hack_desc"] = "Toggle if you can interact with items through walls or not.",
		
		["bank_manager_key_title"] = "Stacker - Keycard  (2)",
		["bank_manager_key_desc"] = string_f,
		["blood_sample_title"] = "Stacker - Blood Sample  (4)",
		["blood_sample_desc"] = string_f,
		["blood_sample_verified_title"] = "Stacker - Blood Sample Verified  (2)",
		["blood_sample_verified_desc"] = string_f,
		["gas_title"] = "Stacker - Gasoline  (2)",
		["gas_desc"] = string_f,
		["liquid_nitrogen_title"] = "Stacker - Nitrogen  (2)",
		["liquid_nitrogen_desc"] = string_f,
		["printer_ink_title"] = "Stacker - Ink  (2)",
		["printer_ink_desc"] = string_f,
		["paper_roll_title"] = "Stacker - Paper Roll  (2)",
		["paper_roll_desc"] = string_f,
		["lance_part_title"] = "Stacker - Lance Part  (3)",
		["lance_part_desc"] = string_f,
		["thermite_paste_title"] = "Stacker - Thermite Paste  (2)",
		["thermite_paste_desc"] = string_f,
		["circle_cutter_title"] = "Stacker - Circle Cutter  (9)",
		["circle_cutter_desc"] = string_f,
		["mayan_gold_bar_title"] = "Stacker - Mayan Gold  (16)",
		["mayan_gold_bar_desc"] = string_f,
		["acid_title"] = "Stacker - Muriatic Acid  (2)",
		["acid_desc"] = string_f,
		["caustic_soda_title"] = "Stacker - Caustic Soda  (2)",
		["caustic_soda_desc"] = string_f,
		["hydrogen_chloride_title"] = "Stacker - Hydrogen Chloride  (2)",
		["hydrogen_chloride_desc"] = string_f,
		["harddrive_title"] = "Stacker - Hard Drive  (2)",
		["harddrive_desc"] = string_f,
		["planks_title"] = "Stacker - Plank  (2)",
		["planks_desc"] = string_f,
		["boards_title"] = "Stacker - Board  (2)",
		["boards_desc"] = string_f,
		["thermite_title"] = "Stacker - Thermite Can  (2)",
		["thermite_desc"] = string_f,
		["c4_title"] = "Stacker - C4  (6-9)",
		["c4_desc"] = string_f,
		["crowbar_title"] = "Stacker - Crowbar  (4)",
		["crowbar_desc"] = string_f,
		["no_mercy_extra_saws_title"] = "Stacker - Extra Saws No Mercy  (2)",
		["no_mercy_extra_saws_desc"] = string_f_2,
		["evidence_title"] = "Stacker - Evidence  (3)",
		["evidence_desc"] = string_f,
		["blow_torch_title"] = "Stacker - Blow Torch  (2)",
		["blow_torch_desc"] = string_f,			
		["saw_title"] = "Stacker - Saw  (3)",
		["saw_desc"] = string_f.." Stack/Get saws option only works on no mercy and aftershock.",
			["saw_only_sub_title"] = "Stack Saws Only",
			["saw_and_extra_sub_title"] = "Stack/Get Saws",
			["no_saw_sub_title"] = "Disable",
		
		["collector_small_loot_title"] = "Collector - Small Loot",
		["collector_small_loot_desc"] = string_f_2,
		["collector_secret_items_title"] = "Collector - Hidden Items",
		["collector_secret_items_desc"] = string_f_2,
		["collector_cash_register_title"] = "Collector - Open Cash Register",
		["collector_cash_register_desc"] = string_f_2,
		["collector_requires_ecm_jammer_atm_title"] = "Collector - ATMs",
		["collector_requires_ecm_jammer_atm_desc"] = string_f_2,
		["collector_defibrillator_title"] = "Collector - Defibrillator",
		["collector_defibrillator_desc"] = string_f_2,
		["collector_planks_title"] = "Collector - Planks",
		["collector_planks_desc"] = string_f_2,
		["collector_gas_can_title"] = "Collector - Gas Can",
		["collector_gas_can_desc"] = string_f_2,
		["collector_liquid_nitrogen_title"] = "Collector - Nitrogen",
		["collector_liquid_nitrogen_desc"] = string_f_2,
		["collector_harddrive_title"] = "Collector - Hard Drive",
		["collector_harddrive_desc"] = string_f_2,
		["collector_mission_objectives_title"] = "Collector - Mission Objectives",
		["collector_mission_objectives_desc"] = string_f_2,
		["collector_pickup_phone_title"] = "Collector - Pickup Phone",
		["collector_pickup_phone_desc"] = string_f_2,
		["collector_deposit_boxes_title"] = "Collector - Deposit Boxes",
		["collector_deposit_boxes_desc"] = string_f_2,
		["collector_use_sample_title"] = "Collector - Use Blood Samples",
		["collector_use_sample_desc"] = string_f_2,
		["collector_use_circuit_breaker_title"] = "Collector - Use Circuit Breaker",
		["collector_use_circuit_breaker_desc"] = string_f_2,
		["collector_fire_camera_title"] = "Collector - Firestarter Camera",
		["collector_fire_camera_desc"] = string_f_2,
		["collector_hold_remove_bug_title"] = "Collector - Scarface Mic Recorder",
		["collector_hold_remove_bug_desc"] = string_f_2,
		["collector_hold_open_xmas_present_title"] = "Collector - Open Xmas Presents",
		["collector_hold_open_xmas_present_desc"] = string_f_2,
		["collector_cas_sleeping_gas_title"] = "Collector - Sleeping Gas",
		["collector_cas_sleeping_gas_desc"] = string_f_2,
		["collector_cas_usb_key_title"] = "Collector - USB",
		["collector_cas_usb_key_desc"] = string_f_2,
		["collector_pex_unloaded_card_title"] = "Collector - RFID Tag",
		["collector_pex_unloaded_card_desc"] = string_f_2,
		["collector_pex_cutter_title"] = "Collector - Bolt Cutter",
		["collector_pex_cutter_desc"] = string_f_2,
		["collector_police_uniform_title"] = "Collector - Tijuana Police Uniform",
		["collector_police_uniform_desc"] = string_f_2,
		["collector_keychain_title"] = "Collector - Keys",
		["collector_keychain_desc"] = string_f_2,
		["collector_briefcase_title"] = "Collector - Briefcase",
		["collector_briefcase_desc"] = string_f_2,
		["collector_adrenaline_title"] = "Collector - Adrenaline",
		["collector_adrenaline_desc"] = string_f_2,
		["collector_manifest_title"] = "Collector - Cargo Manifest",
		["collector_manifest_desc"] = string_f_2,
		["collector_chimichanga_title"] = "Collector - Breakin' Feds Chimichanga",
		["collector_chimichanga_desc"] = string_f_2,
		["collector_medallion_title"] = "Collector - Brooklyn Bank Medallion",
		["collector_medallion_desc"] = string_f_2,
		["collector_plates_title"] = "Collector - Counterfeit Plates",
		["collector_plates_desc"] = string_f_2,
		["collector_lockpick_locker_title"] = "Collector - Use Lockers",
		["collector_lockpick_locker_desc"] = string_f_2,
		["collector_president_key_title"] = "Collector - President Keycard",
		["collector_president_key_desc"] = string_f_2,
		["collector_use_c4_title"] = "Collector - Prison Nightmare C4",
		["collector_use_c4_desc"] = string_f_2,
		["collector_chrome_skull_title"] = "Collector - Bike Chrome Skull",
        ["collector_chrome_skull_desc"] = string_f_2,
        ["collector_soda_title"] = "Collector - Mechanic Soda",
        ["collector_soda_desc"] = string_f_2,
        ["collector_tool_title"] = "Collector - Mechanic Tools",
        ["collector_tool_desc"] = string_f_2,
		["collector_blow_torch_title"] = "Collector - Blow Torch",
        ["collector_blow_torch_desc"] = string_f_2,
		["collector_hand_title"] = "Collector - Xun Kang's Hand",
        ["collector_hand_desc"] = string_f_2,
		["collector_alesso_c4_title"] = "Collector - Alesso C4",
        ["collector_alesso_c4_desc"] = string_f_2,	
		["collector_golden_grin_code_title"] = "Collector - Golden Grin Codes",
        ["collector_golden_grin_code_desc"] = string_f_2,	
		["collector_winch_hook_title"] = "Collector - Winch Hook",
        ["collector_winch_hook_desc"] = string_f_2,	
		["collector_buluc_clue_title"] = "Collector - Buluc's Clues",
        ["collector_buluc_clue_desc"] = string_f_2,	
		["collector_closet_title"] = "Collector - Cabin Closet",
        ["collector_closet_desc"] = string_f_2,	
		
		["collector_fire_extinguisher_title"] = "Collector - Fire Extinguisher",
        ["collector_fire_extinguisher_desc"] = string_f_2,
		["collector_money_briefcase_title"] = "Collector - Money Briefcase",
        ["collector_money_briefcase_desc"] = string_f_2,
		["collector_disarm_bomb_title"] = "Collector - Disarm Bomb",
        ["collector_disarm_bomb_desc"] = string_f_2,
		["collector_weapon_case_title"] = "Collector - Weapon Case",
        ["collector_weapon_case_desc"] = string_f_2,
		["collector_counterfeit_hose_title"] = "Collector - Counterfeit Hose",
        ["collector_counterfeit_hose_desc"] = string_f_2,
		["collector_flare_title"] = "Collector -Flare",
        ["collector_flare_desc"] = string_f_2
	})
end)

Hooks:Add("MenuManagerSetupCustomMenus", class_name.."Menu", function(menu_manager, nodes)
	MenuHelper:NewMenu(class_name)
end)

Hooks:Add("MenuManagerPopulateCustomMenus", class_name.."Menu", function(menu_manager, nodes)
	MenuCallbackHandler.stacker_amount = function(self, item)
		local value = item:value()
		loc.config.stacker.amount = tonumber(value)
		loc:save_config()
	end

	MenuHelper:AddSlider({
		id = "stacker_amount",
		title = "stacker_amount_title",
		desc = "stacker_amount_desc",
		callback = "stacker_amount",
		value = tonumber(loc.config.stacker.amount),
		min = 0,
		max = 10,
		step = 1,
		show_value = true,
		menu_id = class_name,
		priority = 3000
	})
	
	MenuCallbackHandler.collector_delay = function(self, item)
		local value = item:value() / 10
		loc.config.collector.delay = tonumber(value)
		loc:save_config()
	end
	
	MenuHelper:AddSlider({
		id = "collector_delay",
		title = "collector_delay_title",
		desc = "collector_delay_desc",
		callback = "collector_delay",
		value = (tonumber(loc.config.collector.delay) * 10),
		min = 0,
		max = 100,
		step = 1,
		show_value = true,
		menu_id = class_name,
		priority = 3001
	})

	MenuCallbackHandler.collector_range = function(self, item)
		local value = item:value() * 10
		loc.config.collector.range = tonumber(value)
		loc:save_config()
	end
	
	MenuHelper:AddSlider({
		id = "collector_range",
		title = "collector_range_title",
		desc = "collector_range_desc",
		callback = "collector_range",
		value = (tonumber(loc.config.collector.range) / 10),
		min = 1,
		max = 50,
		step = 1,
		show_value = true,
		menu_id = class_name,
		priority = 3002
	})

	MenuCallbackHandler.collector_extra_toggle = function(self, item)
		loc.config.collector.extra_toggle = not loc.config.collector.extra_toggle
		loc:save_config()
	end
	
	MenuCallbackHandler.collector_wall_hack = function(self, item)
		loc.config.collector.interact_through_walls = not loc.config.collector.interact_through_walls
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_wall_hack",
		title = "collector_wall_hack_title",
		desc = "collector_wall_hack_desc",
		callback = "collector_wall_hack",
		value = loc.config.collector.interact_through_walls,
		menu_id = class_name,  
		priority = 3003
	})
	
	MenuHelper:AddToggle({
		id = "collector_extra_toggle",
		title = "collector_toggle_extra_title",
		desc = "collector_toggle_extra_desc",
		callback = "collector_extra_toggle",
		value = loc.config.collector.extra_toggle,
		menu_id = class_name,  
		priority = 3004
	})
	
	MenuCallbackHandler.collector_toggle = function(self, item)
		loc.config.collector.toggle = not loc.config.collector.toggle
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_toggle",
		title = "collector_toggle_title",
		desc = "collector_toggle_desc",
		callback = "collector_toggle",
		value = loc.config.collector.toggle,
		menu_id = class_name,  
		priority = 3005
	})
	
	MenuCallbackHandler.toggle_host = function(self, item)
		loc.config.stacker.host_only = not loc.config.stacker.host_only
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "toggle_host",
		title = "toggle_host_title",
		desc = "toggle_host_desc",
		callback = "toggle_host",
		value = loc.config.stacker.host_only,
		menu_id = class_name,  
		priority = 2005
	})
	
	MenuCallbackHandler.toggle_stacker = function(self, item)
		loc.config.stacker.toggle = not loc.config.stacker.toggle
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "toggle_stacker",
		title = "toggle_stacker_title",
		desc = "toggle_stacker_desc",
		callback = "toggle_stacker",
		value = loc.config.stacker.toggle,
		menu_id = class_name,  
		priority = 2006
	})

	MenuCallbackHandler.bank_manager_key = function(self, item)
		loc.config.stacker.bank_manager_key = not loc.config.stacker.bank_manager_key
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "bank_manager_key",
		title = "bank_manager_key_title",
		desc = "bank_manager_key_desc",
		callback = "bank_manager_key",
		value = loc.config.stacker.bank_manager_key,
		menu_id = class_name,  
		priority = 1000
	})
	
	MenuCallbackHandler.blood_sample = function(self, item)
		loc.config.stacker.blood_sample = not loc.config.stacker.blood_sample
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "blood_sample",
		title = "blood_sample_title",
		desc = "blood_sample_desc",
		callback = "blood_sample",
		value = loc.config.stacker.blood_sample,
		menu_id = class_name,  
		priority = 1001
	})
	
	MenuCallbackHandler.blood_sample_verified = function(self, item)
		loc.config.stacker.blood_sample_verified = not loc.config.stacker.blood_sample_verified
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "blood_sample_verified",
		title = "blood_sample_verified_title",
		desc = "blood_sample_verified_desc",
		callback = "blood_sample_verified",
		value = loc.config.stacker.blood_sample_verified,
		menu_id = class_name,  
		priority = 1002
	})
	
	MenuCallbackHandler.gas = function(self, item)
		loc.config.stacker.gas = not loc.config.stacker.gas
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "gas",
		title = "gas_title",
		desc = "gas_desc",
		callback = "gas",
		value = loc.config.stacker.gas,
		menu_id = class_name,  
		priority = 1003
	})
	
	MenuCallbackHandler.liquid_nitrogen = function(self, item)
		loc.config.stacker.liquid_nitrogen = not loc.config.stacker.liquid_nitrogen
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "liquid_nitrogen",
		title = "liquid_nitrogen_title",
		desc = "liquid_nitrogen_desc",
		callback = "liquid_nitrogen",
		value = loc.config.stacker.liquid_nitrogen,
		menu_id = class_name,  
		priority = 1004
	})
	
	MenuCallbackHandler.printer_ink = function(self, item)
		loc.config.stacker.printer_ink = not loc.config.stacker.printer_ink
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "printer_ink",
		title = "printer_ink_title",
		desc = "printer_ink_desc",
		callback = "printer_ink",
		value = loc.config.stacker.printer_ink,
		menu_id = class_name,  
		priority = 1005
	})
	
	MenuCallbackHandler.paper_roll = function(self, item)
		loc.config.stacker.paper_roll = not loc.config.stacker.paper_roll
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "paper_roll",
		title = "paper_roll_title",
		desc = "paper_roll_desc",
		callback = "paper_roll",
		value = loc.config.stacker.paper_roll,
		menu_id = class_name,  
		priority = 1006
	})
	
	MenuCallbackHandler.lance_part = function(self, item)
		loc.config.stacker.lance_part = not loc.config.stacker.lance_part
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "lance_part",
		title = "lance_part_title",
		desc = "lance_part_desc",
		callback = "lance_part",
		value = loc.config.stacker.lance_part,
		menu_id = class_name,  
		priority = 1007
	})
	
	MenuCallbackHandler.thermite_paste = function(self, item)
		loc.config.stacker.thermite_paste = not loc.config.stacker.thermite_paste
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "thermite_paste",
		title = "thermite_paste_title",
		desc = "thermite_paste_desc",
		callback = "thermite_paste",
		value = loc.config.stacker.thermite_paste,
		menu_id = class_name,  
		priority = 1008
	})
	
	MenuCallbackHandler.thermite = function(self, item)
		loc.config.stacker.thermite = not loc.config.stacker.thermite
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "thermite",
		title = "thermite_title",
		desc = "thermite_desc",
		callback = "thermite",
		value = loc.config.stacker.thermite,
		menu_id = class_name,  
		priority = 1009
	})
	
	MenuCallbackHandler.circle_cutter = function(self, item)
		loc.config.stacker.circle_cutter = not loc.config.stacker.circle_cutter
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "circle_cutter",
		title = "circle_cutter_title",
		desc = "circle_cutter_desc",
		callback = "circle_cutter",
		value = loc.config.stacker.circle_cutter,
		menu_id = class_name,  
		priority = 1010
	})
	
	MenuCallbackHandler.mayan_gold_bar = function(self, item)
		loc.config.stacker.mayan_gold_bar = not loc.config.stacker.mayan_gold_bar
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "mayan_gold_bar",
		title = "mayan_gold_bar_title",
		desc = "mayan_gold_bar_desc",
		callback = "mayan_gold_bar",
		value = loc.config.stacker.mayan_gold_bar,
		menu_id = class_name,  
		priority = 1011
	})
	
	MenuCallbackHandler.acid = function(self, item)
		loc.config.stacker.acid = not loc.config.stacker.acid
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "acid",
		title = "acid_title",
		desc = "acid_desc",
		callback = "acid",
		value = loc.config.stacker.acid,
		menu_id = class_name,  
		priority = 1012
	})
	
	MenuCallbackHandler.caustic_soda = function(self, item)
		loc.config.stacker.caustic_soda = not loc.config.stacker.caustic_soda
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "caustic_soda",
		title = "caustic_soda_title",
		desc = "caustic_soda_desc",
		callback = "caustic_soda",
		value = loc.config.stacker.caustic_soda,
		menu_id = class_name,  
		priority = 1013
	})
	
	MenuCallbackHandler.hydrogen_chloride = function(self, item)
		loc.config.stacker.hydrogen_chloride = not loc.config.stacker.hydrogen_chloride
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "hydrogen_chloride",
		title = "hydrogen_chloride_title",
		desc = "hydrogen_chloride_desc",
		callback = "hydrogen_chloride",
		value = loc.config.stacker.hydrogen_chloride,
		menu_id = class_name,  
		priority = 1014
	})
	
	MenuCallbackHandler.harddrive = function(self, item)
		loc.config.stacker.harddrive = not loc.config.stacker.harddrive
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "harddrive",
		title = "harddrive_title",
		desc = "harddrive_desc",
		callback = "harddrive",
		value = loc.config.stacker.harddrive,
		menu_id = class_name,  
		priority = 1015
	})
	
	MenuCallbackHandler.planks = function(self, item)
		loc.config.stacker.planks = not loc.config.stacker.planks
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "planks",
		title = "planks_title",
		desc = "planks_desc",
		callback = "planks",
		value = loc.config.stacker.planks,
		menu_id = class_name,  
		priority = 1016
	})
	
	MenuCallbackHandler.boards = function(self, item)
		loc.config.stacker.boards = not loc.config.stacker.boards
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "boards",
		title = "boards_title",
		desc = "boards_desc",
		callback = "boards",
		value = loc.config.stacker.boards,
		menu_id = class_name,  
		priority = 1017
	})
	
	MenuCallbackHandler.c4 = function(self, item)
		loc.config.stacker.c4 = not loc.config.stacker.c4
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "c4",
		title = "c4_title",
		desc = "c4_desc",
		callback = "c4",
		value = loc.config.stacker.c4,
		menu_id = class_name,  
		priority = 1018
	})
	
	MenuCallbackHandler.crowbar = function(self, item)
		loc.config.stacker.crowbar = not loc.config.stacker.crowbar
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "crowbar",
		title = "crowbar_title",
		desc = "crowbar_desc",
		callback = "crowbar",
		value = loc.config.stacker.crowbar,
		menu_id = class_name,  
		priority = 1019
	})
	
	MenuCallbackHandler.evidence = function(self, item)
		loc.config.stacker.evidence = not loc.config.stacker.evidence
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "evidence",
		title = "evidence_title",
		desc = "evidence_desc",
		callback = "evidence",
		value = loc.config.stacker.evidence,
		menu_id = class_name,  
		priority = 1020
	})

	MenuCallbackHandler.blow_torch = function(self, item)
        loc.config.stacker.blow_torch = not loc.config.stacker.blow_torch
        loc:save_config()
    end

    MenuHelper:AddToggle({
        id = "blow_torch",
        title = "blow_torch_title",
        desc = "blow_torch_desc",
        callback = "blow_torch",
        value = loc.config.stacker.blow_torch,
        menu_id = class_name,  
        priority = 1021
    })
	
	local extra_saws_options = {
		"saw_only_sub_title",
		"saw_and_extra_sub_title",
		"no_saw_sub_title"
	}
	MenuCallbackHandler.saw = function(self, item)
		if extra_saws_options[item:value()] then
			loc.config.stacker.saw = item:value()
			loc:save_config()
		end
	end
	
	MenuHelper:AddMultipleChoice({
		id = "saw",
		title = "saw_title",
		desc = "saw_desc",
		callback = "saw",
		items = extra_saws_options,
		value = loc.config.stacker.saw,
		menu_id = class_name,
		priority = 1100,
	})
	
	MenuCallbackHandler.collector_deposit_boxes = function(self, item)
		loc.config.collector.deposit_boxes = not loc.config.collector.deposit_boxes
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_deposit_boxes",
		title = "collector_deposit_boxes_title",
		desc = "collector_deposit_boxes_desc",
		callback = "collector_deposit_boxes",
		value = loc.config.collector.deposit_boxes,
		menu_id = class_name,  
		priority = 1
	})

	MenuCallbackHandler.collector_pickup_phone = function(self, item)
		loc.config.collector.pickup_phone = not loc.config.collector.pickup_phone
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_pickup_phone",
		title = "collector_pickup_phone_title",
		desc = "collector_pickup_phone_desc",
		callback = "collector_pickup_phone",
		value = loc.config.collector.pickup_phone,
		menu_id = class_name,  
		priority = 2
	})

	MenuCallbackHandler.collector_mission_objectives = function(self, item)
		loc.config.collector.mission_objectives = not loc.config.collector.mission_objectives
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_mission_objectives",
		title = "collector_mission_objectives_title",
		desc = "collector_mission_objectives_desc",
		callback = "collector_mission_objectives",
		value = loc.config.collector.mission_objectives,
		menu_id = class_name,  
		priority = 3
	})

	MenuCallbackHandler.collector_harddrive = function(self, item)
		loc.config.collector.harddrive = not loc.config.collector.harddrive
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_harddrive",
		title = "collector_harddrive_title",
		desc = "collector_harddrive_desc",
		callback = "collector_harddrive",
		value = loc.config.collector.harddrive,
		menu_id = class_name,  
		priority = 4
	})

	MenuCallbackHandler.collector_liquid_nitrogen = function(self, item)
		loc.config.collector.liquid_nitrogen = not loc.config.collector.liquid_nitrogen
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_liquid_nitrogen",
		title = "collector_liquid_nitrogen_title",
		desc = "collector_liquid_nitrogen_desc",
		callback = "collector_liquid_nitrogen",
		value = loc.config.collector.liquid_nitrogen,
		menu_id = class_name,  
		priority = 5
	})

	MenuCallbackHandler.collector_gas_can = function(self, item)
		loc.config.collector.gas_can = not loc.config.collector.gas_can
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_gas_can",
		title = "collector_gas_can_title",
		desc = "collector_gas_can_desc",
		callback = "collector_gas_can",
		value = loc.config.collector.gas_can,
		menu_id = class_name,  
		priority = 6
	})

	MenuCallbackHandler.collector_planks = function(self, item)
		loc.config.collector.planks = not loc.config.collector.planks
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_planks",
		title = "collector_planks_title",
		desc = "collector_planks_desc",
		callback = "collector_planks",
		value = loc.config.collector.planks,
		menu_id = class_name,  
		priority = 7
	})

	MenuCallbackHandler.collector_defibrillator = function(self, item)
		loc.config.collector.defibrillator = not loc.config.collector.defibrillator
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_defibrillator",
		title = "collector_defibrillator_title",
		desc = "collector_defibrillator_desc",
		callback = "collector_defibrillator",
		value = loc.config.collector.defibrillator,
		menu_id = class_name,  
		priority = 8
	})

	MenuCallbackHandler.collector_small_loot = function(self, item)
		loc.config.collector.small_loot = not loc.config.collector.small_loot
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_small_loot",
		title = "collector_small_loot_title",
		desc = "collector_small_loot_desc",
		callback = "collector_small_loot",
		value = loc.config.collector.small_loot,
		menu_id = class_name,  
		priority = 9
	})

	MenuCallbackHandler.collector_secret_items = function(self, item)
		loc.config.collector.secret_items = not loc.config.collector.secret_items
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_secret_items",
		title = "collector_secret_items_title",
		desc = "collector_secret_items_desc",
		callback = "collector_secret_items",
		value = loc.config.collector.secret_items,
		menu_id = class_name,  
		priority = 10
	})

	MenuCallbackHandler.collector_cash_register = function(self, item)
		loc.config.collector.cash_register = not loc.config.collector.cash_register
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_cash_register",
		title = "collector_cash_register_title",
		desc = "collector_cash_register_desc",
		callback = "collector_cash_register",
		value = loc.config.collector.cash_register,
		menu_id = class_name,  
		priority = 11
	})

	MenuCallbackHandler.collector_requires_ecm_jammer_atm = function(self, item)
		loc.config.collector.requires_ecm_jammer_atm = not loc.config.collector.requires_ecm_jammer_atm
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_requires_ecm_jammer_atm",
		title = "collector_requires_ecm_jammer_atm_title",
		desc = "collector_requires_ecm_jammer_atm_desc",
		callback = "collector_requires_ecm_jammer_atm",
		value = loc.config.collector.requires_ecm_jammer_atm,
		menu_id = class_name,  
		priority = 12
	})
	
	MenuCallbackHandler.collector_use_sample = function(self, item)
		loc.config.collector.use_sample = not loc.config.collector.use_sample
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_use_sample",
		title = "collector_use_sample_title",
		desc = "collector_use_sample_desc",
		callback = "collector_use_sample",
		value = loc.config.collector.use_sample,
		menu_id = class_name,  
		priority = 13
	})
	
	MenuCallbackHandler.collector_use_circuit_breaker = function(self, item)
		loc.config.collector.use_circuit_breaker = not loc.config.collector.use_circuit_breaker
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_use_circuit_breaker",
		title = "collector_use_circuit_breaker_title",
		desc = "collector_use_circuit_breaker_desc",
		callback = "collector_use_circuit_breaker",
		value = loc.config.collector.use_circuit_breaker,
		menu_id = class_name,  
		priority = 14
	})
	
	MenuCallbackHandler.collector_fire_camera = function(self, item)
		loc.config.collector.fire_camera = not loc.config.collector.fire_camera
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_fire_camera",
		title = "collector_fire_camera_title",
		desc = "collector_fire_camera_desc",
		callback = "collector_fire_camera",
		value = loc.config.collector.fire_camera,
		menu_id = class_name,  
		priority = 15
	})
	
	MenuCallbackHandler.collector_hold_remove_bug = function(self, item)
		loc.config.collector.hold_remove_bug = not loc.config.collector.hold_remove_bug
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_hold_remove_bug",
		title = "collector_hold_remove_bug_title",
		desc = "collector_hold_remove_bug_desc",
		callback = "collector_hold_remove_bug",
		value = loc.config.collector.hold_remove_bug,
		menu_id = class_name,  
		priority = 16
	})
	
	MenuCallbackHandler.collector_hold_open_xmas_present = function(self, item)
		loc.config.collector.hold_open_xmas_present = not loc.config.collector.hold_open_xmas_present
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_hold_open_xmas_present",
		title = "collector_hold_open_xmas_present_title",
		desc = "collector_hold_open_xmas_present_desc",
		callback = "collector_hold_open_xmas_present",
		value = loc.config.collector.hold_open_xmas_present,
		menu_id = class_name,  
		priority = 17
	})
	
	MenuCallbackHandler.collector_cas_sleeping_gas = function(self, item)
		loc.config.collector.cas_sleeping_gas = not loc.config.collector.cas_sleeping_gas
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_cas_sleeping_gas",
		title = "collector_cas_sleeping_gas_title",
		desc = "collector_cas_sleeping_gas_desc",
		callback = "collector_cas_sleeping_gas",
		value = loc.config.collector.cas_sleeping_gas,
		menu_id = class_name,  
		priority = 18
	})
	
	MenuCallbackHandler.collector_cas_usb_key = function(self, item)
		loc.config.collector.cas_usb_key = not loc.config.collector.cas_usb_key
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_cas_usb_key",
		title = "collector_cas_usb_key_title",
		desc = "collector_cas_usb_key_desc",
		callback = "collector_cas_usb_key",
		value = loc.config.collector.cas_usb_key,
		menu_id = class_name,  
		priority = 19
	})
	
	MenuCallbackHandler.collector_pex_unloaded_card = function(self, item)
		loc.config.collector.pex_unloaded_card = not loc.config.collector.pex_unloaded_card
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_pex_unloaded_card",
		title = "collector_pex_unloaded_card_title",
		desc = "collector_pex_unloaded_card_desc",
		callback = "collector_pex_unloaded_card",
		value = loc.config.collector.pex_unloaded_card,
		menu_id = class_name,  
		priority = 20
	})
	
	MenuCallbackHandler.collector_pex_cutter = function(self, item)
		loc.config.collector.pex_cutter = not loc.config.collector.pex_cutter
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_pex_cutter",
		title = "collector_pex_cutter_title",
		desc = "collector_pex_cutter_desc",
		callback = "collector_pex_cutter",
		value = loc.config.collector.pex_cutter,
		menu_id = class_name,  
		priority = 21
	})
	
	MenuCallbackHandler.collector_police_uniform = function(self, item)
		loc.config.collector.police_uniform = not loc.config.collector.police_uniform
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_police_uniform",
		title = "collector_police_uniform_title",
		desc = "collector_police_uniform_desc",
		callback = "collector_police_uniform",
		value = loc.config.collector.police_uniform,
		menu_id = class_name,  
		priority = 22
	})
	
	MenuCallbackHandler.collector_keychain = function(self, item)
		loc.config.collector.keychain = not loc.config.collector.keychain
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_keychain",
		title = "collector_keychain_title",
		desc = "collector_keychain_desc",
		callback = "collector_keychain",
		value = loc.config.collector.keychain,
		menu_id = class_name,  
		priority = 23
	})
	
	MenuCallbackHandler.collector_briefcase = function(self, item)
		loc.config.collector.briefcase = not loc.config.collector.briefcase
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_briefcase",
		title = "collector_briefcase_title",
		desc = "collector_briefcase_desc",
		callback = "collector_briefcase",
		value = loc.config.collector.briefcase,
		menu_id = class_name,  
		priority = 24
	})
	
	MenuCallbackHandler.collector_adrenaline = function(self, item)
		loc.config.collector.adrenaline = not loc.config.collector.adrenaline
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_adrenaline",
		title = "collector_adrenaline_title",
		desc = "collector_adrenaline_desc",
		callback = "collector_adrenaline",
		value = loc.config.collector.adrenaline,
		menu_id = class_name,  
		priority = 25
	})
	
	MenuCallbackHandler.collector_manifest = function(self, item)
		loc.config.collector.manifest = not loc.config.collector.manifest
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_manifest",
		title = "collector_manifest_title",
		desc = "collector_manifest_desc",
		callback = "collector_manifest",
		value = loc.config.collector.manifest,
		menu_id = class_name,  
		priority = 26
	})
	
	MenuCallbackHandler.collector_chimichanga = function(self, item)
		loc.config.collector.chimichanga = not loc.config.collector.chimichanga
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_chimichanga",
		title = "collector_chimichanga_title",
		desc = "collector_chimichanga_desc",
		callback = "collector_chimichanga",
		value = loc.config.collector.chimichanga,
		menu_id = class_name,  
		priority = 27
	})
	
	MenuCallbackHandler.collector_medallion = function(self, item)
		loc.config.collector.medallion = not loc.config.collector.medallion
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_medallion",
		title = "collector_medallion_title",
		desc = "collector_medallion_desc",
		callback = "collector_medallion",
		value = loc.config.collector.medallion,
		menu_id = class_name,  
		priority = 28
	})

	MenuCallbackHandler.collector_plates = function(self, item)
		loc.config.collector.plates = not loc.config.collector.plates
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_plates",
		title = "collector_plates_title",
		desc = "collector_plates_desc",
		callback = "collector_plates",
		value = loc.config.collector.plates,
		menu_id = class_name,  
		priority = 29
	})
	
	MenuCallbackHandler.collector_lockpick_locker = function(self, item)
		loc.config.collector.lockpick_locker = not loc.config.collector.lockpick_locker
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_lockpick_locker",
		title = "collector_lockpick_locker_title",
		desc = "collector_lockpick_locker_desc",
		callback = "collector_lockpick_locker",
		value = loc.config.collector.lockpick_locker,
		menu_id = class_name,  
		priority = 30
	})
	
	MenuCallbackHandler.collector_president_key = function(self, item)
		loc.config.collector.president_key = not loc.config.collector.president_key
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_president_key",
		title = "collector_president_key_title",
		desc = "collector_president_key_desc",
		callback = "collector_president_key",
		value = loc.config.collector.president_key,
		menu_id = class_name,  
		priority = 31
	})
	
	MenuCallbackHandler.collector_use_c4 = function(self, item)
		loc.config.collector.use_c4 = not loc.config.collector.use_c4
		loc:save_config()
	end
	
	MenuHelper:AddToggle({
		id = "collector_use_c4",
		title = "collector_use_c4_title",
		desc = "collector_use_c4_desc",
		callback = "collector_use_c4",
		value = loc.config.collector.use_c4,
		menu_id = class_name,  
		priority = 32
	})
	
	MenuCallbackHandler.collector_chrome_skull = function(self, item)
		loc.config.collector.chrome_skull = not loc.config.collector.chrome_skull
		loc:save_config()
    end

    MenuHelper:AddToggle({
		id = "collector_chrome_skull",
		title = "collector_chrome_skull_title",
		desc = "collector_chrome_skull_desc",
		callback = "collector_chrome_skull",
		value = loc.config.collector.chrome_skull,
		menu_id = class_name,  
		priority = 33
    })

	MenuCallbackHandler.collector_soda = function(self, item)
		loc.config.collector.soda = not loc.config.collector.soda
		loc:save_config()
    end

    MenuHelper:AddToggle({
		id = "collector_soda",
		title = "collector_soda_title",
		desc = "collector_soda_desc",
		callback = "collector_soda",
		value = loc.config.collector.soda,
		menu_id = class_name,  
		priority = 34
    })

	MenuCallbackHandler.collector_tool = function(self, item)
		loc.config.collector.tool = not loc.config.collector.tool
		loc:save_config()
    end

    MenuHelper:AddToggle({
		id = "collector_tool",
		title = "collector_tool_title",
		desc = "collector_tool_desc",
		callback = "collector_tool",
		value = loc.config.collector.tool,
		menu_id = class_name,  
		priority = 35
    })
	
	MenuCallbackHandler.collector_blow_torch = function(self, item)
		loc.config.collector.blow_torch = not loc.config.collector.blow_torch
		loc:save_config()
    end

    MenuHelper:AddToggle({
		id = "collector_blow_torch",
		title = "collector_blow_torch_title",
		desc = "collector_blow_torch_desc",
		callback = "collector_blow_torch",
		value = loc.config.collector.blow_torch,
		menu_id = class_name,  
		priority = 36
    })
	
	MenuCallbackHandler.collector_flare = function(self, item)
		loc.config.collector.flare = not loc.config.collector.flare
		loc:save_config()
    end

    MenuHelper:AddToggle({
		id = "collector_flare",
		title = "collector_flare_title",
		desc = "collector_flare_desc",
		callback = "collector_flare",
		value = loc.config.collector.flare,
		menu_id = class_name,  
		priority = 37
    })
	
	MenuCallbackHandler.collector_weapon_case = function(self, item)
		loc.config.collector.weapon_case = not loc.config.collector.weapon_case
		loc:save_config()
    end

    MenuHelper:AddToggle({
		id = "collector_weapon_case",
		title = "collector_weapon_case_title",
		desc = "collector_weapon_case_desc",
		callback = "collector_weapon_case",
		value = loc.config.collector.weapon_case,
		menu_id = class_name,  
		priority = 38
    })
	
	MenuCallbackHandler.collector_disarm_bomb = function(self, item)
		loc.config.collector.disarm_bomb = not loc.config.collector.disarm_bomb
		loc:save_config()
    end

    MenuHelper:AddToggle({
		id = "collector_disarm_bomb",
		title = "collector_disarm_bomb_title",
		desc = "collector_disarm_bomb_desc",
		callback = "collector_disarm_bomb",
		value = loc.config.collector.disarm_bomb,
		menu_id = class_name,  
		priority = 39
    })
	
	MenuCallbackHandler.collector_money_briefcase = function(self, item)
		loc.config.collector.money_briefcase = not loc.config.collector.money_briefcase
		loc:save_config()
    end

    MenuHelper:AddToggle({
		id = "collector_money_briefcase",
		title = "collector_money_briefcase_title",
		desc = "collector_money_briefcase_desc",
		callback = "collector_money_briefcase",
		value = loc.config.collector.money_briefcase,
		menu_id = class_name,  
		priority = 40
    })
	
	MenuCallbackHandler.collector_fire_extinguisher = function(self, item)
		loc.config.collector.fire_extinguisher = not loc.config.collector.fire_extinguisher
		loc:save_config()
    end

    MenuHelper:AddToggle({
		id = "collector_fire_extinguisher",
		title = "collector_fire_extinguisher_title",
		desc = "collector_fire_extinguisher_desc",
		callback = "collector_fire_extinguisher",
		value = loc.config.collector.fire_extinguisher,
		menu_id = class_name,  
		priority = 41
    })
	
	MenuCallbackHandler.collector_alesso_c4 = function(self, item)
		loc.config.collector.alesso_c4 = not loc.config.collector.alesso_c4
		loc:save_config()
    end

    MenuHelper:AddToggle({
		id = "collector_alesso_c4",
		title = "collector_alesso_c4_title",
		desc = "collector_alesso_c4_desc",
		callback = "collector_alesso_c4",
		value = loc.config.collector.alesso_c4,
		menu_id = class_name, 
        priority = 42
    })
	
	MenuCallbackHandler.collector_hand = function(self, item)
        loc.config.stacker.collector_hand = not loc.config.stacker.collector_hand
        loc:save_config()
    end

    MenuHelper:AddToggle({
        id = "collector_hand",
        title = "collector_hand_title",
        desc = "collector_hand_desc",
        callback = "collector_hand",
        value = loc.config.stacker.collector_hand,
        menu_id = class_name,  
        priority = 43
    })
	
	MenuCallbackHandler.collector_closet = function(self, item)
		loc.config.collector.closet = not loc.config.collector.closet
		loc:save_config()
    end

    MenuHelper:AddToggle({
		id = "collector_closet",
		title = "collector_closet_title",
		desc = "collector_closet_desc",
		callback = "collector_closet",
		value = loc.config.collector.closet,
		menu_id = class_name, 
        priority = 44
    })
	
	MenuCallbackHandler.collector_golden_grin_code = function(self, item)
		loc.config.collector.golden_grin_code = not loc.config.collector.golden_grin_code
		loc:save_config()
    end

    MenuHelper:AddToggle({
		id = "collector_golden_grin_code",
		title = "collector_golden_grin_code_title",
		desc = "collector_golden_grin_code_desc",
		callback = "collector_golden_grin_code",
		value = loc.config.collector.golden_grin_code,
		menu_id = class_name, 
        priority = 45
    })
	
	MenuCallbackHandler.collector_winch_hook = function(self, item)
		loc.config.collector.winch_hook = not loc.config.collector.winch_hook
		loc:save_config()
    end

    MenuHelper:AddToggle({
		id = "collector_winch_hook",
		title = "collector_winch_hook_title",
		desc = "collector_winch_hook_desc",
		callback = "collector_winch_hook",
		value = loc.config.collector.winch_hook,
		menu_id = class_name, 
        priority = 46
    })
	
	MenuCallbackHandler.collector_buluc_clue = function(self, item)
		loc.config.collector.buluc_clue = not loc.config.collector.buluc_clue
		loc:save_config()
    end

    MenuHelper:AddToggle({
		id = "collector_buluc_clue",
		title = "collector_buluc_clue_title",
		desc = "collector_buluc_clue_desc",
		callback = "collector_buluc_clue",
		value = loc.config.collector.buluc_clue,
		menu_id = class_name, 
        priority = 47
    })

	MenuCallbackHandler.collector_counterfeit_hose = function(self, item)
		loc.config.collector.counterfeit_hose = not loc.config.collector.counterfeit_hose
		loc:save_config()
    end

    MenuHelper:AddToggle({
		id = "collector_counterfeit_hose",
		title = "collector_counterfeit_hose_title",
		desc = "collector_counterfeit_hose_desc",
		callback = "collector_counterfeit_hose",
		value = loc.config.collector.counterfeit_hose,
		menu_id = class_name, 
        priority = 48
    })
end)

Hooks:Add("MenuManagerBuildCustomMenus", class_name.."Menu", function(menu_manager, nodes)
	nodes[class_name] = MenuHelper:BuildMenu(class_name)
	MenuHelper:AddMenuItem(nodes["blt_options"], class_name, class_name.."_menu_title", class_name.."_menu_desc")
end)