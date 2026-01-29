// A custom Arsenal Filter for Liberation RX by pSiKO
// from a script of LarrowZurb ()https://github.com/LarrowZurb/BlacklistArsenal)

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
// - FilterArsenal = 4    Personal Arsenal - you have what you've put in, no access to the Virtual Arsenal
//
// - FilterArsenal = 5    Whitelist/Blacklist Only - no autofill the Virtual Arsenal
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

LRX_arsenal_init_done = false;
waitUntil { sleep 1; !isNil "GRLIB_filter_arsenal" };

// Filters disabled
if (GRLIB_filter_arsenal == 0) exitWith {
	//Enable ACE Arsenal for no filter cases
	if (GRLIB_ACE_enabled) then { [myLARsBox, true, false] call ace_arsenal_fnc_initBox };
    LRX_arsenal_init_done = true;
    diag_log "--- LRX Arsenal filters disabled.";
};

// Personal Arsenal
if (GRLIB_filter_arsenal == 4) exitWith {
	waitUntil {
		sleep 1;
		GRLIB_personal_arsenal = player getVariable "GRLIB_personal_arsenal";
		!(isNil "GRLIB_personal_arsenal")
	};

	// Create Personal Arsenal Box
	GRLIB_personal_box_capacity = 30000;
	GRLIB_personal_box = Arsenal_typename createVehicle (markerPos GRLIB_respawn_marker);
	GRLIB_personal_box allowDamage false;
	[GRLIB_personal_box, GRLIB_personal_box_capacity] remoteExec ["setMaxLoad", 2];
	[GRLIB_personal_box, true] remoteExec ["hideObjectGlobal", 2];
	GRLIB_personal_box setVariable ["GRLIB_personal_box_pos", getPos GRLIB_personal_box];
	[GRLIB_personal_box] call F_clearCargo;
	[GRLIB_personal_box, GRLIB_personal_arsenal] call F_setCargo;

	diag_log format ["--- LRX Personal Arsenal initialized. (%1)", count GRLIB_personal_arsenal];
	LRX_arsenal_init_done = true;
};

if (GRLIB_filter_arsenal in [1,2,3,5]) then {
	if (GRLIB_filter_arsenal != 5) then {
		// Add Mod Items (Weapons,Uniform,etc.)
		[] call compileFinal preprocessFileLineNumbers "addons\LARs\mod\filter_init_west.sqf";
		[] call compileFinal preprocessFileLineNumbers "addons\LARs\mod\filter_init_east.sqf";
	};

	// Dedup list
	GRLIB_MOD_signature = GRLIB_MOD_signature arrayIntersect GRLIB_MOD_signature;
	GRLIB_whitelisted_from_arsenal = GRLIB_whitelisted_from_arsenal arrayIntersect GRLIB_whitelisted_from_arsenal;
	GRLIB_blacklisted_from_arsenal = GRLIB_blacklisted_from_arsenal arrayIntersect GRLIB_blacklisted_from_arsenal;

	// Initialize Arsenal
	if (GRLIB_ACE_enabled) then {
		// ACE Arsenal
		[myLARsBox, false, false] call ace_arsenal_fnc_initBox;
		[myLARsBox, GRLIB_whitelisted_from_arsenal, false] call ace_arsenal_fnc_addVirtualItems;
		[myLARsBox, GRLIB_blacklisted_from_arsenal, false] call ace_arsenal_fnc_removeVirtualItems;
	} else {
		// LARS Arsenal Override
		LARs_fnc_createList = compileFinal preprocessFileLineNumbers "addons\LARs\blacklistArsenal\functions\fn_createList.sqf";
		LARs_fnc_removeBlack = compileFinal preprocessFileLineNumbers "addons\LARs\blacklistArsenal\functions\fn_removeBlack.sqf";
		LARs_fnc_updateArsenal = compileFinal preprocessFileLineNumbers "addons\LARs\blacklistArsenal\functions\fn_updateArsenal.sqf";
		LARs_fnc_blacklistArsenal = compileFinal preprocessFileLineNumbers "addons\LARs\blacklistArsenal\functions\fn_blacklistArsenal.sqf";
		LARs_fnc_initOverride = compileFinal preprocessFileLineNumbers "addons\LARs\blacklistArsenal\functions\override\fn_initOverride.sqf";
		LARs_fnc_overrideVAButtonDown = compileFinal preprocessFileLineNumbers "addons\LARs\blacklistArsenal\functions\override\fn_overrideVAButtonDown.sqf";
		LARs_fnc_overrideVATemplateOK = compileFinal preprocessFileLineNumbers "addons\LARs\blacklistArsenal\functions\override\fn_overrideVATemplateOK.sqf";		
		[] call LARs_fnc_initOverride;

		// Arma3 Virtual Arsenal 
		[myLARsBox, ["GRLIB_whitelisted_from_arsenal", "GRLIB_blacklisted_from_arsenal"], false, "Liberation", { false }] call LARs_fnc_blacklistArsenal;
		waitUntil {sleep 1; !isNil {myLARsBox getVariable "LARs_arsenal_Liberation_cargo"}};
		private _cargo = myLARsBox getVariable ["LARs_arsenal_Liberation_cargo", []];
		myLARsBox setVariable ["bis_addVirtualWeaponCargo_cargo", _cargo];
	};
};

// Init done
LRX_arsenal_init_done = true;

diag_log format ["--- LRX Arsenal initialized. blacklist: %1 - whitelist: %2", count GRLIB_blacklisted_from_arsenal, count GRLIB_whitelisted_from_arsenal];
diag_log format ["--- LRX MOD %1 use: %2 signatures", GRLIB_mod_west, count GRLIB_MOD_signature];
