// A custom Arsenal for Liberation RX
// from: https://github.com/LarrowZurb/BlacklistArsenal
if (isDedicated) exitWith {};
waitUntil {sleep 1; !isNil "GRLIB_limited_arsenal"};
waitUntil {sleep 1; !isNil "GRLIB_mod_enabled"};

// Initalize Blacklist
GRLIB_blacklisted_from_arsenal = [];			// Global blacklist (All objects will be removed from Arsenal)

// Initalize Withelist
GRLIB_whitelisted_from_arsenal = [];			// whitelist when Arsenal is enabled
GRLIB_whitelisted_from_arsenal_limited = [];	// minimal whitelist when MOD filter is enabled

// Initalize Side
GRLIB_arsenal_side = WEST;

[] call compileFinal preprocessFileLineNUmbers format ["mod_template\%1\arsenal.sqf", GRLIB_mod_west];

// Check LRX option
if (GRLIB_limited_arsenal) then {
	GRLIB_blacklisted_from_arsenal = blacklisted_bag + blacklisted_weapon;
} else {
	GRLIB_blacklisted_from_arsenal = blacklisted_bag;
};
if (GRLIB_mod_enabled) then {
	[] call compileFinal preprocessFileLineNUmbers "addons\LARs\mod\whitelist_arsenal_limited.sqf";
};

// Add CUP Weapons
if (GRLIB_filter_arsenalCUP) then {	
	[] call compileFinal preprocessFileLineNUmbers "addons\LARs\mod\filter_CUP.sqf";
};
// Add GM Weapons
if (GRLIB_filter_arsenalGM) then {
	[] call compileFinal preprocessFileLineNUmbers "addons\LARs\mod\filter_GM.sqf";
};
// Add OPTRE Weapons
if (GRLIB_filter_arsenalOPTRE) then {
	[] call compileFinal preprocessFileLineNUmbers "addons\LARs\mod\filter_OPTRE.sqf";
};
// Add EricJ Weapons
if (GRLIB_filter_arsenalEJW) then {
	[] call compileFinal preprocessFileLineNUmbers "addons\LARs\mod\filter_EJW.sqf";
};
// Add RHS Weapons
if (GRLIB_filter_arsenalRHS) then {	
	[] call compileFinal preprocessFileLineNUmbers "addons\LARs\mod\filter_RHS.sqf";
};
// Add R3F/AMF Weapons
if (GRLIB_filter_arsenalR3F) then {
	[] call compileFinal preprocessFileLineNUmbers "addons\LARs\mod\filter_R3F.sqf";
	[] call compileFinal preprocessFileLineNUmbers "addons\LARs\mod\filter_AMF.sqf";
};
// Add SOG Weapons
if (GRLIB_filter_arsenalSOG) then {	
	[] call compileFinal preprocessFileLineNUmbers "addons\LARs\mod\filter_SOG.sqf";
};

if (GRLIB_mod_enabled) then {
	[myLARsBox, ["GRLIB_whitelisted_from_arsenal", "GRLIB_blacklisted_from_arsenal"], false, "Liberation", { false }] call LARs_fnc_blacklistArsenal;
} else {
	//[ myBox, [ whitelist, blacklist ], targets, name, condition ] call LARs_fnc_blacklistArsenal;
	[myLARsBox, [GRLIB_arsenal_side, "GRLIB_blacklisted_from_arsenal"], false, "Liberation", { false }] call LARs_fnc_blacklistArsenal;
	waitUntil {sleep 0.5; !(isNil "LARs_initBlacklist")};

	//[ box, arsenalName, [ white, black ], _targets ] call LARs_fnc_updateArsenal
	[myLARsBox, "Liberation", ["GRLIB_whitelisted_from_arsenal"], false] call LARs_fnc_updateArsenal;
};