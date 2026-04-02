_G.GodMode = _G.GodMode or {}
GodMode._path = ModPath
GodMode._data_path = SavePath .. "godmode.txt"
GodMode.settings = {}

function GodMode:Load()
	self.settings["enabled"] = true
	local file = io.open(self._data_path, "r")
	if file then
		for k, v in pairs(json.decode(file:read("*all"))) do
			self.settings[k] = v
		end
		file:close()
	end
end

function GodMode:Save()
	local file = io.open(self._data_path, "w+")
	if file then
		file:write(json.encode(self.settings))
		file:close()
	end
end

function GodMode:IsEnabled()
	return self.settings["enabled"]
end

Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_GodMode", function(loc)
	loc:load_localization_file(GodMode._path .. "loc/english.json")
end)

Hooks:Add("MenuManagerInitialize", "MenuManagerInitialize_GodMode", function(menu_manager)
	MenuCallbackHandler.GodMode_enabledToggle = function(this, item)
		GodMode.settings["enabled"] = item:value() == "on"
	end
	MenuCallbackHandler.GodMode_Close = function(this)
		GodMode:Save()
	end
	GodMode:Load()
	MenuHelper:LoadFromJsonFile(GodMode._path .. "options.txt", GodMode, GodMode.settings)
end)

if RequiredScript == "lib/units/beings/player/playerdamage" then
	local old_godmodenohit_init = PlayerDamage.init

	function PlayerDamage:init(unit)
		old_godmodenohit_init(self, unit)
		if GodMode:IsEnabled() then
			self._invulnerable = true
		end
	end
end