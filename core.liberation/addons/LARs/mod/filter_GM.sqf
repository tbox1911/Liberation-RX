// Add GM Weapons
if ( GRLIB_GM_enabled ) then {
	 GRLIB_GM_Blacklist = [
	];
	(
		"
		getText (_x >> 'dlc') == 'gm' &&
		getNumber (_x >> 'scope') > 1 &&
		toLower (configName _x) find '_coyote' < 0 &&
		!((configName _x) in GRLIB_GM_Blacklist)
		"
		configClasses (configfile >> "CfgWeapons" )
	) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

	(
		"
		((configName _x) select [0,3]) == 'gm_' &&
		(configName _x) find '_Tracer' < 0 &&
		!((configName _x) in GRLIB_GM_Blacklist)
		"
    	configClasses (configfile >> "CfgMagazines")
	) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;
    
    GRLIB_mod_enabled = true;
};
