// Add ACE Weapons
GRLIB_MOD_signature = GRLIB_MOD_signature + ["ACE_"];
GRLIB_blacklisted_from_arsenal append [
	"ace_intelitems_base",
	"ACE_ropeBase",
	"ACE_ItemCore",
	"ACE_FakeMagazine",
	"ACE_FakePrimaryWeapon",
	"ace_marker",
	"ACE_key",
	"ACE_dogtag"
];

(
	"
	tolower ((configName _x) select [0,4]) == 'ACE_' &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgVehicles")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;

(
	"
	tolower ((configName _x) select [0,4]) == 'ACE_' &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgGlasses")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;

(
	"
	tolower ((configName _x) select [0,4]) == 'ACE_' &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgMagazines")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;

(
	"
	tolower ((configName _x) select [0,4]) == 'ACE_' &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgWeapons")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;
