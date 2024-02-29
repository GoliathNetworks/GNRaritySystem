local PLUGIN = PLUGIN

function PLUGIN:nutInventoryItemAdded( item )
	if item:GetRarity() then return end

	local rarity = item:GenerateRarity()
end