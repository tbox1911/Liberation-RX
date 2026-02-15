params ["_sector_pos", "_infsquad", "_squadies_to_spawn", "_mission_ai"];

if (opforcap_max) exitWith { grpNull };

private _spawn_pos = [_sector_pos, (50 + floor random 100)] call F_getRandomPos;
private _spawn_safe = [_spawn_pos, 5, 0, 100] call F_findSafePlace;
if (count _spawn_safe == 0) exitWith { grpNull };

diag_log format ["Spawn regular squad type %1 (%2) on %3 at %4", _infsquad, count _squadies_to_spawn, _spawn_safe, time];

private _grp = [_spawn_safe, _squadies_to_spawn, GRLIB_side_enemy, _infsquad, _mission_ai] call F_libSpawnUnits;

diag_log format ["Done Spawning regular squad. (%1 - %2) at %3", _grp, count (units _grp), time];

_grp;
