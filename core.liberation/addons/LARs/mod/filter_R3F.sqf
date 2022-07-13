// Add R3F Weapons
GRLIB_MOD_signature append ["r3f_"];

// Weapons + Equipements (uniforme, etc..)
(
	"
	tolower ((configName _x) select [0,4]) == 'r3f_' &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgWeapons" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Others object (bagpack, etc..)
(
	"
	tolower ((configName _x) select [0,4]) == 'r3f_' &&
	([(configName _x)] call is_allowed_item) &&
	((configName _x) iskindof 'Bag_Base') 
	"
	configClasses (configfile >> "CfgVehicles" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Glasses
(
	"
	tolower ((configName _x) select [0,4]) == 'r3f_' &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgGlasses" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Magazines
(
	"
	tolower ((configName _x) select [0,4]) == 'r3f_' &&
	tolower (configName _x) find '_tracer' < 0 &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgMagazines")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;
