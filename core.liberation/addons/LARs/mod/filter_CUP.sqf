// Add CUP Weapons

// Weapons + Equipements (uniforms, etc..)
(
	"
	(tolower (getText (_x >> 'DLC')) == 'cup_weapons' || tolower (getText (_x >> 'DLC')) == 'cup_units') &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgWeapons" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Others object (backpack, etc..)
(
	"
	(tolower (getText (_x >> 'DLC')) == 'cup_weapons' || tolower (getText (_x >> 'DLC')) == 'cup_units') &&
	([(configName _x)] call is_allowed_item) &&
	( (configName _x) find '_Bag' == -1 )
	"
	configClasses (configfile >> "CfgVehicles" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Glasses
(
	"
	(tolower (getText (_x >> 'DLC')) == 'cup_weapons' || tolower (getText (_x >> 'DLC')) == 'cup_units') &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgGlasses" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Magazines
(
	"
	tolower ((configName _x) select [0,4]) == 'cup_' &&
	tolower (configName _x) find '_tracer' < 0 &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgMagazines")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;
