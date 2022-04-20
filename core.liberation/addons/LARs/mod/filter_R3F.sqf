// Add R3F Weapons

if ( GRLIB_R3F_enabled ) then {

	// Weapons + Equipements (uniforme, etc..)
	(
		"
		tolower ((configName _x) select [0,4]) == 'r3f_' &&
		!((configName _x) in GRLIB_blacklisted_from_arsenal)
		"
		configClasses (configfile >> "CfgWeapons" )
	) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

	// Others object (bagpack, etc..)
	(
		"
		tolower ((configName _x) select [0,4]) == 'r3f_' &&
		!((configName _x) in GRLIB_blacklisted_from_arsenal) &&
		( (configName _x) find '_Bag' == -1 )
		"
		configClasses (configfile >> "CfgVehicles" )
	) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

	// Glasses
	(
		"
		tolower ((configName _x) select [0,4]) == 'r3f_' &&
		!((configName _x) in GRLIB_blacklisted_from_arsenal)
		"
		configClasses (configfile >> "CfgGlasses" )
	) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

	// Magazines
	(
		"
		tolower ((configName _x) select [0,4]) == 'r3f_' &&
		tolower (configName _x) find '_tracer' < 0 &&
		!((configName _x) in GRLIB_blacklisted_from_arsenal)
		"
    	configClasses (configfile >> "CfgMagazines")
	) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;

};
