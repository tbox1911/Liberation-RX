// A custom Arsenal for Liberation RX
// from: https://github.com/LarrowZurb/BlacklistArsenal
if (isDedicated) exitWith {};

// Initalize Blacklist
GRLIB_blacklisted_from_arsenal = [];			// Global blacklist (All objects will be removed from Arsenal)

// Initalize Withelist
GRLIB_whitelisted_from_arsenal = [];			// whitelist when Arsenal is enabled

[] call compileFinal preprocessFileLineNUmbers format ["mod_template\%1\arsenal.sqf", GRLIB_mod_west];

// Default LRX blacklist
GRLIB_blacklisted_from_arsenal = blacklisted_bag + blacklisted_weapon;

// Add ArmA3 Weapons
if (["A3_", GRLIB_mod_west, true] call F_startsWith) then {
	[] call compileFinal preprocessFileLineNUmbers "addons\LARs\mod\filter_A3.sqf";
};
// Add CUP Weapons
if (["CP_", GRLIB_mod_west, true] call F_startsWith) then {
	[] call compileFinal preprocessFileLineNUmbers "addons\LARs\mod\filter_CUP.sqf";
};
// Add GM Weapons
if (["GM_", GRLIB_mod_west, true] call F_startsWith) then {
	[] call compileFinal preprocessFileLineNUmbers "addons\LARs\mod\filter_GM.sqf";
};
// Add OPTRE Weapons
if (["OPTRE_", GRLIB_mod_west, true] call F_startsWith) then {
	[] call compileFinal preprocessFileLineNUmbers "addons\LARs\mod\filter_OPTRE.sqf";
};
// Add EricJ Weapons
if (["EJW_", GRLIB_mod_west, true] call F_startsWith) then {
	[] call compileFinal preprocessFileLineNUmbers "addons\LARs\mod\filter_EJW.sqf";
};
// Add RHS Weapons
if (["RHS_", GRLIB_mod_west, true] call F_startsWith) then {
	[] call compileFinal preprocessFileLineNUmbers "addons\LARs\mod\filter_RHS.sqf";
};
// Add R3F/AMF Weapons
if (["R3F_", GRLIB_mod_west, true] call F_startsWith) then {
	[] call compileFinal preprocessFileLineNUmbers "addons\LARs\mod\filter_R3F.sqf";
	[] call compileFinal preprocessFileLineNUmbers "addons\LARs\mod\filter_AMF.sqf";
};
// Add SOG Weapons
if (["SOG_", GRLIB_mod_west, true] call F_startsWith) then {
	[] call compileFinal preprocessFileLineNUmbers "addons\LARs\mod\filter_SOG.sqf";
};
// Add 3CB Weapons
if (["3CB_", GRLIB_mod_west, true] call F_startsWith) then {
	[] call compileFinal preprocessFileLineNUmbers "addons\LARs\mod\filter_3CB.sqf";
};
// Add CWR Weapons
if (["CWR_", GRLIB_mod_west, true] call F_startsWith) then {
	[] call compileFinal preprocessFileLineNUmbers "addons\LARs\mod\filter_CWR.sqf";
};

// Dedup list
GRLIB_whitelisted_from_arsenal = GRLIB_whitelisted_from_arsenal arrayIntersect GRLIB_whitelisted_from_arsenal;
GRLIB_blacklisted_from_arsenal = GRLIB_blacklisted_from_arsenal arrayIntersect GRLIB_blacklisted_from_arsenal;

[myLARsBox, ["GRLIB_whitelisted_from_arsenal", "GRLIB_blacklisted_from_arsenal"], false, "Liberation", { false }] call LARs_fnc_blacklistArsenal;

diag_log format ["--- LRX Arsenal initialized. blacklist: %1 - whitelist: %2", count GRLIB_blacklisted_from_arsenal, count GRLIB_whitelisted_from_arsenal];