 // Add EricJ Weapons
if ( GRLIB_EJW_enabled ) then {
    GRLIB_EJW_Blacklist = [
        "Afghan_01Hat",
        "Afghan_02Hat",
        "Afghan_03Hat",
        "Afghan_04Hat",
        "Afghan_05Hat",
        "Afghan_06Hat",        
        "U_Afghan01",
        "U_Afghan01NH",
        "U_Afghan02",
        "U_Afghan02NH",
        "U_Afghan03",
        "U_Afghan03NH",
        "U_Afghan04",
        "U_Afghan05",
        "U_Afghan06",
        "U_Afghan06NH"
	];
    (
        "
        getText (_x >> 'dlc') == 'u100' &&
        !((configName _x) in GRLIB_EJW_Blacklist)
        "
        configClasses (configfile >> "CfgWeapons" )
    ) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

    (
        "
        (tolower (configName _x) select [0,3]) == 'ej_' &&
		!((configName _x) in GRLIB_EJW_Blacklist)
        "
        configClasses (configfile >> "CfgMagazines")
    ) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;

	(
		"
        (tolower (configName _x) select [0,3]) == 'ej_' &&
		!((configName _x) in GRLIB_EJW_Blacklist)
		"
		configClasses (configfile >> "CfgVehicles" )
	) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

}; 
