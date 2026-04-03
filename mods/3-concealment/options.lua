_G.ThreeConcealment = _G.ThreeConcealment or {}
ThreeConcealment.ModPath = ModPath
ThreeConcealment.SaveFile = SavePath .. "3-concealment.json"
ThreeConcealment.OptionsMenu = ThreeConcealment.ModPath .. "menu/options.txt"
ThreeConcealment.Settings = ThreeConcealment.Settings or { enabled = true }

function ThreeConcealment:Load()
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

function ThreeConcealment:Save()
	local file = io.open(self.SaveFile, "w+")
	if file then
		file:write(json.encode(self.Settings))
		file:close()
	end
end

ThreeConcealment:Load()

Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_ThreeConcealment", function(loc)
	loc:load_localization_file(ThreeConcealment.ModPath .. "loc/english.txt", false)
end)

Hooks:Add("MenuManagerInitialize", "MenuManagerInitialize_ThreeConcealment", function(menu_manager)
	MenuCallbackHandler.ThreeConcealment_SaveSettings = function(node)
		ThreeConcealment:Save()
	end
	MenuHelper:LoadFromJsonFile(ThreeConcealment.OptionsMenu, ThreeConcealment, ThreeConcealment.Settings)
end)
