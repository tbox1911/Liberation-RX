params [ "_sector", "_infsquad", "_squadies_to_spawn" ];
private [ "_spawnpos", "_max_try", "_grp", "_nextunit", "_corrected_amount" ];
diag_log format [ "Spawn regular squad type %1 (%2) at %3", _infsquad, count _squadies_to_spawn, time ];

_corrected_amount = round ( (count _squadies_to_spawn) * ([] call F_adaptiveOpforFactor) );
_grp = createGroup [GRLIB_side_enemy, true];
{
	if ( ( count units _grp ) < _corrected_amount) then {
		_spawnpos = zeropos;
		_max_try = 10;

		while { (_spawnpos isEqualTo zeropos) && _max_try > 0 } do {
			_spawnpos = [markerPos _sector, 0, GRLIB_capture_size, 1, 0, 0, 0, [], [zeropos, zeropos]] call BIS_fnc_findSafePos;
			_max_try = _max_try - 1;
		};
		if (!(_spawnpos isEqualTo zeropos)) then {
			_nextunit = _grp createUnit [_x, _spawnpos, [], 5, "NONE"];
			_nextunit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
			[_nextunit] joinSilent _grp;
			if ( _infsquad == "militia" ) then {
				[ _nextunit ] call loadout_militia;
			};
			[ _nextunit ] call reammo_ai;
		};
	};
	sleep 0.1;
} foreach _squadies_to_spawn;

diag_log format [ "Done Spawning regular squad (%1) at %2", count (units _grp), time ];

_grp;
