params ["_sector", "_infsquad", "_squadies_to_spawn", "_mission_ai"];

if (opforcap_max) exitWith {grpNull};

diag_log format [ "Spawn regular squad type %1 (%2) at %3", _infsquad, count _squadies_to_spawn, time ];
private _max_try = 20;
private _pos = (markerpos _sector) getPos [(30 + floor random 100), floor random 360];
while {surfaceIsWater _pos && _max_try > 0 } do {
    _pos = (markerpos _sector) getPos [(30 + floor random 100), floor random 360];
    _max_try = _max_try - 1;
    sleep 0.1;
};
private _grp = [_pos, _squadies_to_spawn, GRLIB_side_enemy, _infsquad, _mission_ai] call F_libSpawnUnits;
diag_log format [ "Done Spawning regular squad. (%1 - %2) at %3", _grp, count (units _grp), time ];

_grp;
