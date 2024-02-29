local PLUGIN = PLUGIN

function PLUGIN:DoPluginIncludes( path )
	if path then
		nut.raritys.LoadFromDir( path .. "/raritys" )
	end
end