RARITY.name = "Divine"
RARITY.desc = "TEMPLATE."
RARITY.color = function() return util.PulseColour( 1, Color( 100, 100, 100 ), Color( 235, 235, 235 ) ) end
RARITY.chance = 10

RARITY.stats = {
	[ "damage" ] 	= { -3, 3 },		-- percentage based to 2 decimal places
	[ "recoil" ] 	= { -3, 3 },		-- percentage based to 2 decimal places
	[ "spread" ] 	= { -3, 3 },		-- percentage based to 2 decimal places
	[ "rpm" ] 		= { -3, 3 },		-- percentage based to 2 decimal places
}