// A custom Arsenal for Liberation RX by pSiKO
// from: https://github.com/LarrowZurb/BlacklistArsenal

// How it's supposed to work:
//
// - EnableArsenal = 0    The Arsenal is completely disabled.
// - EnableArsenal = 1    The Arsenal is enabled and filled according to FilterArsenal value.
//                          - minus the blacklist (which still applies)
//                          + plus the whitelist (these items are still available)
//
// - FilterArsenal = 0    The Arsenal filter is completely disabled. 
//                        
// - FilterArsenal = 1    Soft Mode: The Arsenal only show your side gears.
//                        but the player can use other objects,
//                        from enemy equipment or anything else. (saved loadout).
//                        
// - FilterArsenal = 2    Strict Mode: The player can ONLY use items present in the Arsenal.
//                        he will not be able to use enemy weapons or anything else. (saved loadout).
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

// Initalize Blacklist
GRLIB_blacklisted_from_arsenal = [];			// Global blacklist (All objects will be removed from Arsenal)

// Initalize Withelist
GRLIB_whitelisted_from_arsenal = [];			// whitelist when Arsenal is enabled

[] call compileFinal preprocessFileLineNUmbers format ["mod_template\%1\arsenal.sqf", GRLIB_mod_west];

// Default LRX blacklist
GRLIB_blacklisted_from_arsenal = blacklisted_bag + blacklisted_weapon;

// Filters disabled 
if (GRLIB_filter_arsenal == 0) exitWith { diag_log "--- LRX Arsenal *Unfiltered* initialized." };

// Mod signature
GRLIB_MOD_signature = [];

// Add Mod Items (Weapons,Uniform,etc.)
[] call compileFinal preprocessFileLineNUmbers "addons\LARs\mod\filter_init.sqf";

// Dedup list
GRLIB_whitelisted_from_arsenal = GRLIB_whitelisted_from_arsenal arrayIntersect GRLIB_whitelisted_from_arsenal;
GRLIB_blacklisted_from_arsenal = GRLIB_blacklisted_from_arsenal arrayIntersect GRLIB_blacklisted_from_arsenal;

[myLARsBox, ["GRLIB_whitelisted_from_arsenal", "GRLIB_blacklisted_from_arsenal"], false, "Liberation", { false }] call LARs_fnc_blacklistArsenal;

diag_log format ["--- LRX Arsenal initialized. blacklist: %1 - whitelist: %2", count GRLIB_blacklisted_from_arsenal, count GRLIB_whitelisted_from_arsenal];