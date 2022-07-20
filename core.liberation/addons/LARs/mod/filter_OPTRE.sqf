// Add OPTRE Weapons
GRLIB_MOD_signature = GRLIB_MOD_signature + ["optre_"];

// Weapons
private _OPTRE_Items = [
	"OPTRE_Ins","OPTRE_HMG38","OPTRE_UNSC_","OPTRE_MA3","OPTRE_MA5","OPTRE_Commando","OPTRE_BR","OPTRE_BM","OPTRE_SR","OPTRE_h",
	"OPTRE_M2","OPTRE_M3","OPTRE_M4","OPTRE_M5","OPTRE_M6","OPTRE_M7"
];

(
	"
	tolower (getText (_x >> 'dlc')) == 'optre' &&
	getNumber (_x >> 'scope') > 1 &&
	([(configName _x)] call is_allowed_item) &&
	([(configName _x), _OPTRE_Items] call F_startsWithMultiple)
	"
	configClasses (configfile >> "CfgWeapons" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Others object (bagpack, etc..)
(
	"
	tolower (getText (_x >> 'dlc')) == 'optre' &&
	([(configName _x)] call is_allowed_item) &&
	((configName _x) iskindof 'Bag_Base') 
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
	([(configName _x)] call is_allowed_item) &&
	tolower (configName _x) find '_tracer' < 0
	"
	configClasses (configfile >> "CfgMagazines")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;
