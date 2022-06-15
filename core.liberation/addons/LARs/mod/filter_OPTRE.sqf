// Add OPTRE Weapons

// Weapons
(
	"
	tolower (getText (_x >> 'dlc')) == 'optre' &&
	toLower (configName _x) find '_coyote' < 0 &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgWeapons" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Others object (bagpack, etc..)
(
	"
	tolower (getText (_x >> 'dlc')) == 'optre' &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgVehicles" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Glasses
(
	"
	tolower (getText (_x >> 'dlc')) == 'optre' &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgGlasses" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

(
	"
	tolower ((configName _x) select [0,6]) == 'optre_' &&
	tolower ((configName _x) find '_tracer' < 0 &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgMagazines")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;
