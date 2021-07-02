// Add CUP Weapons
if ( GRLIB_CUPW_enabled ) then {
	// CUPS blacklisted
	GRLIB_CUPW_Blacklist = [
		"CUP_optic_AN_PAS_13c1",
		"CUP_optic_AN_PAS_13c2",
		"CUP_optic_GOSHAWK",
		"CUP_optic_GOSHAWK_RIS"
	];
	// CUP whitelisted
	GRLIB_whitelisted_from_arsenal = GRLIB_whitelisted_from_arsenal + [
		"Medikit",
		"FirstAidKit",
		"ToolKit",
		"ItemGPS",
		"Laserdesignator",
		"Binocular",
		"MineDetector",
		"Rangefinder"
	];

	// Weapons
	(
		"
		(getText (_x >> 'DLC') == 'CUP_Weapons' || getText (_x >> 'DLC') == 'CUP_Units') &&
		getNumber (_x >> 'scope') > 1 &&
		toLower (configName _x) find '_coyote' < 0 &&
		tolower (configName _x) find '_od' < 0 &&
		!((configName _x) in GRLIB_CUPW_Blacklist)
		"
		configClasses (configfile >> "CfgWeapons" )
	) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

	// Equipements (uniforme, etc..)
	(
		"
		(getText (_x >> 'DLC') == 'CUP_Weapons' || getText (_x >> 'DLC') == 'CUP_Units') &&
		!((configName _x) in GRLIB_CUPW_Blacklist)
		"
		configClasses (configfile >> "CfgWeapons" )
	) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

	// Others object (bagpack, etc..)
	(
		"
		(getText (_x >> 'DLC') == 'CUP_Weapons' || getText (_x >> 'DLC') == 'CUP_Units') &&
		!((configName _x) in GRLIB_CUPW_Blacklist) &&
		( (configName _x) find '_Bag' == -1 )
		"
		configClasses (configfile >> "CfgVehicles" )
	) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

	// Glasses
	(
		"
		(getText (_x >> 'DLC') == 'CUP_Weapons' || getText (_x >> 'DLC') == 'CUP_Units') &&
		!((configName _x) in GRLIB_CUPW_Blacklist)
		"
		configClasses (configfile >> "CfgGlasses" )
	) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

	// Magazines
	(
		"
		((configName _x) select [0,4]) == 'CUP_' &&
		(configName _x) find '_Tracer' < 0 &&
		!((configName _x) in GRLIB_CUPW_Blacklist)
		"
    	configClasses (configfile >> "CfgMagazines")
	) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;

    GRLIB_mod_enabled = true;
};
