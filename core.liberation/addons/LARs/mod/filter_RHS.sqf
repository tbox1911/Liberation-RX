// Add RHS Weapons
GRLIB_MOD_signature = GRLIB_MOD_signature + ["rhs"];

// Weapons + Equipements (uniforme, etc..)
(
	"
	getText (_x >> 'DLC') == GRLIB_mod_west &&
	getNumber (_x >> 'scope') > 1 &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgWeapons" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Others object (bagpack, etc..)
(
	"
	getText (_x >> 'DLC') == GRLIB_mod_west &&
	([(configName _x)] call is_allowed_item)  &&
	((configName _x) iskindof 'Bag_Base') 
	"
	configClasses (configfile >> "CfgVehicles" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Glasses
(
	"
	getText (_x >> 'DLC') == GRLIB_mod_west &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgGlasses" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Magazines
(
	"
	((configName _x) select [0,3]) == 'rhs' &&
	(configName _x) find '_Tracer' < 0 &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgMagazines")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;
