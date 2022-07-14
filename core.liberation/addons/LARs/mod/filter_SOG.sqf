// Add SOG Weapons
GRLIB_MOD_signature = GRLIB_MOD_signature + ["vn_"];

private _exclude = "vn_o";
if (GRLIB_mod_west == "SOG_VIETCONG") then { _exclude = "vn_b" };

// Weapons + Equipements (uniforme, etc..)
(
	"
	tolower ((configName _x) select [0,3]) == 'vn_' &&
	getNumber (_x >> 'scope') > 1 &&
	!([_exclude, (configName _x), true] call F_startsWith) &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgWeapons" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Others object (bagpack, etc..)
(
	"
	tolower ((configName _x) select [0,3]) == 'vn_' &&
	!([_exclude, (configName _x), true] call F_startsWith) &&
	([(configName _x)] call is_allowed_item) &&
	((configName _x) find '_Bag' == -1 ) &&
	((configName _x) iskindof 'Bag_Base') 
	"
	configClasses (configfile >> "CfgVehicles" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Glasses
(
	"
	tolower ((configName _x) select [0,3]) == 'vn_' &&
	!([_exclude, (configName _x), true] call F_startsWith) &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgGlasses" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Magazines
(
	"
	tolower ((configName _x) select [0,3]) == 'vn_' &&
	!([_exclude, (configName _x), true] call F_startsWith) &&
	tolower (configName _x) find '_t_mag' < 0 &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgMagazines")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;
