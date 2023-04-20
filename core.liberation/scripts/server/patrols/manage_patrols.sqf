if (GRLIB_Patrol_manager == 0) exitWith {};
waitUntil {sleep 0.5; !isNil "GRLIB_A3W_Init"};

// Infantry Patrol
_combat_triggers_infantry = [15,35,55,75];
if ( GRLIB_unitcap < 0.9 ) then { _combat_triggers_infantry = [15,35,75] };
if ( GRLIB_unitcap > 1.3 ) then { _combat_triggers_infantry = [10,20,40,60,70,80,90] };

// Armored Patrol
_combat_triggers_armor = [20,40,60,80];
if ( GRLIB_unitcap < 0.9 ) then { _combat_triggers_armor = [20,40,80] };
if ( GRLIB_unitcap > 1.3 ) then { _combat_triggers_armor = [15,25,45,65,75,85,95] };

// Static Patrol
_combat_triggers_static = [25,45,65,85];
if ( GRLIB_unitcap < 0.9 ) then { _combat_triggers_static = [25,45,85] };
if ( GRLIB_unitcap > 1.3 ) then { _combat_triggers_static = [15,25,45,65,75,85,95] };

waitUntil { sleep 0.3; !isNil "blufor_sectors" };
waitUntil { sleep 0.3; count blufor_sectors > 3 };

{
	[_x, 1, _forEachIndex] spawn manage_one_patrol;
	sleep 1;
} foreach _combat_triggers_infantry;

{
	[_x, 2, _forEachIndex] spawn manage_one_patrol;
	sleep 1;
} foreach _combat_triggers_armor;

{
	[_x, 3, _forEachIndex] spawn manage_one_patrol;
	sleep 1;
} foreach _combat_triggers_static;