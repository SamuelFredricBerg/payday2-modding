_G.AutoMarker = _G.AutoMarker or {}
AutoMarker.ModPath = ModPath
AutoMarker.SaveFile = SavePath .. "auto-marker.json"
AutoMarker.OptionsMenu = AutoMarker.ModPath .. "menu/options.txt"
AutoMarker.Settings = AutoMarker.Settings or { enabled = true }

function AutoMarker:Load()
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

function AutoMarker:Save()
	local file = io.open(self.SaveFile, "w+")
	if file then
		file:write(json.encode(self.Settings))
		file:close()
	end
end

AutoMarker:Load()

Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_AutoMarker", function(loc)
	loc:load_localization_file(AutoMarker.ModPath .. "loc/english.txt", false)
end)

Hooks:Add("MenuManagerInitialize", "MenuManagerInitialize_AutoMarker", function(menu_manager)
	MenuCallbackHandler.AutoMarker_SaveSettings = function(node)
		AutoMarker:Save()
	end
	MenuHelper:LoadFromJsonFile(AutoMarker.OptionsMenu, AutoMarker, AutoMarker.Settings)
end)