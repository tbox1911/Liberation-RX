// Add DLC: CSLA Iron Curtain

GRLIB_MOD_signature = GRLIB_MOD_signature + ["US85_","CSLA_","AFMC_","FIA_"];

// Weapons + Equipements (uniforms, etc..)
(
	"
	([(configName _x), GRLIB_MOD_signature] call F_startsWithMultiple) &&
	getNumber (_x >> 'scope') > 1 &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgWeapons" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Others object (backpack, etc..)
(
	"
	([(configName _x), GRLIB_MOD_signature] call F_startsWithMultiple) &&
	([(configName _x)] call is_allowed_item) &&
	((configName _x) iskindof 'Bag_Base')
	"
	configClasses (configfile >> "CfgVehicles" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Glasses
(
	"
	([(configName _x), GRLIB_MOD_signature] call F_startsWithMultiple) &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgGlasses" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;
