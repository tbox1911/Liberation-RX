// Add ACE Weapons
GRLIB_MOD_signature = GRLIB_MOD_signature + ["ace_"];

(
	"
	tolower ((configName _x) select [0,3]) == 'ace'
	"
	configClasses (configfile >> "CfgVehicles")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;

(
	"
	tolower ((configName _x) select [0,3]) == 'ace'
	"
	configClasses (configfile >> "CfgGlasses")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;

(
	"
	tolower ((configName _x) select [0,3]) == 'ace'
	"
	configClasses (configfile >> "CfgMagazines")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;

(
	"
	tolower ((configName _x) select [0,3]) == 'ace' && 
	toLower (configName _x) find 'ace_debug' < 0 &&
	toLower (configName _x) find 'ace_ropebase' < 0 &&
	toLower (configName _x) find 'ace_itemcore' < 0 &&
	toLower (configName _x) find 'ace_dragon' < 0 &&
	toLower (configName _x) find 'ace_nvg' < 0 &&
	toLower (configName _x) find 'ace_key' < 0 &&
	toLower (configName _x) find 'ace_dogtag' < 0 &&
	toLower (configName _x) find 'ace_csw' < 0 &&
	toLower (configName _x) find 'ace_compat' < 0
	"
	configClasses (configfile >> "CfgWeapons")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;
