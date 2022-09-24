// Add ArmA3 Weapons
private _exclude = "O_";
if (["A3_OPF", GRLIB_mod_west, true] call F_startsWith) then { _exclude = "B_" };

// Weapons + Equipements (uniforms, etc..)
private _A3_Items = [
	"acc_","hgun_","arifle_","srifle_","MMG_","LMG_","SMG_","bipod_","launch_","optic_","muzzle_",
	"Laserdesignator_","H_Bandanna_","H_Beret_","H_Booniehat_","H_Cap_","H_Hat_","H_Helmet","H_MilCap_",
	"H_PASGT_","U_B_","U_BG_","U_C_","U_I_","U_O_","V_","NVGoggles"
];
GRLIB_MOD_signature = GRLIB_MOD_signature + _A3_Items + ["B_","O_","I_","U_"];
(
	"
	(getText (_x >> 'author')) == 'Bohemia Interactive' &&
	getNumber (_x >> 'scope') > 1 &&
	!([_exclude, (configName _x), true] call F_startsWith) &&
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
	!([_exclude, (configName _x), true] call F_startsWith) &&
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
	!([_exclude, (configName _x), true] call F_startsWith) &&
	([(configName _x)] call is_allowed_item) &&
	(
		(tolower (configName _x) find 'rnd_' >= 0 && tolower (configName _x) find '_tracer' < 0) ||
		([(configName _x), _A3_Items] call F_startsWithMultiple)
	)
	"
	configClasses (configfile >> "CfgMagazines")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;
