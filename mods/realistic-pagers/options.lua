local function val2bool(value)
	return value == "on"
end

_G.RealisticPagers = _G.RealisticPagers or {}
RealisticPagers.ModPath = ModPath
RealisticPagers.SaveFile = SavePath .. "realistic-pagers.txt"
RealisticPagers.OptionsMenu = RealisticPagers.ModPath .. "menu/options.txt"
RealisticPagers.Settings = RealisticPagers.Settings or { enabled = true }

function RealisticPagers:Load()
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

function RealisticPagers:Save()
	local file = io.open(self.SaveFile, "w+")
	if file then
		file:write(json.encode(self.Settings))
		file:close()
	end
end

RealisticPagers:Load()

Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_RealisticPagers", function(loc)
	loc:load_localization_file(RealisticPagers.ModPath .. "loc/english.txt", false)
end)

Hooks:Add("MenuManagerInitialize", "MenuManagerInitialize_RealisticPagers", function(menu_manager)
	MenuCallbackHandler.RealisticPagers_SaveSettings = function(node)
		RealisticPagers:Save()
	end
	MenuCallbackHandler.RealisticPagers_Enabled = function(self, item)
		RealisticPagers.Settings.enabled = val2bool(item:value())
	end
	MenuHelper:LoadFromJsonFile(RealisticPagers.OptionsMenu, RealisticPagers, RealisticPagers.Settings)
end)