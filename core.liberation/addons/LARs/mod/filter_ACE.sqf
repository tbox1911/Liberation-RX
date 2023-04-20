// Add ACE Weapons
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
GRLIB_MOD_signature = GRLIB_MOD_signature + ["ACE_"];
=======
GRLIB_MOD_signature = GRLIB_MOD_signature + ["ace_"];
>>>>>>> bfd9d463 (1)
=======
GRLIB_MOD_signature = GRLIB_MOD_signature + ["ace_"];
>>>>>>> 1e7c6bf8544b06f295ba289c00b1a91a80e63c04
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
<<<<<<< HEAD
=======
GRLIB_MOD_signature = GRLIB_MOD_signature + ["ace_"];

(
	"
	tolower ((configName _x) select [0,3]) == 'ACE'
>>>>>>> f456b13b (ACE Arsenal filtering + ACE Item filter logic)
=======
>>>>>>> 1e7c6bf8544b06f295ba289c00b1a91a80e63c04
	"
	configClasses (configfile >> "CfgVehicles")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;

(
	"
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
	tolower ((configName _x) select [0,4]) == 'ACE_' &&
=======
	tolower ((configName _x) select [0,4]) == 'ace_' &&
>>>>>>> bfd9d463 (1)
	([(configName _x)] call is_allowed_item)
=======
	tolower ((configName _x) select [0,3]) == 'ACE'
>>>>>>> f456b13b (ACE Arsenal filtering + ACE Item filter logic)
=======
	tolower ((configName _x) select [0,4]) == 'ace_' &&
	([(configName _x)] call is_allowed_item)
>>>>>>> 1e7c6bf8544b06f295ba289c00b1a91a80e63c04
	"
	configClasses (configfile >> "CfgGlasses")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;

(
	"
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
	tolower ((configName _x) select [0,4]) == 'ACE_' &&
=======
	tolower ((configName _x) select [0,4]) == 'ace_' &&
>>>>>>> bfd9d463 (1)
	([(configName _x)] call is_allowed_item)
=======
	tolower ((configName _x) select [0,3]) == 'ACE'
>>>>>>> f456b13b (ACE Arsenal filtering + ACE Item filter logic)
=======
	tolower ((configName _x) select [0,4]) == 'ace_' &&
	([(configName _x)] call is_allowed_item)
>>>>>>> 1e7c6bf8544b06f295ba289c00b1a91a80e63c04
	"
	configClasses (configfile >> "CfgMagazines")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;

(
	"
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
	tolower ((configName _x) select [0,4]) == 'ACE_' &&
=======
	tolower ((configName _x) select [0,4]) == 'ace_' &&
>>>>>>> bfd9d463 (1)
	([(configName _x)] call is_allowed_item)
=======
	tolower ((configName _x) select [0,3]) == 'ACE'
>>>>>>> f456b13b (ACE Arsenal filtering + ACE Item filter logic)
=======
	tolower ((configName _x) select [0,4]) == 'ace_' &&
	([(configName _x)] call is_allowed_item)
>>>>>>> 1e7c6bf8544b06f295ba289c00b1a91a80e63c04
	"
	configClasses (configfile >> "CfgWeapons")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;
