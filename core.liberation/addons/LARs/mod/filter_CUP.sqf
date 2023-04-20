// Add CUP Weapons
if ( GRLIB_CUPW_enabled ) then {
	// Weapons + Equipements (uniforme, etc..)
	(
		"
		(getText (_x >> 'DLC') == 'CUP_Weapons' || getText (_x >> 'DLC') == 'CUP_Units') &&
		!((configName _x) in GRLIB_blacklisted_from_arsenal)
		"
		configClasses (configfile >> "CfgWeapons" )
	) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

	// Others object (bagpack, etc..)
	(
		"
		(getText (_x >> 'DLC') == 'CUP_Weapons' || getText (_x >> 'DLC') == 'CUP_Units') &&
		!((configName _x) in GRLIB_blacklisted_from_arsenal) &&
		( (configName _x) find '_Bag' == -1 )
		"
		configClasses (configfile >> "CfgVehicles" )
	) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

	// Glasses
	(
		"
		(getText (_x >> 'DLC') == 'CUP_Weapons' || getText (_x >> 'DLC') == 'CUP_Units') &&
		!((configName _x) in GRLIB_blacklisted_from_arsenal)
		"
		configClasses (configfile >> "CfgGlasses" )
	) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

	// Magazines
	(
		"
		((configName _x) select [0,4]) == 'CUP_' &&
		(configName _x) find '_Tracer' < 0 &&
		!((configName _x) in GRLIB_blacklisted_from_arsenal)
		"
    	configClasses (configfile >> "CfgMagazines")
	) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;

};
