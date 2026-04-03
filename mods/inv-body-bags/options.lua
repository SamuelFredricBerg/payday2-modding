_G.IBB = _G.IBB or {}
IBB.ModPath = ModPath
IBB.SaveFile = SavePath .. "inventory-body-bags.txt"
IBB.OptionsMenu = IBB.ModPath .. "menu/options.txt"
IBB.Settings = {
	start_amount = 10,
	max_amount = 99
}

function IBB:Load()
	local file = io.open(self.SaveFile, "r")
	if file then
		for key, value in pairs(json.decode(file:read("*all"))) do
			self.Settings[key] = value
		end
		file:close()
	end
end

function IBB:Save()
	local file = io.open(self.SaveFile, "w+")
	if file then
		file:write(json.encode(self.Settings))
		file:close()
	end
end

IBB:Load()

Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_IBB", function(loc)
	loc:load_localization_file(IBB.ModPath .. "loc/english.txt", false)
end)

Hooks:Add("MenuManagerInitialize", "MenuManagerInitialize_IBB", function(menu_manager)
	MenuCallbackHandler.IBB_SaveSettings = function(node)
		IBB:Save()
	end

	MenuCallbackHandler.IBB_SetStartAmount = function(self, item)
		IBB.Settings.start_amount = item:value()
	end

	MenuCallbackHandler.IBB_SetMaxAmount = function(self, item)
		IBB.Settings.max_amount = item:value()
	end

	MenuHelper:LoadFromJsonFile(IBB.OptionsMenu, IBB, IBB.Settings)
end)