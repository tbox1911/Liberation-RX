// Add IFA3 Weapons
GRLIB_MOD_signature = GRLIB_MOD_signature + ["LIB_","B_LIB_","G_LIB_","H_LIB_","U_LIB_","V_LIB_"];

// Weapons + Equipements (uniforms, etc..)
(
	"
	getNumber (_x >> 'scope') > 1 &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgWeapons" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Others object (backpack, etc..)
(
	"
	([(configName _x)] call is_allowed_item) &&
	((configName _x) iskindof 'Bag_Base')
	"
	configClasses (configfile >> "CfgVehicles" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Glasses
(
	"
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgGlasses" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Magazines
(
	"
	getNumber (_x >> 'scope') > 1 &&
	(getNumber (_x >> 'type') == 256 || (getText (_x >> 'type') find '256') >= 0) &&
	tolower (configName _x) find '_tracer' < 0 &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgMagazines")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;
