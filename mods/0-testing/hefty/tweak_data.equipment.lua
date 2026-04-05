local _init=EquipmentsTweakData.init
local _hefty={
	bank_manager_key=5,
	lance_part=4,
	boards=2,
	planks=4,
	thermite_paste=4,
	gas=4,
	acid=3,
	caustic_soda=3,
	hydrogen_chloride=3,
	evidence=5,
	}

function EquipmentsTweakData:init()
	_init(self)
	for name, quantity in pairs(_hefty) do
		self.specials[name].quantity=1
		self.specials[name].max_quantity=quantity
		end
	end