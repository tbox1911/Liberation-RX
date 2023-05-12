// Add ACE Weapons
GRLIB_MOD_signature = GRLIB_MOD_signature + ["ace_"];
GRLIB_blacklisted_from_arsenal append [
	"ace_intelitems_base",
	"ACE_DebugPotato",
	"ACE_Vector",
	"ACE_ropeBase",
	"ACE_ItemCore",
	"ACE_FakeMagazine",
	"ACE_FakePrimaryWeapon",
	"ACE_DebugPotato",
	"ace_marker",
	"ACE_key",
	"ACE_NVG",
	"ace_dragon_sight",
	"ACE_Vector",
	"ACE_Yardage450",
	"ace_gunbag",
	"ACE_launch_NLAW_ready_F",
	"ACE_launch_NLAW_used_F",
	"ace_csw",
	"ace_compat",
	"ace_dragon_super",
	"ACE_dogtag"
];

(
	"
	tolower ((configName _x) select [0,4]) == 'ace_' &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgVehicles")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;

(
	"
	tolower ((configName _x) select [0,4]) == 'ace_' &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgGlasses")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;

(
	"
	tolower ((configName _x) select [0,4]) == 'ace_' &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgMagazines")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;

(
	"
	tolower ((configName _x) select [0,4]) == 'ace_' &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgWeapons")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;
