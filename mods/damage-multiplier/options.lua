local function val2bool(value)
	return value == "on"
end

_G.DamageMultiplier = _G.DamageMultiplier or {}
DamageMultiplier.ModPath = ModPath
DamageMultiplier.SaveFile = SavePath .. "damage-multiplier.txt"
DamageMultiplier.OptionsMenu = DamageMultiplier.ModPath .. "menu/options.txt"
DamageMultiplier.Settings = DamageMultiplier.Settings or {
	enabled    = true,
	multiplier = 2
}

function DamageMultiplier:Load()
	local file = io.open(self.SaveFile, "r")
	if file then
		local ok, decoded = pcall(json.decode, file:read("*all"))
		if ok and decoded then
			for key, value in pairs(decoded) do
				self.Settings[key] = value
			end
		end
		file:close()
	end
end

function DamageMultiplier:Save()
	local file = io.open(self.SaveFile, "w+")
	if file then
		file:write(json.encode(self.Settings))
		file:close()
	end
end

DamageMultiplier:Load()

Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_DamageMultiplier", function(loc)
	loc:load_localization_file(DamageMultiplier.ModPath .. "loc/english.txt", false)
end)

Hooks:Add("MenuManagerInitialize", "MenuManagerInitialize_DamageMultiplier", function(menu_manager)
	MenuCallbackHandler.DM_SaveSettings = function(node)
		DamageMultiplier:Save()
	end
	MenuCallbackHandler.DM_Enabled = function(self, item)
		DamageMultiplier.Settings.enabled = val2bool(item:value())
	end
	MenuCallbackHandler.DM_SetMultiplier = function(self, item)
		DamageMultiplier.Settings.multiplier = item:value()
	end
	MenuHelper:LoadFromJsonFile(DamageMultiplier.OptionsMenu, DamageMultiplier, DamageMultiplier.Settings)
end)
