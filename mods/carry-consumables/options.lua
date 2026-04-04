local function val2bool(value)
	return value == "on"
end

_G.CarryConsumables = _G.CarryConsumables or {}
CarryConsumables.ModPath = ModPath
CarryConsumables.SaveFile = SavePath .. "carry-consumables.txt"
CarryConsumables.OptionsMenu = CarryConsumables.ModPath .. "menu/options.txt"
CarryConsumables.Settings = CarryConsumables.Settings or {
	enabled = true,
	max_items = 4
}

function CarryConsumables:Load()
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

function CarryConsumables:Save()
	local file = io.open(self.SaveFile, "w+")
	if file then
		file:write(json.encode(self.Settings))
		file:close()
	end
end

CarryConsumables:Load()

Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_CarryConsumables", function(loc)
	loc:load_localization_file(CarryConsumables.ModPath .. "loc/english.txt", false)
end)

Hooks:Add("MenuManagerInitialize", "MenuManagerInitialize_CarryConsumables", function(menu_manager)
	MenuCallbackHandler.CC_SaveSettings = function(node)
		CarryConsumables:Save()
	end
	MenuCallbackHandler.CC_Enabled = function(self, item)
		CarryConsumables.Settings.enabled = val2bool(item:value())
	end
	MenuCallbackHandler.CC_SetMaxItems = function(self, item)
		CarryConsumables.Settings.max_items = item:value()
	end
	MenuHelper:LoadFromJsonFile(CarryConsumables.OptionsMenu, CarryConsumables, CarryConsumables.Settings)
end)
