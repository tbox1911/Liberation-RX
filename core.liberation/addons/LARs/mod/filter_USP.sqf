// Add USP AiO
GRLIB_MOD_signature = GRLIB_MOD_signature + ["usp_","USP_"];
GRLIB_blacklisted_from_arsenal append [
];

(
	"
	tolower ((configName _x) select [0,4]) == 'usp_' &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgVehicles")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;

(
	"
	tolower ((configName _x) select [0,4]) == 'usp_' &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgGlasses")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;

(
	"
	tolower ((configName _x) select [0,4]) == 'usp_' &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgWeapons")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;
