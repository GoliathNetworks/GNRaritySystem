local PLUGIN = PLUGIN

hook.Add( "ItemPaintOver", "Rarity.ItemPaintOver", function( panel, itemData, w, h )
	if !itemData then return end

	local rarity = itemData:GetRarityData()

	if rarity then
		if rarity.customPaint then
			rarity.customPaint( panel, itemData, w, h )
			return
		end
		
		local color = rarity.color
		local text = rarity.name

		if isfunction( rarity.color ) then
			color = rarity.color( itemData )
		end

		surface.SetDrawColor( color )

		for i = 1, 2 do
			surface.DrawOutlinedRect( i, i, w - i * 2, h - i * 2 )
		end

	end

end )