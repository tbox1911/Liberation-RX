// A custom Arsenal for Liberation RX
// from: https://github.com/LarrowZurb/BlacklistArsenal
if (isDedicated) exitWith {};
waitUntil {sleep 1; !isNil "GRLIB_limited_arsenal"};

// Initalize Blacklist
GRLIB_whitelisted_from_arsenal = [];
GRLIB_blacklisted_from_arsenal = [];

// Initalize Side
GRLIB_arsenal_side = WEST;

[] call compileFinal preprocessFileLineNUmbers format ["mod_template\%1\arsenal.sqf", GRLIB_mod_west];

// Check LRX option
if (GRLIB_limited_arsenal) then {
	GRLIB_blacklisted_from_arsenal = blacklisted_bag + blacklisted_weapon;
} else {
	GRLIB_blacklisted_from_arsenal = blacklisted_bag;
};

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
};

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
};

// Add OPTRE Weapons
if ( GRLIB_OPTRE_enabled ) then {
	 GRLIB_OPTRE_Blacklist = [
	];
	(
		"
		getText (_x >> 'dlc') == 'OPTRE' &&
		toLower (configName _x) find '_coyote' < 0 &&
		!((configName _x) in GRLIB_OPTRE_Blacklist)
		"
		configClasses (configfile >> "CfgWeapons" )
	) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

	(
		"
		((configName _x) select [0,6]) == 'OPTRE_' &&
		(configName _x) find '_Tracer' < 0 &&
		!((configName _x) in GRLIB_OPTRE_Blacklist)
		"
    	configClasses (configfile >> "CfgMagazines")
	) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;
};

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
}; 

// Add RHS Weapons
if ( GRLIB_RHS_enabled ) then {
	// RHS blacklisted
	GRLIB_RHS_Blacklist = [
	];
	// RHS whitelisted
	GRLIB_whitelisted_from_arsenal = GRLIB_whitelisted_from_arsenal + [
		"ItemGPS",
		"Laserdesignator",
		"Binocular",
		"MineDetector",
		"Rangefinder"
	];

	// Weapons + Equipements (uniforme, etc..)
	(
		"
		getText (_x >> 'DLC') == GRLIB_mod_west &&
		!((configName _x) in GRLIB_RHS_Blacklist)
		"
		configClasses (configfile >> "CfgWeapons" )
	) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

	// Others object (bagpack, etc..)
	(
		"
		getText (_x >> 'DLC') == GRLIB_mod_west &&
		!((configName _x) in GRLIB_RHS_Blacklist) 
		"
		configClasses (configfile >> "CfgVehicles" )
	) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

	// Glasses
	(
		"
		getText (_x >> 'DLC') == GRLIB_mod_west &&
		!((configName _x) in GRLIB_RHS_Blacklist)
		"
		configClasses (configfile >> "CfgGlasses" )
	) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x) } ;

	// Magazines
	(
		"
		((configName _x) select [0,4]) == 'rhs_' &&
		(configName _x) find '_Tracer' < 0 &&
		!((configName _x) in GRLIB_RHS_Blacklist)
		"
    	configClasses (configfile >> "CfgMagazines")
	) apply { GRLIB_whitelisted_from_arsenal pushback (configName _x)} ;
};

// if mod enabled
if ( GRLIB_CUPW_enabled || GRLIB_GM_enabled || GRLIB_OPTRE_enabled || GRLIB_EJW_enabled || GRLIB_RHS_enabled) then {
	[myLARsBox, ["GRLIB_whitelisted_from_arsenal", "GRLIB_blacklisted_from_arsenal"], false, "Liberation", { false }] call LARs_fnc_blacklistArsenal;
} else {
	//[ myBox, [ whitelist, blacklist ], targets, name, condition ] call LARs_fnc_blacklistArsenal;
	[myLARsBox, [GRLIB_arsenal_side, "GRLIB_blacklisted_from_arsenal"], false, "Liberation", { false }] call LARs_fnc_blacklistArsenal;
	waitUntil {sleep 0.5; !(isNil "LARs_initBlacklist")};

	//[ box, arsenalName, [ white, black ], _targets ] call LARs_fnc_updateArsenal
	[myLARsBox, "Liberation", ["GRLIB_whitelisted_from_arsenal"], false] call LARs_fnc_updateArsenal;
};