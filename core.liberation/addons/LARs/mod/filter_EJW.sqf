 // Add EricJ Weapons
GRLIB_MOD_signature = GRLIB_MOD_signature + ["ej_"];

// Weapons + Equipements (uniforme, etc..)
(
    "
    tolower (getText (_x >> 'dlc')) == 'u100' &&
    getNumber (_x >> 'scope') > 1 &&
    ([(configName _x)] call is_allowed_item)
    "
    configClasses (configfile >> "CfgWeapons" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Others object (backpack, etc..)
(
    "
    tolower (getText (_x >> 'dlc')) == 'u100' &&
    ([(configName _x)] call is_allowed_item) &&
    ((configName _x) iskindof 'Bag_Base') 
    "
    configClasses (configfile >> "CfgVehicles" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Glasses
(
	"
	tolower (getText (_x >> 'dlc')) == 'u100' &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgGlasses" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Magazines
(
    "
    tolower (getText (_x >> 'ammo') select [0,3]) == 'ej_'  &&
    ([(configName _x)] call is_allowed_item)
    "
    configClasses (configfile >> "CfgMagazines")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;
