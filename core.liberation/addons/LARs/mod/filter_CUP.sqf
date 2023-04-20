// Add CUP Weapons
GRLIB_MOD_signature = GRLIB_MOD_signature + ["CUP_"];

private _exclude = [
	"CUP_RUS","CUP_G_RUS","CUP_H_RUS","CUP_V_RUS","CUP_O_","CUP_V_O","CUP_U_O_","CUP_I_B_","CUP_Vest_RUS",
	"CUP_H_TKI","CUP_B_TKI","CUP_Vest_TKI"
];

//as exemple
if (GRLIB_mod_west == "CP_AFRF") then { _exclude = ["CUP_B"] };
if (GRLIB_mod_west == "CWR3_SOV") then { _exclude = ["CUP_B"] };

// Weapons + Equipements (uniforms, etc..)
(
	"
	(tolower (getText (_x >> 'DLC')) == 'cup_weapons' || tolower (getText (_x >> 'DLC')) == 'cup_units') &&
	getNumber (_x >> 'scope') > 0 &&
	!([(configName _x), _exclude] call F_startsWithMultiple) &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgWeapons" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Others object (backpack, etc..)
(
	"
	(tolower (getText (_x >> 'DLC')) == 'cup_weapons' || tolower (getText (_x >> 'DLC')) == 'cup_units') &&
	!([(configName _x), _exclude] call F_startsWithMultiple) &&
	([(configName _x)] call is_allowed_item) &&
	( (configName _x) find '_Bag' == -1 ) &&
	((configName _x) iskindof 'Bag_Base') 
	"
	configClasses (configfile >> "CfgVehicles" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Glasses
(
	"
	(tolower (getText (_x >> 'DLC')) == 'cup_weapons' || tolower (getText (_x >> 'DLC')) == 'cup_units') &&
	!([(configName _x), _exclude] call F_startsWithMultiple) &&
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
