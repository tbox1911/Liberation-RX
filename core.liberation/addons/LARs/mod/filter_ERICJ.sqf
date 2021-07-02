 // Add EricJ Weapons
if ( GRLIB_EJW_enabled ) then {
    GRLIB_EJW_Blacklist = [
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
        (getText (_x >> 'ammo') select [0,3]) == 'ej_' &&
		!((configName _x) in GRLIB_EJW_Blacklist)
        "
        configClasses (configfile >> "CfgMagazines")
    ) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;

    GRLIB_mod_enabled = true;
}; 
