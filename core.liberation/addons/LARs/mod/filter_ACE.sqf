// Add ACE Weapons
<<<<<<< HEAD
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
=======
GRLIB_MOD_signature = GRLIB_MOD_signature + ["ace_"];

(
	"
	tolower ((configName _x) select [0,3]) == 'ACE'
>>>>>>> f456b13b (ACE Arsenal filtering + ACE Item filter logic)
	"
	configClasses (configfile >> "CfgVehicles")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;

(
	"
<<<<<<< HEAD
	tolower ((configName _x) select [0,4]) == 'ACE_' &&
	([(configName _x)] call is_allowed_item)
=======
	tolower ((configName _x) select [0,3]) == 'ACE'
>>>>>>> f456b13b (ACE Arsenal filtering + ACE Item filter logic)
	"
	configClasses (configfile >> "CfgGlasses")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;

(
	"
<<<<<<< HEAD
	tolower ((configName _x) select [0,4]) == 'ACE_' &&
	([(configName _x)] call is_allowed_item)
=======
	tolower ((configName _x) select [0,3]) == 'ACE'
>>>>>>> f456b13b (ACE Arsenal filtering + ACE Item filter logic)
	"
	configClasses (configfile >> "CfgMagazines")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;

(
	"
<<<<<<< HEAD
	tolower ((configName _x) select [0,4]) == 'ACE_' &&
	([(configName _x)] call is_allowed_item)
=======
	tolower ((configName _x) select [0,3]) == 'ACE'
>>>>>>> f456b13b (ACE Arsenal filtering + ACE Item filter logic)
	"
	configClasses (configfile >> "CfgWeapons")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;
