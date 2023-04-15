// Add ACE Weapons
GRLIB_MOD_signature = GRLIB_MOD_signature + ["ace_"];

(
	"
	tolower ((configName _x) select [0,3]) == 'ACE'
	"
	configClasses (configfile >> "CfgVehicles")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;

(
	"
	tolower ((configName _x) select [0,3]) == 'ACE'
	"
	configClasses (configfile >> "CfgGlasses")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;

(
	"
	tolower ((configName _x) select [0,3]) == 'ACE'
	"
	configClasses (configfile >> "CfgMagazines")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;

(
	"
	tolower ((configName _x) select [0,3]) == 'ACE'
	"
	configClasses (configfile >> "CfgWeapons")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;
