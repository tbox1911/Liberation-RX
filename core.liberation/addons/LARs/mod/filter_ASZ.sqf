// Add ASZ Weapons
GRLIB_MOD_signature = GRLIB_MOD_signature + [
	"B_mas_itl","U_mas_itl_","V_mas_itl_","G_mas_itl_",
	"hgun_","arifle_mas_itl_","srifle_mas_itl_","MMG_mas_itl_","LMG_mas_itl_","SMG_mas_itl_","launch_mas_itl_",
	"acc_","bipod_","optic_","muzzle_",
	"NVGoggles_mas_itl_","Laserdesignator_"
];
// Weapons + Equipements (uniforms, etc..)
(
	"
	(tolower (getText (_x >> 'DLC')) == 'itsof_lite_mas') &&
	getNumber (_x >> 'scope') > 0 &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgWeapons" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Weapon attachments
private _weapon_equ = ["muzzle_", "acc_", "optic_", "bipod_" ];
(
	"
	([(configName _x), _weapon_equ] call F_startsWithMultiple) &&
	getNumber (_x >> 'scope') > 0 &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgWeapons" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Others object (backpack, etc..)
(
	"
	(tolower (getText (_x >> 'DLC')) == 'itsof_lite_mas') &&
	([(configName _x)] call is_allowed_item) &&
	( (configName _x) find '_Bag' == -1 ) &&
	((configName _x) iskindof 'Bag_Base')
	"
	configClasses (configfile >> "CfgVehicles" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

// Glasses
(
	"
	(tolower (getText (_x >> 'DLC')) == 'itsof_lite_mas') &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgGlasses" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;
