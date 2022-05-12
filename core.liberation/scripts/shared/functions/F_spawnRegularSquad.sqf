params [ "_sector", "_infsquad", "_squadies_to_spawn" ];

diag_log format [ "Spawn regular squad type %1 (%2) at %3", _infsquad, count _squadies_to_spawn, time ];
private _grp = [markerPos _sector, _squadies_to_spawn, GRLIB_side_enemy, _infsquad] call F_libSpawnUnits;
diag_log format [ "Done Spawning regular squad (%1) at %2", count (units _grp), time ];

_grp;
