if (GRLIB_Patrol_manager == 0) exitWith {};
waitUntil {sleep 1; !isNil "GRLIB_A3W_Init"};
sleep (3*60);
diag_log "-- LRX Starting Patrol Manager";

// Infantry Patrol
_combat_triggers_infantry = [15,35,55];
if ( GRLIB_unitcap > 1.3 ) then { _combat_triggers_infantry = [15,35,55,75] };

// Armored Patrol
_combat_triggers_armor = [20,40,60];
if ( GRLIB_unitcap > 1.3 ) then { _combat_triggers_armor = [20,40,60,80] };

// Static Patrol
_combat_triggers_static = [25,45,65];
if ( GRLIB_unitcap > 1.3 ) then { _combat_triggers_static = [25,45,65,85] };

waitUntil { sleep 0.3; !isNil "blufor_sectors" };

{
	[_x, 1, _forEachIndex] execVM "scripts\server\patrols\manage_one_patrol.sqf";
	sleep 1;
} foreach _combat_triggers_infantry;

{
	[_x, 2, _forEachIndex] execVM "scripts\server\patrols\manage_one_patrol.sqf";
	sleep 1;
} foreach _combat_triggers_armor;

{
	[_x, 3, _forEachIndex] execVM "scripts\server\patrols\manage_one_patrol.sqf";
	sleep 1;
} foreach _combat_triggers_static;