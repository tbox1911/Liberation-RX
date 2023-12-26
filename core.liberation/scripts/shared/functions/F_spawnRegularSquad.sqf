params [ "_sector", "_infsquad", "_squadies_to_spawn" ];

diag_log format [ "Spawn regular squad type %1 (%2) at %3", _infsquad, count _squadies_to_spawn, time ];
private _pos = (markerpos _sector) getPos [(40 + floor random 80), random 360];
_pos set [2, 0.5];
private _grp = [_pos, _squadies_to_spawn, GRLIB_side_enemy, _infsquad] call F_libSpawnUnits;
diag_log format [ "Done Spawning regular squad. (%1 - %2) at %3", count (units _grp), _pos, time ];

_grp;
