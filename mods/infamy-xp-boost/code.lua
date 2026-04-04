local old_XILDIOI_init = InfamyTweakData.init

function InfamyTweakData:init()
	old_XILDIOI_init(self)
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