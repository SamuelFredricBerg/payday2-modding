--[[
	consumable-stacker — code.lua
	Hooked on: lib/managers/menumanager

	Initialises the mod global table, loads/saves settings and registers
	the BLT options menu.  All other hook files reference the _G.ConsumableStacker
	table created here.
]]

_G.ConsumableStacker = _G.ConsumableStacker or {}
ConsumableStacker.ModPath   = ModPath
ConsumableStacker.SavePath  = SavePath .. "consumable-stacker.txt"

-- Default settings
ConsumableStacker.Settings = {
	enabled   = true,
	max_stack = 5
}

--[[
	Carry IDs of consumable carry items that can be stacked.
	These are items that are physically carried to a heist objective and
	consumed there, rather than being secured at the escape van.
]]
ConsumableStacker.CONSUMABLE_CARRY_IDS = {
	-- Meth-lab ingredients (Cook Off / Rats heist)
	nail_muriatic_acid     = true,
	nail_caustic_soda      = true,
	nail_hydrogen_chloride = true,
	-- Crowbar (used to pry open crates / doors)
	crowbar                = true,
	-- Keycards (included here in case the game stores them as carry items)
	bank_manager_key       = true,
}

--[[
	FIFO queue of extra consumable carries the player has picked up.

	Each entry is a table:
	  { carry_id = <string>, args = { <extra set_carry args> } }

	The "active" (currently held) carry is NOT stored here; this table
	only holds the extras that are waiting to be restored.
]]
ConsumableStacker.stack = {}

-- ─── persistence ────────────────────────────────────────────────────────────

function ConsumableStacker:Load()
	local file = io.open(self.SavePath, "r")
	if file then
		local ok, data = pcall(json.decode, file:read("*all"))
		if ok and data then
			for k, v in pairs(data) do
				self.Settings[k] = v
			end
		end
		file:close()
	end
end

function ConsumableStacker:Save()
	local file = io.open(self.SavePath, "w+")
	if file then
		file:write(json.encode(self.Settings))
		file:close()
	end
end

ConsumableStacker:Load()

-- ─── localization ────────────────────────────────────────────────────────────

Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_ConsumableStacker", function(loc)
	loc:load_localization_file(ConsumableStacker.ModPath .. "loc/english.txt", false)
end)

-- ─── options menu ───────────────────────────────────────────────────────────

Hooks:Add("MenuManagerInitialize", "MenuManagerInitialize_ConsumableStacker", function(menu_manager)
	MenuCallbackHandler.CS_SaveSettings = function(node)
		ConsumableStacker:Save()
	end

	MenuCallbackHandler.CS_SetEnabled = function(self, item)
		ConsumableStacker.Settings.enabled = item:value() == "on"
	end

	MenuCallbackHandler.CS_SetMaxStack = function(self, item)
		ConsumableStacker.Settings.max_stack = item:value()
	end

	MenuHelper:LoadFromJsonFile(
		ConsumableStacker.ModPath .. "menu/options.txt",
		ConsumableStacker,
		ConsumableStacker.Settings
	)
end)
