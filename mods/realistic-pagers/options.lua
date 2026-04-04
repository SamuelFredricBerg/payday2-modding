_G.MorePagers = _G.MorePagers or {}
MorePagers.ModPath = ModPath
MorePagers.SaveFile = SavePath .. "more-pagers.txt"
MorePagers.OptionsMenu = MorePagers.ModPath .. "menu/options.txt"
MorePagers.Settings = MorePagers.Settings or { enabled = true }

function MorePagers:Load()
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

function MorePagers:Save()
	local file = io.open(self.SaveFile, "w+")
	if file then
		file:write(json.encode(self.Settings))
		file:close()
	end
end

MorePagers:Load()

Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_MorePagers", function(loc)
	loc:load_localization_file(MorePagers.ModPath .. "loc/english.txt", false)
end)

Hooks:Add("MenuManagerInitialize", "MenuManagerInitialize_MorePagers", function(menu_manager)
	MenuCallbackHandler.MorePagers_SaveSettings = function(node)
		MorePagers:Save()
	end
	MenuCallbackHandler.MorePagers_Enabled = function(self, item)
		MorePagers.Settings.enabled = item:value() == "on"
	end
	MenuHelper:LoadFromJsonFile(MorePagers.OptionsMenu, MorePagers, MorePagers.Settings)
end)