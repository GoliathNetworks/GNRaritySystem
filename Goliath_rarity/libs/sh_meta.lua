local PLUGIN = PLUGIN

local ITEM = nut.meta.item

if SERVER then
	util.AddNetworkString( "nut.ApplyWeaponStats" )
end

function ITEM:GetRarity()
	return self:getData("_rarity", false )
end

function ITEM:SetRarity( rarity )
	if !SERVER then return end
	return self:setData("_rarity", rarity)
end

function ITEM:GetRarityData()
	return nut.raritys.list[self:GetRarity()]
end

function ITEM:GetRarityStat( stat )
	return self:GetRarityStatTable()[ stat ]
end

function ITEM:GetRarityStatTable( stat )
	return self:getData("_raritystats", {} )
end

function ITEM:SetRarityStat( stat, value )
	if !SERVER then return end
	local raritystats = self:GetRarityStatTable()

	raritystats[ stat ] = value

	return self:setData("_raritystats", raritystats)
end

function ITEM:SetRarityStatTable( value )
	if !SERVER then return end
	return self:setData("_raritystats", value )
end

function ITEM:GenerateRarity()
	local rarity_roll = math.random( 1, nut.raritys.globals[ "totalChance" ] )

	for k, v in pairs( nut.raritys.list ) do
		if rarity_roll <= v.chance then
			self:SetRarity( k )

			local raritystats = {}

			for stat, value in pairs( v.stats ) do
				raritystats[ stat ] = ( math.random( value[ 1 ] * 100, value[ 2 ] * 100 ) / 100 ) / 100
			end

			self:SetRarityStatTable( raritystats )

			return
		end
		rarity_roll = rarity_roll - v.chance
	end
end

function ITEM:onEquipWeapon( client, wep )
	local raritystats = self:GetRarityStatTable()

	if !raritystats then return end

	for stat, mod in pairs(raritystats) do
		wep:StreamStat(stat, 1 + mod, true)
	end

	net.Start( "nut.ApplyWeaponStats" )
		net.WriteEntity( wep )
		net.WriteTable( raritystats )
	net.Send( self.player )

end

if CLIENT then
	net.Receive( "nut.ApplyWeaponStats", function( len, client )
		local wep = net.ReadEntity()
		local raritystats = net.ReadTable()

		if !IsValid( wep ) then return end

		for stat, mod in pairs(raritystats) do
			wep:StreamStat(stat, 1 + mod, true)
		end
	end )
end

local WEAPON = FindMetaTable("Weapon")

function WEAPON:StreamStat(stat, val, multiply)
	if !IsValid( self:GetOwner() ) then return end

	if (self.Primary and self.Primary[name]) then
		if multiply and isnumber(val) then
			self.Primary[name] = self.Primary[name]*val
		else
			self.Primary[name] = val
		end
	end

	if self[name] then
		if multiply and isnumber(val) then
			self[name] = self[name]*val
		else
			self[name] = val
		end
	end

	if (self.Secondary and self.Secondary[name]) then
		if multiply and isnumber(val) then
			self.Secondary[name] = self.Secondary[name]*val
		else
			self.Secondary[name] = val
		end
	end
end