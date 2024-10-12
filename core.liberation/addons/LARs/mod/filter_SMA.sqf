// Add Specialist Military Arms Weapons
GRLIB_MOD_signature = GRLIB_MOD_signature + ["SMA_"];

// Weapons + Equipements (uniforme, etc..)
(
	"
	((configName _x) select [0,4]) == 'SMA_' &&
	getNumber (_x >> 'scope') > 1 &&
	([(configName _x)] call is_allowed_item)
	"
	configClasses (configfile >> "CfgWeapons" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;
