params ["_sector", "_infsquad", "_squadies_to_spawn", "_mission_ai"];

if (opforcap_max) exitWith { grpNull };

diag_log format [ "Spawn regular squad type %1 (%2) at %3", _infsquad, count _squadies_to_spawn, time ];
private _safe_spawn = [(markerpos _sector), 5, -1, 130] call F_findSafePlace;
if (count _safe_spawn == 0) exitWith { grpNull };

private _grp = [_safe_spawn, _squadies_to_spawn, GRLIB_side_enemy, _infsquad, _mission_ai] call F_libSpawnUnits;
diag_log format [ "Done Spawning regular squad. (%1 - %2) at %3", _grp, count (units _grp), time ];

_grp;
