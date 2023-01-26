// Add ArmA3 Weapons
private _A3_exclude = ["O_","U_O_","U_OG_"];
if (["A3_OPF", GRLIB_mod_west, true] call F_startsWith) then { _A3_exclude = ["B_","U_B_","U_BG_"] };

// Weapons + Equipements (uniforms, etc..)
private _A3_Items = [
	"B_","U_B_","U_BG_","O_","U_O_","U_OG_","I_","U_I_","C_","U_C_","H_","V_",
	"acc_","hgun_","arifle_","srifle_","MMG_","LMG_","SMG_","bipod_","launch_","optic_","muzzle_",
	"Laserdesignator_","NVGoggles"
] - _A3_exclude;

GRLIB_MOD_signature = GRLIB_MOD_signature + _A3_Items;
(
	"
	(getText (_x >> 'author')) == 'Bohemia Interactive' &&
	getNumber (_x >> 'scope') > 1 &&
    ([(configName _x)] call is_allowed_item) &&
    ([(configName _x), _A3_Items] call F_startsWithMultiple)
	"
	configClasses (configfile >> "CfgWeapons" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Others object (backpack, etc..)
(
	"
	(getText (_x >> 'author')) == 'Bohemia Interactive' &&
	([(configName _x)] call is_allowed_item) &&
	((configName _x) iskindof 'Bag_Base') 
	"
	configClasses (configfile >> "CfgVehicles" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Glasses
(
	"
	(getText (_x >> 'author')) == 'Bohemia Interactive' &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgGlasses" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Magazines
private _A3_Items = [
	"Vorona_","Titan_","RPG32_","NLAW_F","MRAWS_","Chemlight_","SmokeShell"
];

(
	"
    (getText (_x >> 'author')) == 'Bohemia Interactive' &&
	([(configName _x)] call is_allowed_item) &&
	(
		(tolower (configName _x) find 'rnd_' >= 0 && tolower (configName _x) find '_tracer' < 0) ||
		([(configName _x), _A3_Items] call F_startsWithMultiple)
	)
	"
	configClasses (configfile >> "CfgMagazines")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;
