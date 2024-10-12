// Add Unsung Weapons
GRLIB_MOD_signature = GRLIB_MOD_signature + ["uns_"];
// Weapons + Equipements (uniforme, etc..)
(
	"
	(getText (_x >> 'DLC') == GRLIB_mod_west || (['uns_', (configName _x), false] call F_startsWith)) &&
	getNumber (_x >> 'scope') > 1 &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgWeapons" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Others object (bagpack, etc..)
(
	"
	(getText (_x >> 'DLC') == GRLIB_mod_west || (['uns_', (configName _x), false] call F_startsWith)) &&
	([(configName _x)] call is_allowed_item) &&
	((configName _x) iskindof 'Bag_Base')
	"
	configClasses (configfile >> "CfgVehicles" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Glasses
(
	"
	(getText (_x >> 'DLC') == GRLIB_mod_west || (['uns_', (configName _x), false] call F_startsWith) ) &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgGlasses" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;
