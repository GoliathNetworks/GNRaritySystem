nut.raritys = nut.raritys or {}
nut.raritys.list = nut.raritys.list or {}
nut.raritys.globals = nut.raritys.globals or {}

nut.raritys.globals[ "totalChance" ] = 0
nut.raritys.globals[ "totalRaritys" ] = 0

function nut.raritys.LoadFromDir( directory )

	for _, v in ipairs( file.Find( directory.."/sh_*.lua", "LUA" ) ) do
		local niceName = v:sub(4, -5)
		RARITY = {}
		RARITY.uniqueID = niceName

		nut.util.include(directory .. "/" .. v, "shared")

		if !RARITY.name then
			RARITY.name = niceName
		end
		if !RARITY.color then
			RARITY.color = Color(255, 255, 255)
		end
		if !RARITY.desc then
			RARITY.desc = "No description."
		end
		if !RARITY.chance then
			RARITY.chance = 1
		end

		-- print( RARITY.chance )

		nut.raritys.globals[ "totalChance" ] = nut.raritys.globals[ "totalChance" ] + RARITY.chance
		nut.raritys.globals[ "totalRaritys" ] = nut.raritys.globals[ "totalRaritys" ] + 1
		nut.raritys.list[ RARITY.uniqueID ] = RARITY

		RARITY = nil
	end
end