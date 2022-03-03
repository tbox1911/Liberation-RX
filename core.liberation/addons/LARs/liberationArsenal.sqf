// A custom Arsenal for Liberation RX
// from: https://github.com/LarrowZurb/BlacklistArsenal
if (isDedicated) exitWith {};
waitUntil {sleep 1; !isNil "GRLIB_limited_arsenal"};
waitUntil {sleep 1; !isNil "GRLIB_mod_enabled"};

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
[] call compileFinal preprocessFileLineNUmbers "addons\LARs\mod\filter_CUP.sqf";
// Add GM Weapons
[] call compileFinal preprocessFileLineNUmbers "addons\LARs\mod\filter_GM.sqf";
// Add OPTRE Weapons
[] call compileFinal preprocessFileLineNUmbers "addons\LARs\mod\filter_OPTRE.sqf";
 // Add EricJ Weapons
[] call compileFinal preprocessFileLineNUmbers "addons\LARs\mod\filter_EJW.sqf";
// Add RHS Weapons
[] call compileFinal preprocessFileLineNUmbers "addons\LARs\mod\filter_RHS.sqf";

// if mod enabled
if ( GRLIB_filter_arsenal && GRLIB_mod_enabled) then {
	[myLARsBox, ["GRLIB_whitelisted_from_arsenal", "GRLIB_blacklisted_from_arsenal"], false, "Liberation", { false }] call LARs_fnc_blacklistArsenal;
} else {
	//[ myBox, [ whitelist, blacklist ], targets, name, condition ] call LARs_fnc_blacklistArsenal;
	[myLARsBox, [GRLIB_arsenal_side, "GRLIB_blacklisted_from_arsenal"], false, "Liberation", { false }] call LARs_fnc_blacklistArsenal;
	waitUntil {sleep 0.5; !(isNil "LARs_initBlacklist")};

	//[ box, arsenalName, [ white, black ], _targets ] call LARs_fnc_updateArsenal
	[myLARsBox, "Liberation", ["GRLIB_whitelisted_from_arsenal"], false] call LARs_fnc_updateArsenal;
};