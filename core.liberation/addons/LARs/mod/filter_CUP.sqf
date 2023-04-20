// Add CUP Weapons
if ( GRLIB_CUPW_enabled ) then {
	// Weapons + Equipements (uniforms, etc..)
	(
		"
		(tolower (getText (_x >> 'DLC')) == 'cup_weapons' || tolower (getText (_x >> 'DLC')) == 'cup_units') &&
		!((configName _x) in GRLIB_blacklisted_from_arsenal)
		"
		configClasses (configfile >> "CfgWeapons" )
	) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

	// Others object (backpack, etc..)
	(
		"
		(tolower (getText (_x >> 'DLC')) == 'cup_weapons' || tolower (getText (_x >> 'DLC')) == 'cup_units') &&
		!((configName _x) in GRLIB_blacklisted_from_arsenal) &&
		( (configName _x) find '_Bag' == -1 )
		"
		configClasses (configfile >> "CfgVehicles" )
	) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

	// Glasses
	(
		"
		(tolower (getText (_x >> 'DLC')) == 'cup_weapons' || tolower (getText (_x >> 'DLC')) == 'cup_units') &&
		!((configName _x) in GRLIB_blacklisted_from_arsenal)
		"
		configClasses (configfile >> "CfgGlasses" )
	) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

	// Magazines
	(
		"
		tolower ((configName _x) select [0,4]) == 'cup_' &&
		(configName _x) find '_Tracer' < 0 &&
		!((configName _x) in GRLIB_blacklisted_from_arsenal)
		"
    	configClasses (configfile >> "CfgMagazines")
	) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;

};
