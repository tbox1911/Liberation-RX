// Add Gobal Mobilization Weapons

// Weapons + Equipements (uniforms, etc..)
(
	"
	tolower (getText (_x >> 'dlc')) == 'gm' &&
	getNumber (_x >> 'scope') > 1 &&
	toLower (configName _x) find '_coyote' < 0 &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgWeapons" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Magazines
(
	"
	tolower ((configName _x) select [0,3]) == 'gm_' &&
	(configName _x) find '_Tracer' < 0 &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgMagazines")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;
