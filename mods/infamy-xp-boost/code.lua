local old_XILDIOI_init = InfamyTweakData.init

function InfamyTweakData:init(tweak_data)
	old_XILDIOI_init(self, tweak_data)
	for _, item in pairs(self.items) do
		if item.upgrades then
			if item.upgrades.infamous_lootdrop then
				item.upgrades.infamous_lootdrop = 200
			end
			if item.upgrades.infamous_xp then
				item.upgrades.infamous_xp = 100
			end
		end
	end
end