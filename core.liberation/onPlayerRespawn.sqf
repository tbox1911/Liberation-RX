titleText ["" ,"BLACK FADED", 100];
player allowDamage false;
disableUserInput true;
if (GRLIB_ACE_medical_enabled) then {
	player call ACE_medical_treatment_fnc_fullHealLocal;
};
player setPosATL ((getmarkerpos GRLIB_respawn_marker) findEmptyPosition [0,50]);
GRLIB_player_spawned = false;
removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;

waitUntil {sleep 1; !isNil "GRLIB_init_server" };
player allowDamage true;

[] execVM "scripts\client\spawn\redeploy_manager.sqf";
[] execVM "scripts\client\misc\welcome.sqf";
