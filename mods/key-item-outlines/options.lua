local function val2bool(value)
	return value == "on"
end

_G.KeyItemOutlines = _G.KeyItemOutlines or {}
KeyItemOutlines.ModPath = ModPath
KeyItemOutlines.SaveFile = SavePath .. "key-item-outlines.txt"
KeyItemOutlines.OptionsMenu = KeyItemOutlines.ModPath .. "menu/options.txt"
KeyItemOutlines.Settings = KeyItemOutlines.Settings or {
	enabled       = true,
	all_carry     = false
}

function KeyItemOutlines:Load()
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

function KeyItemOutlines:Save()
	local file = io.open(self.SaveFile, "w+")
	if file then
		file:write(json.encode(self.Settings))
		file:close()
	end
end

KeyItemOutlines:Load()

Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_KeyItemOutlines", function(loc)
	loc:load_localization_file(KeyItemOutlines.ModPath .. "loc/english.txt", false)
end)

Hooks:Add("MenuManagerInitialize", "MenuManagerInitialize_KeyItemOutlines", function(menu_manager)
	MenuCallbackHandler.KIO_SaveSettings = function(node)
		KeyItemOutlines:Save()
	end
	MenuCallbackHandler.KIO_Enabled = function(self, item)
		KeyItemOutlines.Settings.enabled = val2bool(item:value())
	end
	MenuCallbackHandler.KIO_AllCarry = function(self, item)
		KeyItemOutlines.Settings.all_carry = val2bool(item:value())
	end
	MenuHelper:LoadFromJsonFile(KeyItemOutlines.OptionsMenu, KeyItemOutlines, KeyItemOutlines.Settings)
end)
