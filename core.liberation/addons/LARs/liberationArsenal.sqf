// A custom Arsenal for Liberation RX by pSiKO
// from: https://github.com/LarrowZurb/BlacklistArsenal

// How it's supposed to work:
//
// - EnableArsenal = 0    The Arsenal is completely disabled.
// - EnableArsenal = 1    The Arsenal is enabled and filled according to FilterArsenal value below:
//
// - FilterArsenal = 0    The Arsenal filter is completely disabled.  (no white/black list)
//
// - FilterArsenal = 1    Soft Mode: The Arsenal only show your side gears.
//                        but the player can use other objects,
//                        from enemy equipment or anything else. (from saved loadout).
//
// - FilterArsenal = 2    Strict Mode: The player can ONLY use items present in the Arsenal.
//                        he will not be able to use enemy weapons or anything else. (from saved loadout).
//
// - FilterArsenal = 3    Strict Mode + MOD: The player can ONLY use items present in the Arsenal.
//                        plus items from the current MOD.
//
// The Whitelist and Blacklist apply from FilterArsenal = 1 and up
//
// customize Arsenal:
// in the "mod_template\TEMPLATE\arsenal.sqf" file
//
// - to add an object:
//    add class name to "GRLIB_whitelisted_from_arsenal" list
//
// - to remove an object
//    add class name (or part) to "blacklisted_weapon" list

if (isDedicated) exitWith {};

// Init flag
LRX_arsenal_init_done = false;

// Filters disabled
waitUntil { sleep 1; !isNil "GRLIB_filter_arsenal" };
if (GRLIB_filter_arsenal == 0) exitWith {
    LRX_arsenal_init_done = true;
	//Enable ACE Arsenal for no filter cases
	if (GRLIB_ACE_enabled) then { [myLARsBox, true, false] call ace_arsenal_fnc_initBox };
    diag_log "--- LRX Arsenal filters disabled.";
};

// Init functions
LARs_fnc_createList = compileFinal preprocessFileLineNumbers "addons\LARs\blacklistArsenal\functions\fn_createList.sqf";
LARs_fnc_removeBlack = compileFinal preprocessFileLineNumbers "addons\LARs\blacklistArsenal\functions\fn_removeBlack.sqf";
LARs_fnc_updateArsenal = compileFinal preprocessFileLineNumbers "addons\LARs\blacklistArsenal\functions\fn_updateArsenal.sqf";
LARs_fnc_blacklistArsenal = compileFinal preprocessFileLineNumbers "addons\LARs\blacklistArsenal\functions\fn_blacklistArsenal.sqf";
LARs_fnc_initOverride = compileFinal preprocessFileLineNumbers "addons\LARs\blacklistArsenal\functions\override\fn_initOverride.sqf";
LARs_fnc_overrideVAButtonDown = compileFinal preprocessFileLineNumbers "addons\LARs\blacklistArsenal\functions\override\fn_overrideVAButtonDown.sqf";
LARs_fnc_overrideVATemplateOK = compileFinal preprocessFileLineNumbers "addons\LARs\blacklistArsenal\functions\override\fn_overrideVATemplateOK.sqf";

// LARs Init
[] call LARs_fnc_initOverride;

// Initalize Blacklist
GRLIB_blacklisted_from_arsenal = [];			// Global blacklist (All objects will be removed from Arsenal)

// Initalize Withelist
GRLIB_whitelisted_from_arsenal = [];			// whitelist when Arsenal is enabled

// Import list from Mod template
[] call compileFinal preprocessFileLineNUmbers format ["mod_template\%1\arsenal.sqf", GRLIB_mod_west];

// Default LRX blacklist
GRLIB_blacklisted_from_arsenal = blacklisted_bag + blacklisted_weapon;

// Default LRX whitelist
GRLIB_whitelisted_from_arsenal = [mobile_respawn_bag, "B_Parachute"] + whitelisted_from_arsenal;

// Mod signature
GRLIB_MOD_signature = [];

// Add Mod Items (Weapons,Uniform,etc.)
[] call compileFinal preprocessFileLineNUmbers "addons\LARs\mod\filter_init_west.sqf";
[] call compileFinal preprocessFileLineNUmbers "addons\LARs\mod\filter_init_east.sqf";

// Dedup list
GRLIB_MOD_signature = GRLIB_MOD_signature arrayIntersect GRLIB_MOD_signature;
GRLIB_whitelisted_from_arsenal = GRLIB_whitelisted_from_arsenal arrayIntersect GRLIB_whitelisted_from_arsenal;
GRLIB_blacklisted_from_arsenal = GRLIB_blacklisted_from_arsenal arrayIntersect GRLIB_blacklisted_from_arsenal;

// Initialize Arsenal
if (GRLIB_ACE_enabled) then {
	// Ace compat.
	[myLARsBox, GRLIB_whitelisted_from_arsenal, false] call ace_arsenal_fnc_initBox;
} else {
	[myLARsBox, ["GRLIB_whitelisted_from_arsenal", "GRLIB_blacklisted_from_arsenal"], false, "Liberation", { false }] call LARs_fnc_blacklistArsenal;
};

diag_log format ["--- LRX Arsenal initialized. blacklist: %1 - whitelist: %2", count GRLIB_blacklisted_from_arsenal, count GRLIB_whitelisted_from_arsenal];
diag_log format ["--- LRX MOD %1 use: %2 signatures", GRLIB_mod_west, count GRLIB_MOD_signature];

LRX_arsenal_init_done = true;