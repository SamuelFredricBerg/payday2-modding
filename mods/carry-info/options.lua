_G.CarryInfo = _G.CarryInfo or {}
CarryInfo.ModPath = ModPath
CarryInfo.SaveFile = SavePath .. "carry-info.txt"
CarryInfo.OptionsMenu = CarryInfo.ModPath .. "menu/options.txt"
CarryInfo.Settings = CarryInfo.Settings or { enabled = true }

function CarryInfo:Load()
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

function CarryInfo:Save()
	local file = io.open(self.SaveFile, "w+")
	if file then
		file:write(json.encode(self.Settings))
		file:close()
	end
end

CarryInfo:Load()

Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_CarryInfo", function(loc)
	loc:load_localization_file(CarryInfo.ModPath .. "loc/english.txt", false)
end)

Hooks:Add("MenuManagerInitialize", "MenuManagerInitialize_CarryInfo", function(menu_manager)
	MenuCallbackHandler.CarryInfo_SaveSettings = function(node)
		CarryInfo:Save()
	end
	MenuCallbackHandler.CarryInfo_Enabled = function(self, item)
		CarryInfo.Settings.enabled = item:value() == "on"
	end
	MenuHelper:LoadFromJsonFile(CarryInfo.OptionsMenu, CarryInfo, CarryInfo.Settings)
end)