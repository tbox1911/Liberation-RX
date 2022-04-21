 // Add EricJ Weapons

// Weapons + Equipements (uniforme, etc..)
(
    "
    tolower (getText (_x >> 'dlc')) == 'u100' &&
    !((configName _x) in GRLIB_blacklisted_from_arsenal)
    "
    configClasses (configfile >> "CfgWeapons" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

(
    "
    tolower (getText (_x >> 'ammo') select [0,3]) == 'ej_'  &&
    !((configName _x) in GRLIB_blacklisted_from_arsenal)
    "
    configClasses (configfile >> "CfgMagazines")
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;

(
    "
    tolower (getText (_x >> 'dlc')) == 'u100' &&
    !((configName _x) in GRLIB_blacklisted_from_arsenal)
    "
    configClasses (configfile >> "CfgVehicles" )
) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;
