Units = setmetatable({}, {
	__call = function(units, strName)
		local found = {}
		for id, unit in pairs(units) do
			if unit and unit:GetName():lower():find(strName:lower()) then
				found[id] = unit
			end
		end
		return found
	end,
	__index = function(units, strName)
		for id, unit in pairs(units) do
			if unit and unit:GetName():lower():find(strName:lower()) then
				return unit
			end
		end
	end
})

local Units = Units
local Event = Apollo.RegisterEventHandler
Event("UnitCreated",   "f", {f = function(self, unit) Units[unit:GetId()] = unit end})
Event("UnitDestroyed", "f", {f = function(self, unit) Units[unit:GetId()] = nil  end})

Apollo.RegisterAddon(Units)
